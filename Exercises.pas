unit Exercises;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, StdCtrls, Xml.xmldom, Xml.XMLIntf,
  Xml.XMLDoc;

type
  TActions = class(TForm)
    ListOfTheExsLabel: TLabel;
    CreateNewExs: TButton;
    Button1: TButton;
    UsersXML: TXMLDocument;
    ScrollBox1: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CreateNewExsClick(Sender: TObject);
  private
  public
  end;

var
  Actions: TActions;
  labels: array of TLabel;
  buttons: array of TButton;
  buttonID: integer;

implementation

uses Authorization, MainMenu, ExsEditing, ExsCreating;

{$R *.dfm}

procedure ParseToXML(XMLDoc: TXMLDocument);
var
  i, j: Integer;
  currentUser: IXMLNode;
  currentExs: IXMLNode;

begin
  XMLDoc.LoadFromFile('users.xml');
  XMLDoc.Active := True;
  XMLDoc.XML.Clear;
  XMLDoc.XML.Add('<main>');
  XMLDoc.XML.Add('</main>');
  XMLDoc.Active := True;

  for i := 0 to length(users) - 1 do
  begin
    XMLDoc.DocumentElement.AddChild('user');
    currentUser := XMLDoc.DocumentElement.ChildNodes.Last;

    currentUser.AddChild('username');
    currentUser.AddChild('password');
    currentUser.AddChild('exercises');

    currentUser.ChildNodes['username'].Text := users[i].Name;
    currentUser.ChildNodes['password'].Text := users[i].Password;

    for j := 0 to length(users[i].Exercises) - 1 do
    begin
      currentUser.ChildNodes['exercises'].AddChild('exercise');
      currentExs := currentUser.ChildNodes['exercises'].ChildNodes.Last;

      currentExs.AddChild('name');
      currentExs.AddChild('description');
      currentExs.AddChild('isweighted');

      currentExs.ChildNodes['name'].Text := users[i].Exercises[j].Name;
      currentExs.ChildNodes['description'].Text := users[i].Exercises[j].Description;

      if users[i].Exercises[j].IsWeighted = True then
        currentExs.ChildNodes['isweighted'].Text := 'True'
      else
        currentExs.ChildNodes['isweighted'].Text := 'False';
    end;
  end;

  XMLDoc.SaveToFile('users.xml');
end;

procedure DrawTheList();

var i: Integer;

begin
  setLength(labels, length(users[UserID].Exercises));
  setLength(buttons, length(users[UserID].Exercises));
  Actions.ScrollBox1.DestroyComponents;

  for i := 0 to length(users[UserID].Exercises) - 1 do
  begin
    labels[i] := TLabel.Create(Actions.ScrollBox1);
    labels[i].Parent := Actions.ScrollBox1;
    labels[i].Top := 40 * (i);
    labels[i].Left := 20;
    labels[i].Caption := users[UserID].Exercises[i].Name;
    labels[i].Width := 200;
    labels[i].Height := 30;

    buttons[i] := TButton.Create(Actions.ScrollBox1);
    buttons[i].Parent := Actions.ScrollBox1;
    buttons[i].Top := 40 * (i);
    buttons[i].Left := 230;
    buttons[i].Caption := '>';
    buttons[i].Width := 30;
    buttons[i].Height := 30;

    if i = 0 then
    begin
      labels[i].Top := 5;
      buttons[i].Top := 5;
    end;
  end;
  for i := 0 to length(buttons) - 1 do
  buttons[i].OnClick := Actions.Button1Click;
end;

procedure TActions.Button1Click(Sender: TObject);

var
  i: Integer;
begin
  ExsEditing.EditForm.Show;

  for i := 0 to length(buttons) - 1 do
    if buttons[i] = Sender then
      ButtonID := i;

  ExsEditing.EditForm.NameOfTheTraining.Text := users[UserID].Exercises[ButtonID].Name;
  ExsEditing.EditForm.Description.Text := users[UserID].Exercises[ButtonID].Description;
  ExsEditing.EditForm.IsWeightedCheck.Checked := users[UserID].Exercises[ButtonID].IsWeighted;
end;

procedure TActions.CreateNewExsClick(Sender: TObject);
begin
  ExsCreating.CreateForm.show;

  ExsCreating.CreateForm.NameOfTheTraining.Text := '';
  ExsCreating.CreateForm.Description.Text := '';
  ExsCreating.CreateForm.IsWeightedCheck.Checked := False;
end;

procedure TActions.FormCreate(Sender: TObject);

var i : integer;

begin

  Button1.Free;
end;

end.
