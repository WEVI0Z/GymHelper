object Login: TLogin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 176
  ClientWidth = 199
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
  object UserNameLabel: TLabel
    Left = 32
    Top = 29
    Width = 97
    Height = 13
    Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
  end
  object PasswordLabel: TLabel
    Left = 34
    Top = 75
    Width = 115
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
  end
  object LogStatus: TLabel
    Left = 8
    Top = 155
    Width = 48
    Height = 13
    Caption = 'LogStatus'
    Visible = False
  end
  object UserName: TEdit
    Left = 32
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'UserName'
  end
  object Password: TEdit
    Left = 32
    Top = 94
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Password'
  end
  object CreateNewUser: TButton
    Left = 160
    Top = 8
    Width = 25
    Height = 25
    Caption = '+'
    TabOrder = 2
    OnClick = CreateNewUserClick
  end
  object EnterTheProfile: TButton
    Left = 54
    Top = 128
    Width = 75
    Height = 25
    Caption = #1042#1086#1081#1090#1080
    TabOrder = 3
    OnClick = EnterTheProfileClick
  end
  object UsersXML: TXMLDocument
    Left = 160
    Top = 128
  end
end
