object fmMain: TfmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Maze'
  ClientHeight = 463
  ClientWidth = 742
  Color = clBtnFace
  Constraints.MaxHeight = 510
  Constraints.MaxWidth = 760
  Constraints.MinHeight = 510
  Constraints.MinWidth = 760
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object pntMaze: TPaintBox
    Left = 0
    Top = 0
    Width = 460
    Height = 460
  end
  object btnGenerate: TButton
    Left = 512
    Top = 48
    Width = 179
    Height = 49
    Caption = #1053#1086#1074#1099#1081' '#1083#1072#1073#1080#1088#1080#1085#1090
    TabOrder = 0
  end
  object btnFindExit: TButton
    Left = 512
    Top = 144
    Width = 179
    Height = 49
    Caption = #1053#1072#1081#1090#1080' '#1074#1099#1093#1086#1076
    TabOrder = 1
  end
  object btnExit: TButton
    Left = 512
    Top = 360
    Width = 179
    Height = 49
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 2
  end
end
