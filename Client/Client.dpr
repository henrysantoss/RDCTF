program Client;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uFase in 'uFase.pas' {frmFase};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
