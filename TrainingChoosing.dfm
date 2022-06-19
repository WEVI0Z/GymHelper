object TrainingChooseForm: TTrainingChooseForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1099#1073#1086#1088' '#1090#1088#1077#1085#1080#1088#1086#1074#1082#1080
  ClientHeight = 499
  ClientWidth = 337
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
  object TrainingsWrap: TScrollBox
    Left = 8
    Top = 8
    Width = 321
    Height = 484
    TabOrder = 0
  end
  object TempButton: TButton
    Left = 254
    Top = 466
    Width = 75
    Height = 25
    Caption = 'TempButton'
    TabOrder = 1
    OnClick = TempButtonClick
  end
end
