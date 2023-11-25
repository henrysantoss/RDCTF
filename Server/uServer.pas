unit uServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Win.ScktComp,
  FireDAC.Comp.Client, System.JSON;

type
  TfrmServer = class(TForm)
    ServerSocket: TServerSocket;
    memo: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ServerSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
  private
    { Private declarations }
    procedure GeraMarcacao();
    function BuscaFuncaoSocket(const psTexto: String): String;
    function BuscaJSONSocket(const psTexto: String): String;
    procedure RetornaImagemMonstro(const Socket: TCustomWinSocket; const psFuncao: String; const psJson: String);
    procedure EnviaAtaqueMonstro(const Socket: TCustomWinSocket; const psFuncao: String; const psJson: String);
    procedure RecebeAtaqueMonstro(const Socket: TCustomWinSocket; const psFuncao: String; const psJson: String);
    procedure CuraVida(const Socket: TCustomWinSocket; const psFuncao: String; const psJson: String);
    function GeraResposta(const psFuncao: String ;const psResposta: String): String;
  public
    { Public declarations }
  end;

var
  frmServer: TfrmServer;

implementation

{$R *.dfm}

function TfrmServer.BuscaFuncaoSocket(const psTexto: String): String;
var
  loLista: TArray<String>;
  lsFunc: String;
begin
  loLista := psTexto.Split(['&&']);
  lsFunc := loLista[0].Split(['='])[1];
  Result := lsFunc;
end;

function TfrmServer.BuscaJSONSocket(const psTexto: String): String;
begin
  Result := psTexto.Split(['&&'])[1];
end;

procedure TfrmServer.CuraVida(const Socket: TCustomWinSocket; const psFuncao,
  psJson: String);
var
  loJson: TJSonValue;
  liVida: Integer;
  liFase: Integer;
  loRetorno: TJSONObject;
  liRandom: Integer;
  lsRetorno: String;
begin
  loJson := nil;
  try
    loJson := TJSonObject.ParseJSONValue(psJson);
    liVida := loJson.GetValue<Integer>('VIDA');
    liFase := loJson.GetValue<Integer>('FASE');

    if (liFase = 1) then begin
      liRandom := Random(25) + 1;
    end else if (liFase = 2) then begin
      liRandom := Random(20) + 1;
    end else begin
      liRandom := Random(15) + 1;
    end;

    liVida := liVida + liRandom;
    if (liVida > 100) then begin
      liVida := 100;
    end;

    loRetorno := TJSONObject.Create;
    loRetorno.AddPair('VIDA', liVida);
    loRetorno.AddPair('MENSAGEM', 'VOCÊ | Cura Realizada = ' + IntToStr(liRandom));
    lsRetorno := GeraResposta(psFuncao, loRetorno.ToJSON);

    Memo.Lines.Add('RETORNO: ' + lsRetorno);
    Socket.SendText(lsRetorno);
  finally
    FreeAndNil(loJson);
  end;
end;

procedure TfrmServer.EnviaAtaqueMonstro(const Socket: TCustomWinSocket;
   const psFuncao: String; const psJson: String);
var
  loJson: TJSonValue;
  liVidaInimgo: Integer;
  loRetorno: TJSONObject;
  liRandom: Integer;
  lsRetorno: String;
begin
  loJson := nil;
  try
    loJson := TJSonObject.ParseJSONValue(psJson);
    liVidaInimgo := loJson.GetValue<Integer>('VIDA_INIMIGO');
    liRandom := Random(20) + 1;

    liVidaInimgo := liVidaInimgo - liRandom;
    if (liVidaInimgo < 0) then begin
      liVidaInimgo := 0;
    end;

    loRetorno := TJSONObject.Create;
    loRetorno.AddPair('VIDA_INIMIGO', liVidaInimgo);
    loRetorno.AddPair('DANO', liRandom);
    loRetorno.AddPair('MENSAGEM', 'VOCÊ | Dano Infligido =  ' + IntToStr(liRandom));
    lsRetorno := GeraResposta(psFuncao, loRetorno.ToJSON);

    Memo.Lines.Add('RETORNO: ' + lsRetorno);
    Socket.SendText(lsRetorno);
  finally
    FreeAndNil(loJson);
  end;
end;

procedure TfrmServer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ServerSocket.Close;
end;

