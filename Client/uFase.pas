unit uFase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ScktComp, System.JSON,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.Imaging.GIFImg;

type
  TfrmFase = class(TForm)
    imgMonstro: TImage;
    turno: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label5: TLabel;
    Label3: TLabel;
    lblVida: TLabel;
    lblPocao: TLabel;
    lblDano: TLabel;
    lblInimigoDano: TLabel;
    Label7: TLabel;
    lblInimigoVida: TLabel;
    Memo: TMemo;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FIdFase: Integer;
    FVida: Integer;
    FPocao: Integer;
    FDano: Integer;
    FInimigoDano: Integer;
    FInimigoVida: Integer;
    FMaxInimigoVida: Integer;
    FUtilizouCura: Boolean;
    procedure BuscarImagem();
    procedure AlteraVida(const piVida: Integer);
    procedure AlteraPocao(const piPocao: Integer);
    procedure AlteraDano(const piDano: Integer);
    procedure AlteraInimigoDano(const piDano: Integer);
    procedure AlteraInimigoVida(const piVida: Integer);
    function GeraEnvio(const psFuncao: String; const poJSON: TJSONObject = nil): String;
    procedure AlteraLabel(const piAcao: Integer);
    procedure EnviaAtaqueInimigo();
    procedure RecebeAtaqueInimigo();
    procedure Cura();
    function FiltraResposta(const psResposta: String): String;
  public
    { Public declarations }
    property IdFase: Integer read FIdFase write FIdFase;
  end;

var
  frmFase: TfrmFase;

implementation

{$R *.dfm}

uses uMain;

procedure TfrmFase.AlteraDano(const piDano: Integer);
begin
  FDano := piDano;
  lblDano.Caption := IntToStr(FDano);
end;

procedure TfrmFase.AlteraInimigoDano(const piDano: Integer);
begin
  FInimigoDano := piDano;
  lblInimigoDano.Caption := IntToStr(FInimigoDano);
end;

procedure TfrmFase.AlteraInimigoVida(const piVida: Integer);
begin
  FInimigoVida := piVida;
  lblInimigoVida.Caption := IntToStr(FInimigoVida) + ' / ' + IntToStr(FMaxInimigoVida);
end;

procedure TfrmFase.AlteraLabel(const piAcao: Integer);
begin
  if (piAcao = 1) then begin
    turno.Caption := 'SEU TURNO';
    turno.Font.Color := clHighlight;
  end else if (piAcao = 2) then begin
    turno.Caption := 'GIRANDO DADOS...';
    turno.Font.Color := clPurple;
  end else if (piAcao = 3) then begin
    turno.Caption := 'TURNO INIMIGO';
    turno.Font.Color := clRed;
  end;
end;

procedure TfrmFase.AlteraPocao(const piPocao: Integer);
begin
  FPocao := piPocao;
  lblPocao.Caption := IntToStr(FPocao) + ' / 5';
end;

procedure TfrmFase.AlteraVida(const piVida: Integer);
begin
  FVida := piVida;
  lblVida.Caption := IntToStr(piVida) + ' / 100';
end;

procedure TfrmFase.BuscarImagem;
var
  loJson: TJSONObject;
  lsEnvio: String;
  lsImagem: String;
  lsRecebido: String;
begin
  loJson := TJSONObject.Create;
  loJson.AddPair('FASE', FIdFase);
  lsEnvio := GeraEnvio('BuscaImagem', loJson);
  frmMain.ClientSocket.Socket.SendText(lsEnvio);

  lsRecebido := '';
  repeat
    lsRecebido := frmMain.ClientSocket.Socket.ReceiveText;
  until not lsRecebido.IsEmpty;
  lsImagem := FiltraResposta(lsRecebido);

  imgMonstro.Picture.LoadFromFile(lsImagem);
end;

procedure TfrmFase.Button1Click(Sender: TObject);
begin
  FUtilizouCura := False;
  AlteraLabel(2);
  Application.ProcessMessages;
  Sleep(2000);
  EnviaAtaqueInimigo();
  Application.ProcessMessages;
  Sleep(500);

  if (FInimigoVida <= 0) then begin
    ShowMessage('PARABÉNS! Você derrotou o Inimigo');
    Self.CloseModal;
    Self.Close;
    Exit;
  end;

  AlteraLabel(3);
  Application.ProcessMessages;
  Sleep(2500);
  RecebeAtaqueInimigo();
  Application.ProcessMessages;
  Sleep(500);

  if (FVida <= 0) then begin
    ShowMessage('QUE PENA! Você morreu antes de derrotar o Inimigo');
    Self.CloseModal;
    Self.Close;
    Exit;
  end;

  AlteraLabel(1);
end;

