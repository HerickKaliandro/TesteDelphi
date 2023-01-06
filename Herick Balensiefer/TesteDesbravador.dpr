program TesteDesbravador;

uses
  Vcl.Forms,
  UntCadastro in 'UntCadastro.pas' {UnitCadastro};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TUnitCadastro, UnitCadastro);
  Application.Run;
end.
