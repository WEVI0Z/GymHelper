object CreateTrainingForm: TCreateTrainingForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1090#1088#1077#1085#1080#1088#1086#1074#1082#1080
  ClientHeight = 404
  ClientWidth = 247
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
  object NameLabel: TLabel
    Left = 8
    Top = 8
    Width = 111
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1090#1088#1077#1085#1080#1088#1086#1074#1082#1080
  end
  object NameOfTheTraining: TEdit
    Left = 8
    Top = 24
    Width = 150
    Height = 21
    TabOrder = 0
    TextHint = #1053#1072#1079#1074#1072#1085#1080#1077' '#1090#1088#1077#1085#1080#1088#1086#1074#1082#1080
  end
  object ExsWrap: TScrollBox
    Left = 8
    Top = 51
    Width = 150
    Height = 334
    HorzScrollBar.Visible = False
    TabOrder = 1
  end
  object AddExs: TButton
    Left = 164
    Top = 8
    Width = 75
    Height = 41
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1091#1087#1088#1072#1078#1085#1077#1085#1080#1077
    TabOrder = 2
    WordWrap = True
    OnClick = AddExsClick
  end
  object CreateTraining: TButton
    Left = 164
    Top = 344
    Width = 75
    Height = 41
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1090#1088#1077#1085#1080#1088#1086#1074#1082#1091
    TabOrder = 3
    WordWrap = True
    OnClick = CreateTrainingClick
  end
end