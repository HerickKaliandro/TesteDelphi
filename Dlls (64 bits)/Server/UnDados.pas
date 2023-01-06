unit UnDados;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDmDados = class(TDataModule)
    FDConnection1: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);

  public
    Function InserirPessoa(Nome, Usuario, Senha, Fone, Cpf, Email,
      DescricaoPerfil: String): String;
    Function InserirMensagem(IdChat, IdPessoa: Integer;
      Mensagem: String): String;

    Function BuscarDadosSql(ASql: String): TFDQuery;
    Function BuscarIdUltimaMsg: Integer;
    Function BuscarMensagensChat(IdChat, IdUsuario, IdMsg: Integer): String;

  end;

var
  DmDados: TDmDados;

implementation

Uses
  DataSet.Serialize, DataSet.Serialize.Config;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TDmDados }

function TDmDados.BuscarDadosSql(ASql: String): TFDQuery;
begin
  Result := TFDQuery.Create(Nil);
  Result.Connection := FDConnection1;

  Result.SQL.Text := ASql;
  Result.Open;
end;

function TDmDados.BuscarIdUltimaMsg: Integer;
var
  qry: TFDQuery;
begin
  qry := BuscarDadosSql('SELECT MAX(ID) AS ID FROM MENSAGEM');
  try
    Result := qry.FieldByName('ID').AsInteger;
  finally
    qry.Free;
  end;
end;

function TDmDados.BuscarMensagensChat(IdChat, IdUsuario, IdMsg: Integer): String;
var
  qry: TFDQuery;
  idInserido: Integer;
begin
  qry := TFDQuery.Create(Nil);
  try
    qry.Connection := FDConnection1;

    qry.SQL.Text :=
      'SELECT MENSAGEM.ID, MENSAGEM.IDPESSOA,                     ' +
      '       MENSAGEM.MENSAGEM, MENSAGEM.DATAHORA,                 ' +
      ' 	    IIF(MENSAGEM.IDPESSOA = :IDUSUARIO, ''sim'', ''nao'') ' +
      '        AS proprioautor,                                     ' +
      ' 	    COALESCE(APELIDO.APELIDO, PESSOA.NOME) AS NOME          ' +
      ' FROM MENSAGEM                                               ' +
      ' JOIN PESSOA ON (PESSOA.ID = MENSAGEM.IDPESSOA)               ' +
      ' LEFT JOIN APELIDO ON (PESSOA.ID = APELIDO.IDPESSOA_APELIDADA ' +
      ' 			    AND APELIDO.IDPESSOA_APELIDOU = :IDUSUARIO)        ' +
      ' WHERE MENSAGEM.IDCHAT = :IDCHAT                              ' +
      '   AND MENSAGEM.ID > :IDMENSAGEM ' +
      ' ORDER BY MENSAGEM.DATAHORA  ';

    qry.ParamByName('IDUSUARIO').AsInteger := IdUsuario;
    qry.ParamByName('IDCHAT').AsInteger := IdChat;
    qry.ParamByName('IDMENSAGEM').AsInteger := IdMsg;

    qry.Open;

    Result := qry.ToJSONArrayString;
  finally
    qry.Free;
  end;
end;

procedure TDmDados.DataModuleCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';
  TDataSetSerializeConfig.GetInstance.DateIsFloatingPoint := True;
  //TDataSetSerializeConfig.GetInstance.DateTimeIsISO8601 := True;
end;

function TDmDados.InserirMensagem(IdChat, IdPessoa: Integer;
  Mensagem: String): String;
var
  qry: TFDQuery;
  idInserido: Integer;
begin
  qry := TFDQuery.Create(Nil);
  try
    qry.Connection := FDConnection1;

    qry.SQL.Text :=
      'INSERT INTO MENSAGEM ( ' +
      '   idchat, idpessoa, mensagem, datahora, editada)' +
      ' values (:idchat, :idpessoa, :mensagem, :datahora, :editada) ' +
      ' returning id, idchat, idpessoa, mensagem, datahora, editada;';

    qry.ParamByName('idchat').AsInteger := IdChat;
    qry.ParamByName('idpessoa').AsInteger := IdPessoa;
    qry.ParamByName('mensagem').AsString := Mensagem;
    qry.ParamByName('datahora').AsDateTime := Now;
    qry.ParamByName('editada').AsBoolean := False;

    qry.Open;

    Result := qry.ToJSONArrayString;

  finally
    qry.Free;
  end;
end;

function TDmDados.InserirPessoa(Nome, Usuario, Senha, Fone, Cpf,
  Email, DescricaoPerfil: String): String;
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Nil);
  try
    qry.Connection := FDConnection1;

    qry.SQL.Clear;
    qry.SQL.add(
      'INSERT INTO PESSOA ( ' +
      '   nome, usuario, senha, fone, cpf, email, descricao_perfil ) ' +
      ' values (:nome, :usuario, :senha, :fone, :cpf, :email, :desc) ' +
      ' returning id, nome, usuario, senha, fone, cpf, email, descricao_perfil');

    qry.ParamByName('nome').AsString := Nome;
    qry.ParamByName('usuario').AsString := Usuario;
    qry.ParamByName('senha').AsString := Senha;
    qry.ParamByName('fone').AsString := Fone;
    qry.ParamByName('cpf').AsString := Cpf;
    qry.ParamByName('email').AsString := Email;
    qry.ParamByName('desc').AsString := DescricaoPerfil;

    qry.Open;

    Result := qry.ToJSONArrayString;

  finally
    qry.Free;
  end;
end;

end.
