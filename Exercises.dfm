object Actions: TActions
  Left = 0
  Top = 0
  VertScrollBar.ButtonSize = 3
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1052#1077#1085#1077#1076#1078#1077#1088' '#1091#1087#1088#1072#1078#1085#1077#1085#1080#1081
  ClientHeight = 500
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object ListOfTheExsLabel: TLabel
    Left = 8
    Top = 8
    Width = 155
    Height = 15
    Caption = #1057#1087#1080#1089#1086#1082' '#1074#1072#1096#1080#1093' '#1091#1087#1088#1072#1078#1085#1077#1085#1080#1081':'
  end
  object CreateNewExs: TButton
    Left = 275
    Top = 8
    Width = 89
    Height = 53
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1086#1077' '#1091#1087#1088#1072#1078#1085#1077#1085#1080#1077
    TabOrder = 0
    WordWrap = True
  end
  object Button1: TButton
    Left = 289
    Top = 448
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object UsersXML: TXMLDocument
    Active = True
    Top = 456
  end
end
