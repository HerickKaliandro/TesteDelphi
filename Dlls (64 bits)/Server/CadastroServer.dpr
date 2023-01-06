program ChatHorusServer;

uses
  Vcl.Forms,
  UnPrincipal in 'UnPrincipal.pas' {Form1},
  UnDadosDM in 'UnDadosDM.pas' {DMDados: TDataModule},
  UnChatHorus.Controller in 'UnChatHorus.Controller.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
