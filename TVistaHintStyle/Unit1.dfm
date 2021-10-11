object Form1: TForm1
  Left = 237
  Top = 130
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'TVistaHintStyle'
  ClientHeight = 185
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 233
    Height = 33
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 8
      Width = 192
      Height = 16
      Caption = #1057#1090#1080#1083#1100' '#1087#1086#1076#1089#1082#1072#1079#1082#1080' Windows XP '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnMouseEnter = Label1MouseEnter
    end
  end
  object Panel2: TPanel
    Left = 8
    Top = 96
    Width = 233
    Height = 33
    TabOrder = 1
    object Label2: TLabel
      Left = 16
      Top = 8
      Width = 202
      Height = 16
      Hint = 'sdgsf  gsfgsfgs ergrgertgerg stretertertertre ery'
      Caption = #1057#1090#1080#1083#1100' '#1087#1086#1076#1089#1082#1072#1079#1082#1080' Windows Vista'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnMouseEnter = Label2MouseEnter
    end
  end
end
