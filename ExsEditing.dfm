object EditForm: TEditForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1088#1077#1085#1080#1088#1086#1074#1082#1080
  ClientHeight = 149
  ClientWidth = 286
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object NameLabel: TLabel
    Left = 24
    Top = 3
    Width = 123
    Height = 15
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1090#1088#1077#1085#1080#1088#1086#1074#1082#1080':'
  end
  object DescriptionLabel: TLabel
    Left = 24
    Top = 64
    Width = 126
    Height = 15
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1090#1088#1077#1085#1080#1088#1086#1074#1082#1080':'
  end
  object IsWeightedCheck: TCheckBox
    Left = 24
    Top = 124
    Width = 177
    Height = 17
    Caption = #1048#1084#1077#1077#1090' '#1083#1080' '#1091#1087#1088#1072#1078#1085#1077#1085#1080#1077' '#1074#1077#1089'?'
    TabOrder = 0
  end
  object SaveButton: TButton
    Left = 190
    Top = 23
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 1
  end
  object Desciption: TEdit
    Left = 24
    Top = 85
    Width = 241
    Height = 23
    TabOrder = 2
    TextHint = #1054#1087#1080#1089#1072#1085#1080#1077
  end
  object NameOfTheTraining: TEdit
    Left = 24
    Top = 24
    Width = 121
    Height = 23
    TabOrder = 3
    TextHint = #1053#1072#1079#1074#1072#1085#1080#1077
  end
end