unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Datasnap.DSCommon, Vcl.StdCtrls, uFase,
  System.Win.ScktComp, System.IniFiles;

type
  TfrmMain = class(TForm)
    lblEquipe: TLabel;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    redes: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    ClientSocket: TClientSocket;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btn1Click(Sender: TObject);
var
  loForm: TfrmFase;
begin
  loForm := nil;
  try
    try
      loForm := TfrmFase.Create(Self);
      loForm.IdFase := 1;
      loForm.ShowModal;
    finally
      loForm.Release;
    end;
  finally
    FreeAndNil(loForm);
  end;
end;

procedure TfrmMain.btn2Click(Sender: TObject);
var
  loForm: TfrmFase;
begin
  loForm := nil;
  try
    try
      loForm := TfrmFase.Create(Self);
      loForm.IdFase := 2;
      loForm.ShowModal;
    finally
      loForm.Release;
    end;
  finally
    FreeAndNil(loForm);
  end;
end;

procedure TfrmMain.btn3Click(Sender: TObject);
var
  loForm: TfrmFase;
begin
  loForm := nil;
  try
    try
      loForm := TfrmFase.Create(Self);
      loForm.IdFase := 3;
      loForm.ShowModal;
    finally
      loForm.Release;
    end;
  finally
    FreeAndNil(loForm);
  end;
end;

procedure TfrmMain.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  if not ClientSocket.Socket.Connected then begin
    ShowMessage('Não foi possível conectar ao servidor.');
    Application.Destroy;
  end;
end;

procedure TfrmMain.ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ShowMessage('Não foi possível conectar ao servidor.');
  Application.Destroy;
  Halt;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ClientSocket.Active := False;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  ArquivoIni: TIniFile;
  Porta: Integer;
  IP: string;
begin
  ArquivoIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  try
    Porta := ArquivoIni.ReadInteger('Configuracoes', 'Porta', 2907);
    IP := ArquivoIni.ReadString('Configuracoes', 'IP', '127.0.0.1');
  finally
    ArquivoIni.Free;
  end;

  ClientSocket.Port := Porta;
  ClientSocket.Host := IP;
  ClientSocket.Active := True;
end;

end.
