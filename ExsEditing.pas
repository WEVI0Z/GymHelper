unit ExsEditing;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Xml.xmldom, Xml.XMLIntf,
  Xml.XMLDoc;

type
  TEditForm = class(TForm)
    IsWeightedCheck: TCheckBox;
    SaveButton: TButton;
    NameLabel: TLabel;
    DescriptionLabel: TLabel;
    Description: TEdit;
    NameOfTheTraining: TEdit;
    UsersXML: TXMLDocument;
    DeleteButton: TButton;
    procedure SaveButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditForm: TEditForm;

implementation

uses Authorization, MainMenu, Exercises;
{$R *.dfm}

procedure ParseToXML(XMLDoc: TXMLDocument);
var
  i, j, k: Integer;
  currentUser: IXMLNode;
  currentExs: IXMLNode;
  currentTraining: IXMLNode;
  currentStat: IXMLNode;

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
    currentUser.AddChild('trainings');
    currentUser.AddChild('stats');

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

    for j := 0 to length(users[i].Trainings) - 1 do
    begin
      currentUser.ChildNodes['trainings'].AddChild('training');
      currentTraining := currentUser.ChildNodes['trainings'].ChildNodes.Last;

      currentTraining.AddChild('name');
      currentTraining.ChildNodes['name'].Text := users[i].Trainings[j].Name;

      currentTraining.AddChild('exercises');

      for k := 0 to length(users[i].Trainings[j].Exercises) - 1 do
      begin
        currentUser.ChildNodes['trainings'].ChildNodes.Last.ChildNodes['exercises'].AddChild('exercise');
        currentExs := currentUser.ChildNodes['trainings'].ChildNodes.Last.ChildNodes['exercises'].ChildNodes.Last;

        currentExs.AddChild('name');
        currentExs.AddChild('description');
        currentExs.AddChild('isweighted');

        currentExs.ChildNodes['name'].Text := users[i].Trainings[j].Exercises[k].Name;
        currentExs.ChildNodes['description'].Text := users[i].Trainings[j].Exercises[k].Description;

        if users[i].Trainings[j].Exercises[k].IsWeighted = True then
          currentExs.ChildNodes['isweighted'].Text := 'True'
        else
          currentExs.ChildNodes['isweighted'].Text := 'False';
      end;
    end;

     for j := 0 to length(users[i].Stats) - 1 do
     begin
      currentUser.ChildNodes['stats'].AddChild('completedTraining');
      currentStat := currentUser.ChildNodes['stats'].ChildNodes.Last;

      currentStat.AddChild('name');
      currentStat.AddChild('time');

      currentStat.ChildNodes['name'].Text := users[i].Stats[j].Name;
      currentStat.ChildNodes['date'].Text := users[i].Stats[j].Date;
      currentStat.ChildNodes['time'].Text := intToStr(users[i].Stats[j].Time);

      currentStat.AddChild('completedExercises');

      for k := 0 to length(users[i].Stats[j].Exercises) - 1 do
      begin
        currentUser.ChildNodes['stats'].ChildNodes.Last.ChildNodes['completedExercises'].AddChild('exercise');
        currentExs := currentUser.ChildNodes['stats'].ChildNodes.Last.ChildNodes['completedExercises'].ChildNodes.Last;

        currentExs.AddChild('name');
        currentExs.AddChild('description');
        currentExs.AddChild('isweighted');

        currentExs.ChildNodes['name'].Text := users[i].Stats[j].Exercises[k].Name;
        currentExs.ChildNodes['weight'].Text := intToStr(users[i].Stats[j].Exercises[k].Weight);
        currentExs.ChildNodes['times'].Text := intToStr(users[i].Stats[j].Exercises[k].Times);
      end;
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

procedure TEditForm.DeleteButtonClick(Sender: TObject);

var i : integer;

begin
  for i := buttonID to length(users[UserID].Exercises) - 2 do
  begin
    users[UserID].Exercises[ButtonID].Name := users[UserID].Exercises[ButtonID + 1].Name;
    users[UserID].Exercises[ButtonID].Description := users[UserID].Exercises[ButtonID + 1].Description;
    users[UserID].Exercises[ButtonID].IsWeighted := users[UserID].Exercises[ButtonID + 1].IsWeighted;
  end;

  setLength(users[UserID].Exercises, length(users[UserID].Exercises) - 1);

  parseToXML(usersXML);

  drawTheList();
  ExsEditing.EditForm.Close;
end;

procedure TEditForm.SaveButtonClick(Sender: TObject);
  var xml: string;

begin
  users[UserID].Exercises[ButtonID].Name := NameOfTheTraining.Text;
  users[UserID].Exercises[ButtonID].Description := Description.Text;
  users[UserID].Exercises[ButtonID].IsWeighted := IsWeightedCheck.Checked;

  exercises.Actions.labels[buttonID].Caption := NameOfTheTraining.Text;

  parseToXML(usersXML);

  ExsEditing.EditForm.Close;
end;

end.
