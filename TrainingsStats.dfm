object TrainingStatsForm: TTrainingStatsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1090#1088#1077#1085#1080#1088#1086#1074#1086#1082
  ClientHeight = 478
  ClientWidth = 344
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object StatWrap: TScrollBox
    Left = -2
    Top = -5
    Width = 345
    Height = 479
    HorzScrollBar.Visible = False
    TabOrder = 0
  end
  object TempButton: TButton
    Left = 268
    Top = 449
    Width = 75
    Height = 25
    Caption = 'TempButton'
    TabOrder = 1
    OnClick = TempButtonClick
  end
end