procedure TfrmServer.FormCreate(Sender: TObject);
begin
  ServerSocket.Port := 2907;
  ServerSocket.Active := True;

  GeraMarcacao();
  Memo.Lines.Add('Servidor Conectado com Sucesso');
  Memo.Lines.Add('Porta: ' + IntToStr(ServerSocket.Port));
  Memo.Lines.Add(sLineBreak + 'Esperando conexão com o Cliente...');
end;

procedure TfrmServer.GeraMarcacao;
begin
  Memo.Lines.Add('');
  Memo.Lines.Add('---------- ' + DateTimeToStr(Now()) + ' ----------');
  Memo.Lines.Add('');
end;

function TfrmServer.GeraResposta(const psFuncao, psResposta: String): String;
begin
  Result := 'func='+ psFuncao + '&&' + psResposta;
end;

procedure TfrmServer.RecebeAtaqueMonstro(const Socket: TCustomWinSocket;
  const psFuncao, psJson: String);
var
  loJson: TJSonValue;
  liVida: Integer;
  liFase: Integer;
  loRetorno: TJSONObject;
  liRandom: Integer;
  lsRetorno: String;
begin
  loJson := nil;
  try
    loJson := TJSonObject.ParseJSONValue(psJson);
    liVida := loJson.GetValue<Integer>('VIDA');
    liFase := loJson.GetValue<Integer>('FASE');

    if (liFase = 1) then begin
      liRandom := Random(20) + 1;
    end else if (liFase = 2) then begin
      liRandom := Random(25) + 1;
    end else begin
      liRandom := Random(30) + 1;
    end;

    if (liFase = 3) then begin
      if (liRandom < 5) then begin
        liRandom := 5;
      end;
    end;

    liVida := liVida - liRandom;
    if (liVida < 0) then begin
      liVida := 0;
    end;

    loRetorno := TJSONObject.Create;
    loRetorno.AddPair('VIDA', liVida);
    loRetorno.AddPair('DANO_INIMIGO', liRandom);
    loRetorno.AddPair('MENSAGEM', 'INIMIGO | Dano Infligido = ' + IntToStr(liRandom));
    lsRetorno := GeraResposta(psFuncao, loRetorno.ToJSON);

    Memo.Lines.Add('RETORNO: ' + lsRetorno);
    Socket.SendText(lsRetorno);
  finally
    FreeAndNil(loJson);
  end;
end;

procedure TfrmServer.RetornaImagemMonstro(const Socket: TCustomWinSocket;
 const psFuncao: String; const psJson: String);
var
  loJson: TJSonValue;
  lsFase: String;
  lsImagem: String;
begin
  loJson := nil;
  try
    loJson := TJSonObject.ParseJSONValue(psJson);
    lsFase := loJson.GetValue<string>('FASE');
    lsImagem := ExtractFilePath(ParamStr(0)) + 'monstros\fase'+ lsFase +'.png';
    Socket.SendText(GeraResposta(psFuncao, lsImagem));
  finally
    FreeAndNil(loJson);
  end;
end;

procedure TfrmServer.ServerSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  GeraMarcacao();
  memo.Lines.Add('Cliente conectado com sucesso');
end;

procedure TfrmServer.ServerSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  GeraMarcacao();
  memo.Lines.Add('Cliente foi Desconectado');
end;

procedure TfrmServer.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  lsTexto: String;
  lsFuncao: String;
  lsJSON: String;
begin
  lsTexto := Socket.ReceiveText;

  GeraMarcacao();
  Memo.Lines.Add(lsTexto);

  lsFuncao := BuscaFuncaoSocket(lsTexto);
  lsJSON := BuscaJSONSocket(lsTexto);

  if (lsFuncao = 'BuscaImagem') then begin
    RetornaImagemMonstro(Socket, lsFuncao, lsJson);
  end else if (lsFuncao = 'EnviaAtaque') then begin
    EnviaAtaqueMonstro(Socket, lsFuncao, lsJson);
  end else if (lsFuncao = 'RecebeAtaque') then begin
    RecebeAtaqueMonstro(Socket, lsFuncao, lsJson);
  end else if (lsFuncao = 'CuraVida') then begin
    CuraVida(Socket, lsFuncao, lsJson);
  end;
end;

end.
