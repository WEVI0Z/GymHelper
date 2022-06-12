unit Authorization;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Xml.xmldom, Xml.XMLIntf,
  Xml.XMLDoc;

type
  TLogin = class(TForm)
    UserName: TEdit;
    Password: TEdit;
    CreateNewUser: TButton;
    EnterTheProfile: TButton;
    UserNameLabel: TLabel;
    PasswordLabel: TLabel;
    LogStatus: TLabel;
    UsersXML: TXMLDocument;
    procedure EnterTheProfileClick(Sender: TObject);
    procedure CreateNewUserClick(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  users: IXMLNodeList;
  Login: TLogin;

implementation

uses
  XMLParse;

{$R *.dfm}

function getUsers(XMLDoc : TXMLDocument) : IXMLNodeList;
  begin
    XMLDoc.LoadFromFile('users.xml');
    getUsers := XMLDoc.DocumentElement.childNodes;
  end;

procedure TLogin.CreateNewUserClick(Sender: TObject);

var i: integer;
    check: boolean;

begin
  check := False;
  UsersXML.LoadFromFile('users.xml');

  for i := 0 to UsersXML.DOMDocument.childNodes.length - 1 do
    if UserName.Text = UsersXML.DocumentElement.ChildNodes[i].ChildNodes['username'].Text then
      check := True;

  if check = True then
    LogStatus.Caption := '��� ������'
  else
  begin
    logStatus.Caption := '����� ������������ ������';
  
    UsersXML.DocumentElement.AddChild('user');
    UsersXML.DocumentElement.ChildNodes.Last.Attributes['id'] := intToStr(UsersXML.DocumentElement.ChildNodes.Count);
    UsersXML.DocumentElement.childNodes.Last.AddChild('username');
    UsersXML.DocumentElement.childNodes.Last.ChildNodes['username'].Text := UserName.Text;
    UsersXML.DocumentElement.childNodes.Last.AddChild('password');
    UsersXML.DocumentElement.childNodes.Last.ChildNodes['password'].Text := Password.Text;
    UsersXML.SaveToFile('users.xml');
  end;
end;

procedure TLogin.EnterTheProfileClick(Sender: TObject);

var
  enteredUser, enteredPassword: String;
  i: integer;

begin
  users := getUsers(UsersXML);
  enteredUser := Username.Text;
  enteredPassword := Password.Text;

  for i := 0 to users.Count - 1 do
  begin
    if (enteredUser = users[i].ChildNodes[0].text) and (enteredPassword = users[i].ChildNodes[1].text) then
    begin
      Authorization.Login.close;
      break
    end
    else
    begin
      logStatus.Visible := True;
      logStatus.Caption := '�������� ����� ��� ������';
    end;
  end;
end;

end.
