program Server;

uses
  Vcl.Forms,
  uServer in 'uServer.pas' {frmServer};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmServer, frmServer);
  Application.Run;
end.
