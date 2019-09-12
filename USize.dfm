object fmSize: TfmSize
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  ClientHeight = 184
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object txtSizeQuestion: TStaticText
    Left = 72
    Top = 18
    Width = 211
    Height = 20
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1088#1072#1079#1084#1077#1088#1085#1086#1089#1090#1100' '#1083#1072#1073#1080#1088#1080#1085#1090#1072':'
    TabOrder = 0
  end
  object rbtSize9: TRadioButton
    Left = 72
    Top = 52
    Width = 113
    Height = 17
    Caption = '9x9'
    TabOrder = 1
    OnClick = rbtSize9Click
  end
  object rbtSize15: TRadioButton
    Left = 72
    Top = 82
    Width = 113
    Height = 17
    Caption = '15x15'
    TabOrder = 2
    OnClick = rbtSize15Click
  end
  object rbtSize39: TRadioButton
    Left = 72
    Top = 114
    Width = 113
    Height = 17
    Caption = '39x39'
    TabOrder = 3
    OnClick = rbtSize39Click
  end
  object btnOk: TButton
    Left = 144
    Top = 137
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 4
    OnClick = btnOkClick
  end
end
