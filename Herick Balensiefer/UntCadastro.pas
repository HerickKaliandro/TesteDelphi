unit UntCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons;

type
  TUnitCadastro = class(TForm)
    EdtNome: TEdit;
    EdtSobrenome: TEdit;
    EdtCidade: TEdit;
    EdtBairro: TEdit;
    EdtLogradouro: TEdit;
    EdtComplemento: TEdit;
    lblPessoa: TLabel;
    lblEndereco: TLabel;
    lblNome: TLabel;
    lblSobrenome: TLabel;
    LblCep: TLabel;
    EdtCep: TMaskEdit;
    LblCidade: TLabel;
    LblUf: TLabel;
    LblBairro: TLabel;
    LblLogradouro: TLabel;
    LblComplemento: TLabel;
    CBUf: TComboBox;
    BtnEnviar: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UnitCadastro: TUnitCadastro;

implementation

{$R *.dfm}

end.