procedure TfrmFase.Button2Click(Sender: TObject);
begin
  if (FPocao <= 0) then begin
    ShowMessage('Você não tem mais poções para utilizar');
    Exit;
  end;

  if (FUtilizouCura) then begin
    ShowMessage('Você já utilizou uma poção de cura este Round, Ataque!');
    Exit;
  end;
  FUtilizouCura := True;
  AlteraLabel(2);
  Application.ProcessMessages;
  Sleep(2000);
  Cura();
  Application.ProcessMessages;
  Sleep(500);
  AlteraLabel(1);
end;

procedure TfrmFase.Cura;
var
  loJson: TJSONObject;
  lsEnvio: String;
  lsRecebido: String;
  loRetorno: TJSONValue;
begin
  loRetorno := nil;
  try
    loJson := TJSONObject.Create;
    loJson.AddPair('FASE', IdFase);
    loJson.AddPair('VIDA', FVida);

    lsEnvio := GeraEnvio('CuraVida', loJson);
    frmMain.ClientSocket.Socket.SendText(lsEnvio);

    repeat
      lsRecebido := frmMain.ClientSocket.Socket.ReceiveText;
    until not lsRecebido.IsEmpty;

    loRetorno := TJSonObject.ParseJSONValue(FiltraResposta(lsRecebido));
    AlteraVida(loRetorno.GetValue<Integer>('VIDA'));
    AlteraPocao(FPocao - 1);
    Memo.Lines.Add(loRetorno.GetValue<String>('MENSAGEM'));
  finally
    FreeAndNil(loRetorno);
  end;
end;

procedure TfrmFase.EnviaAtaqueInimigo;
var
  loJson: TJSONObject;
  lsEnvio: String;
  lsRecebido: String;
  loRetorno: TJSONValue;
begin
  loRetorno := nil;
  try
    loJson := TJSONObject.Create;
    loJson.AddPair('VIDA_INIMIGO', FInimigoVida);

    lsEnvio := GeraEnvio('EnviaAtaque', loJson);
    frmMain.ClientSocket.Socket.SendText(lsEnvio);

    repeat
      lsRecebido := frmMain.ClientSocket.Socket.ReceiveText;
    until not lsRecebido.IsEmpty;

    loRetorno := TJSonObject.ParseJSONValue(FiltraResposta(lsRecebido));
    AlteraDano(loRetorno.GetValue<Integer>('DANO'));
    AlteraInimigoVida(loRetorno.GetValue<Integer>('VIDA_INIMIGO'));
    Memo.Lines.Add(loRetorno.GetValue<String>('MENSAGEM'));
  finally
    FreeAndNil(loRetorno);
  end;
end;

function TfrmFase.FiltraResposta(const psResposta: String): String;
var
  lsResultado:  String;
begin
  lsResultado := psResposta.Split(['&&'])[1];
  Result := lsResultado;
end;

procedure TfrmFase.FormShow(Sender: TObject);
begin
  BuscarImagem();

  FVida := 100;
  FPocao := 5;
  FDano := 0;
  FInimigoDano := 0;

  if (IdFase = 1) then begin
    FInimigoVida := 100;
  end else if (IdFase = 2) then begin
    FInimigoVida := 105;
  end else if (IdFase = 3) then begin
    FInimigoVida := 115;
  end;
  FMaxInimigoVida := FInimigoVida;

  AlteraVida(FVida);
  AlteraPocao(FPocao);
  AlteraDano(FDano);
  AlteraInimigoDano(FInimigoDano);
  AlteraInimigoVida(FInimigoVida);
end;

function TfrmFase.GeraEnvio(const psFuncao: String; const poJSON: TJSONObject = nil): String;
var
  lsJson: String;
begin
  lsJson := '';
  if (Assigned(poJson)) then begin
    lsJson := poJSON.ToJSON
  end;

  Result := 'func='+ psFuncao + '&&' + lsJson;
end;

procedure TfrmFase.RecebeAtaqueInimigo;
var
  loJson: TJSONObject;
  lsEnvio: String;
  lsRecebido: String;
  loRetorno: TJSONValue;
begin
  loRetorno := nil;
  try
    loJson := TJSONObject.Create;
    loJson.AddPair('FASE', IdFase);
    loJson.AddPair('VIDA', FVida);

    lsEnvio := GeraEnvio('RecebeAtaque', loJson);
    frmMain.ClientSocket.Socket.SendText(lsEnvio);

    repeat
      lsRecebido := frmMain.ClientSocket.Socket.ReceiveText;
    until not lsRecebido.IsEmpty;

    loRetorno := TJSonObject.ParseJSONValue(FiltraResposta(lsRecebido));
    AlteraInimigoDano(loRetorno.GetValue<Integer>('DANO_INIMIGO'));
    AlteraVida(loRetorno.GetValue<Integer>('VIDA'));
    Memo.Lines.Add(loRetorno.GetValue<String>('MENSAGEM'));
  finally
    FreeAndNil(loRetorno);
  end;
end;

end.
