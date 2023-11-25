object frmFase: TfrmFase
  Left = 0
  Top = 0
  Caption = 'frmFase'
  ClientHeight = 576
  ClientWidth = 1104
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnShow = FormShow
  TextHeight = 15
  object imgMonstro: TImage
    Left = 168
    Top = 74
    Width = 385
    Height = 337
    Stretch = True
  end
  object turno: TLabel
    Left = 256
    Top = 8
    Width = 247
    Height = 60
    Alignment = taCenter
    Caption = 'SEU TURNO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = 60
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 16
    Top = 112
    Width = 133
    Height = 36
    Caption = 'SEU DANO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = 36
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 567
    Top = 216
    Width = 193
    Height = 36
    Caption = 'DANO INIMIGO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clCrimson
    Font.Height = 36
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 87
    Top = 448
    Width = 62
    Height = 36
    Caption = 'VIDA'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotpink
    Font.Height = 36
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 311
    Top = 448
    Width = 101
    Height = 36
    Caption = 'PO'#199#213'ES'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotpink
    Font.Height = 36
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVida: TLabel
    Left = 63
    Top = 490
    Width = 116
    Height = 36
    Caption = '100 / 100'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = -1
    Font.Height = 36
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblPocao: TLabel
    Left = 328
    Top = 490
    Width = 56
    Height = 36
    Caption = '5 / 5'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = -1
    Font.Height = 36
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDano: TLabel
    Left = 63
    Top = 154
    Width = 15
    Height = 36
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = -1
    Font.Height = 36
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblInimigoDano: TLabel
    Left = 653
    Top = 258
    Width = 15
    Height = 36
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = -1
    Font.Height = 36
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 576
    Top = 96
    Width = 177
    Height = 36
    Caption = 'VIDA INIMIGO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clCrimson
    Font.Height = 36
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblInimigoVida: TLabel
    Left = 605
    Top = 138
    Width = 116
    Height = 36
    Caption = '100 / 100'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = -1
    Font.Height = 36
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 512
    Top = 442
    Width = 209
    Height = 44
    Caption = 'ATACAR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 24
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 512
    Top = 508
    Width = 209
    Height = 44
    Caption = 'USAR PO'#199#195'O'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 24
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo: TMemo
    Left = 760
    Top = 1
    Width = 345
    Height = 576
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
