object ExsRealiseForm: TExsRealiseForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Template'
  ClientHeight = 127
  ClientWidth = 171
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
  object NameOfTheExercisesLabel: TLabel
    Left = 8
    Top = 8
    Width = 44
    Height = 13
    Caption = 'Template'
  end
  object TimesLabel: TLabel
    Left = 8
    Top = 37
    Width = 127
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1074#1090#1086#1088#1077#1085#1080#1081':'
  end
  object WeightLabel: TLabel
    Left = 8
    Top = 83
    Width = 82
    Height = 13
    Caption = #1042#1099#1073#1088#1072#1085#1085#1099#1081' '#1074#1077#1089':'
  end
  object Times: TEdit
    Left = 8
    Top = 56
    Width = 153
    Height = 21
    TabOrder = 0
    TextHint = #1055#1086#1074#1090#1086#1088#1077#1085#1080#1103' ('#1088#1072#1079')'
  end
  object Weight: TEdit
    Left = 8
    Top = 102
    Width = 153
    Height = 21
    TabOrder = 1
    TextHint = #1042#1077#1089' ('#1082#1075')'
  end
  object Next: TButton
    Left = 86
    Top = 8
    Width = 75
    Height = 25
    Caption = #1057#1083#1077#1076#1091#1102#1097#1077#1077
    TabOrder = 2
    OnClick = NextClick
  end
end
