object Menu: TMenu
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1043#1083#1072#1074#1085#1072#1103
  ClientHeight = 193
  ClientWidth = 278
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object LoginCautionMessage: TLabel
    Left = 8
    Top = 172
    Width = 261
    Height = 13
    Caption = #1044#1083#1103' '#1076#1072#1083#1100#1085#1077#1081#1096#1080#1093' '#1076#1077#1081#1089#1090#1074#1080#1081' '#1090#1088#1077#1073#1091#1077#1090#1089#1103' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
  end
  object UserName: TLabel
    Left = 8
    Top = 13
    Width = 86
    Height = 13
    Caption = 'Name of The User'
    Visible = False
  end
  object Login: TButton
    Left = 194
    Top = 8
    Width = 75
    Height = 25
    Caption = #1042#1086#1081#1090#1080
    TabOrder = 0
    OnClick = LoginClick
  end
  object EnterTheTraining: TButton
    Left = 104
    Top = 48
    Width = 75
    Height = 25
    Caption = 'EnterTheTraining'
    Enabled = False
    TabOrder = 1
  end
  object CreateNewTraining: TButton
    Left = 104
    Top = 79
    Width = 75
    Height = 25
    Caption = 'CreateNewTraining'
    Enabled = False
    TabOrder = 2
  end
  object CreateNewExercise: TButton
    Left = 104
    Top = 110
    Width = 75
    Height = 25
    Caption = 'CreateNewExercise'
    Enabled = False
    TabOrder = 3
  end
  object ShowTheStatistics: TButton
    Left = 104
    Top = 141
    Width = 75
    Height = 25
    Caption = 'ShowTheStatistics'
    Enabled = False
    TabOrder = 4
  end
end
