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
    procedure Button1Click(Sender: TObject);
    procedure CreateNewExsClick(Sender: TObject);
  private
  public
    labels: array of TLabel;
    buttons: array of TButton;
  end;

var
  Actions: TActions;
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
  setLength(exercises.Actions.labels, length(users[UserID].Exercises));
  setLength(exercises.Actions.buttons, length(users[UserID].Exercises));
  Actions.ScrollBox1.DestroyComponents;

  for i := 0 to length(users[UserID].Exercises) - 1 do
  begin
    exercises.Actions.labels[i] := TLabel.Create(Actions.ScrollBox1);
    exercises.Actions.labels[i].Parent := Actions.ScrollBox1;
    exercises.Actions.labels[i].Top := 40 * (i);
    exercises.Actions.labels[i].Left := 20;
    exercises.Actions.labels[i].Caption := users[UserID].Exercises[i].Name;
    exercises.Actions.labels[i].Width := 200;
    exercises.Actions.labels[i].Height := 30;

    exercises.Actions.buttons[i] := TButton.Create(Actions.ScrollBox1);
    exercises.Actions.buttons[i].Parent := Actions.ScrollBox1;
    exercises.Actions.buttons[i].Top := 40 * (i);
    exercises.Actions.buttons[i].Left := 230;
    exercises.Actions.buttons[i].Caption := '>';
    exercises.Actions.buttons[i].Width := 30;
    exercises.Actions.buttons[i].Height := 30;

    if i = 0 then
    begin
      exercises.Actions.labels[i].Top := 5;
      exercises.Actions.buttons[i].Top := 5;
    end;
  end;
  for i := 0 to length(exercises.Actions.buttons) - 1 do
    exercises.Actions.buttons[i].OnClick := Actions.Button1Click;
end;

procedure TActions.Button1Click(Sender: TObject);

var
  i: Integer;
begin
  ExsEditing.EditForm.Show;

  for i := 0 to length(exercises.Actions.buttons) - 1 do
    if exercises.Actions.buttons[i] = Sender then
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

end.
