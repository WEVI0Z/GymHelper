object Actions: TActions
  Left = 0
  Top = 0
  Width = 413
  Height = 529
  VertScrollBar.ButtonSize = 3
  VertScrollBar.Range = 342
  VertScrollBar.Size = 10
  VertScrollBar.Tracking = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1052#1077#1085#1077#1076#1078#1077#1088' '#1091#1087#1088#1072#1078#1085#1077#1085#1080#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesktopCenter
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
    Left = 311
    Top = 8
    Width = 89
    Height = 53
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1086#1077' '#1091#1087#1088#1072#1078#1085#1077#1085#1080#1077
    TabOrder = 0
    WordWrap = True
    OnClick = CreateNewExsClick
  end
  object Button1: TButton
    Left = 311
    Top = 467
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ScrollBox1: TScrollBox
    Left = 8
    Top = 29
    Width = 297
    Height = 463
    HorzScrollBar.Visible = False
    TabOrder = 2
  end
  object UsersXML: TXMLDocument
    Active = True
    Top = 456
  end
end
