object fmMain: TfmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Maze'
  ClientHeight = 553
  ClientWidth = 757
  Color = clBtnFace
  Constraints.MaxHeight = 600
  Constraints.MaxWidth = 775
  Constraints.MinHeight = 600
  Constraints.MinWidth = 775
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 120
  TextHeight = 16
  object pntMaze: TPaintBox
    Left = 0
    Top = 0
    Width = 585
    Height = 585
  end
  object btnGenerate: TButton
    Left = 559
    Top = 40
    Width = 179
    Height = 49
    Caption = #1053#1086#1074#1099#1081' '#1083#1072#1073#1080#1088#1080#1085#1090
    TabOrder = 0
    OnClick = btnGenerateClick
  end
  object btnFindExit: TButton
    Left = 559
    Top = 136
    Width = 179
    Height = 49
    Caption = #1053#1072#1081#1090#1080' '#1074#1099#1093#1086#1076
    TabOrder = 1
    OnClick = btnFindExitClick
  end
  object btnExit: TButton
    Left = 559
    Top = 392
    Width = 179
    Height = 49
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 2
    OnClick = btnExitClick
  end
  object btnPlay: TButton
    Left = 559
    Top = 232
    Width = 179
    Height = 49
    Caption = #1048#1075#1088#1072#1090#1100
    TabOrder = 3
    OnClick = btnPlayClick
  end
end
