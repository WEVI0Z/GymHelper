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
    DefExsXML: TXMLDocument;
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
  XMLParse, MainMenu;

{$R *.dfm}

function getUsers(XMLDoc : TXMLDocument) : IXMLNodeList;
begin
  XMLDoc.LoadFromFile('users.xml');
  getUsers := XMLDoc.DocumentElement.childNodes;
end;

procedure generateTheDefExs(XMLDoc: TXMLDocument);
var
  i: integer;
begin
  setLength(MainMenu.defaultExercises, XMLDoc.DocumentElement.ChildNodes.Count);

  for i := 0 to length(MainMenu.defaultExercises) - 1 do
  begin
    MainMenu.defaultExercises[i].Name := XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['name'].Text;
    MainMenu.defaultExercises[i].Description := XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['description'].Text;
    if XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['isweighted'].Text = '1' then
      MainMenu.defaultExercises[i].IsWeighted := 'True'
    else
      MainMenu.defaultExercises[i].IsWeighted := 'False';
  end;
end;

procedure TLogin.CreateNewUserClick(Sender: TObject);

var i, j: integer;
    check: boolean;
    currentUser: IXMLNode;
    currentExs: IXMLNode;

begin
  check := False;
  UsersXML.LoadFromFile('users.xml');
  DefExsXML.LoadFromFile('default exercises.xml');

  for i := 0 to UsersXML.DOMDocument.childNodes.length - 1 do
    if UserName.Text = UsersXML.DocumentElement.ChildNodes[i].ChildNodes['username'].Text then
      check := True;

  if check = True then
    LogStatus.Caption := '��� ������'
  else
  begin
    logStatus.Visible := True;
    logStatus.Caption := '����� ������������ ������';

    UsersXML.DocumentElement.AddChild('user');

    currentUser := UsersXML.DocumentElement.ChildNodes.Last;
    currentUser.Attributes['id'] := intToStr(UsersXML.DocumentElement.ChildNodes.Count);

    currentUser.AddChild('username');
    currentUser.ChildNodes['username'].Text := UserName.Text;
    currentUser.AddChild('password');
    currentUser.ChildNodes['password'].Text := Password.Text;

    generateTheDefExs(DefExsXML);
    currentUser.AddChild('exercises');

    for j := 0 to length(MainMenu.defaultExercises) - 1 do
    begin
      currentUser.ChildNodes['exercises'].AddChild('exercise');
      currentExs := currentUser.ChildNodes['exercises'].ChildNodes.Last;

      currentExs.Attributes['id'] := j + 1;

      currentExs.AddChild('name');
      currentExs.ChildNodes['name'].Text := MainMenu.defaultExercises[j].Name;
      currentExs.AddChild('description');
      currentExs.ChildNodes['description'].Text := MainMenu.defaultExercises[j].Description;
      currentExs.AddChild('isweighted');
//      currentExs.ChildNodes['isweighted'].Text := MainMenu.defaultExercises[j].IsWeighted.ToString(False);
      if MainMenu.defaultExercises[j].IsWeighted = 'True' then
        currentExs.ChildNodes['isweighted'].Text := 'True'
      else
        currentExs.ChildNodes['isweighted'].Text := 'False'
    end;


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
      MainMenu.Menu.EnterTheTraining.Enabled := True;
      MainMenu.Menu.CreateNewTraining.Enabled := True;
      MainMenu.Menu.CreateNewExercise.Enabled := True;
      MainMenu.Menu.ShowTheStatistics.Enabled := True;
      MainMenu.Menu.LoginCautionMessage.Visible := False;
      MainMenu.UserID := i;

      usersXML.LoadFromFile('users.xml');

      MainMenu.Menu.UserName.Caption := UsersXML.DocumentElement.ChildNodes[i].ChildNodes['username'].Text;
      MainMenu.Menu.UserName.Visible := True;

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
