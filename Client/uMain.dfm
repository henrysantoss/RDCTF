object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 326
  ClientWidth = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object lblEquipe: TLabel
    Left = 6
    Top = 301
    Width = 290
    Height = 17
    Caption = 'Dupla: Henry Santos e Walcileine Kleinschmidt'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 18
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object redes: TLabel
    Left = 112
    Top = 0
    Width = 73
    Height = 32
    Caption = 'REDES'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 34
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 136
    Top = 30
    Width = 22
    Height = 23
    Caption = 'DE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 24
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 56
    Top = 48
    Width = 195
    Height = 32
    Caption = 'COMPUTADORES'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 34
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btn1: TButton
    Left = 64
    Top = 80
    Width = 177
    Height = 49
    Caption = 'Fase 1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 28
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 64
    Top = 135
    Width = 177
    Height = 49
    Caption = 'Fase 2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 28
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 64
    Top = 190
    Width = 177
    Height = 49
    Caption = 'Fase 3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 28
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btn3Click
  end
  object ClientSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = ClientSocketConnect
    OnError = ClientSocketError
    Left = 24
    Top = 40
  end
end
