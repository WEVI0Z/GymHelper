unit Authorization;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc;

type
  completedExercise = record
    Name: String;
    Weight: integer;
    Times: integer;
  end;

  Exercise = record
    Name : String;
    Description : String;
    IsWeighted : Boolean;
  end;

  Training = record
    Name: String;
    Exercises: array of exercise;
  end;

  CompletedTraining = record
    Name : String;
    Time : integer;
    Date: String;
    Exercises: array of completedExercise;
  end;

  UsersArr = record
    Name : String;
    Password : String;
    Exercises: array of exercise;
    Trainings: array of training;
    Stats: array of CompletedTraining;
  end;

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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  Login: TLogin;
  users: array of UsersArr;

implementation

uses
  XMLParse, MainMenu;

{$R *.dfm}
procedure parseToObj(XMLDoc: TXMLDocument);

var userTemp : UsersArr;
    exerciseTemp : Exercise;
  i, j, k: Integer;

begin
  XMLDoc.LoadFromFile('users.xml');

  for i := 0 to XMLDoc.DocumentElement.ChildNodes.Count - 1 do
  begin
    userTemp.Name := XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['username'].Text;
    userTemp.Password := XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['password'].Text;

    setLength(userTemp.Exercises, XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['exercises'].ChildNodes.Count);

    for j := 0 to XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['exercises'].ChildNodes.Count - 1 do
    begin
      exerciseTemp.Name := XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['exercises'].ChildNodes[j].ChildNodes['name'].Text;
      exerciseTemp.Description := XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['exercises'].ChildNodes[j].ChildNodes['description'].Text;

      if XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['exercises'].ChildNodes[j].ChildNodes['isweighted'].Text = 'True' then
        exerciseTemp.IsWeighted := True
      else
        exerciseTemp.IsWeighted := False;
      userTemp.Exercises[j] := exerciseTemp;
    end;

    setLength(userTemp.Trainings, XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['trainings'].ChildNodes.Count);
    for j := 0 to XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['trainings'].ChildNodes.Count - 1 do
    begin
      userTemp.Trainings[j].Name := XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['trainings'].ChildNodes[j].ChildNodes['name'].Text;

      setLength(userTemp.Trainings[j].Exercises, XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['trainings'].ChildNodes[j].ChildNodes['exercises'].ChildNodes.Count);

      for k := 0 to XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['trainings'].ChildNodes[j].ChildNodes['exercises'].ChildNodes.Count - 1 do
      begin
        userTemp.Trainings[j].Exercises[k].Name := XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['trainings'].ChildNodes[j].ChildNodes['exercises'].ChildNodes[k].ChildNodes['name'].Text;
        userTemp.Trainings[j].Exercises[k].Description := XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['trainings'].ChildNodes[j].ChildNodes['exercises'].ChildNodes[k].ChildNodes['description'].Text;

        if XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['trainings'].ChildNodes[j].ChildNodes['exercises'].ChildNodes[k].ChildNodes['isweighted'].Text = 'True' then
          userTemp.Trainings[j].Exercises[k].IsWeighted := True
        else
          userTemp.Trainings[j].Exercises[k].IsWeighted := False;
      end;
    end;

    setLength(userTemp.Stats, XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['stats'].ChildNodes.Count);

    for j := 0 to XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['stats'].ChildNodes.Count - 1 do
    begin
      userTemp.Stats[j].Name := XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['stats'].ChildNodes[j].ChildNodes['name'].Text;
      userTemp.Stats[j].Time := strToInt(XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['stats'].ChildNodes[j].ChildNodes['time'].Text);
      userTemp.Stats[j].Date := XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['stats'].ChildNodes[j].ChildNodes['date'].Text;

      setLength(userTemp.Stats[j].Exercises, XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['stats'].ChildNodes[j].ChildNodes['completedExercises'].ChildNodes.Count);

      for k := 0 to XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['stats'].ChildNodes[j].ChildNodes['completedExercises'].ChildNodes.Count - 1 do
      begin
        userTemp.Stats[j].Exercises[k].Name := XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['stats'].ChildNodes[j].ChildNodes['completedExercises'].ChildNodes[k].ChildNodes['name'].Text;
        userTemp.Stats[j].Exercises[k].Weight := strToInt(XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['stats'].ChildNodes[j].ChildNodes['completedExercises'].ChildNodes[k].ChildNodes['weight'].Text);
        userTemp.Stats[j].Exercises[k].Times := strToInt(XMLDoc.DocumentElement.ChildNodes[i].ChildNodes['stats'].ChildNodes[j].ChildNodes['completedExercises'].ChildNodes[k].ChildNodes['times'].Text);
      end;
    end;

    setLength(users, i + 1);
    users[i] := userTemp;
  end;
end;

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

begin
  check := False;
  UsersXML.LoadFromFile('users.xml');
  DefExsXML.LoadFromFile('default exercises.xml');

  for i := 0 to length(users) - 1 do
    if UserName.Text = users[i].Name then
      check := True;

  if check = True then
    LogStatus.Caption := '��� ������'
  else
  begin
    logStatus.Visible := True;
    logStatus.Caption := '����� ������������ ������';

    setLength(users, length(users) + 1);

    i := length(users) - 1;

    users[i].Name := UserName.Text;
    users[i].Password := Password.Text;

    generateTheDefExs(DefExsXML);

    setLength(users[i].Exercises, length(MainMenu.defaultExercises));

    for j := 0 to length(MainMenu.defaultExercises) - 1 do
    begin
      users[i].Exercises[j].Name := MainMenu.defaultExercises[j].Name;
      users[i].Exercises[j].Description := MainMenu.defaultExercises[j].Description;

      if MainMenu.defaultExercises[j].IsWeighted = 'True' then
        users[i].Exercises[j].IsWeighted := True
      else
        users[i].Exercises[j].IsWeighted := False;
    end;

    parseToXml(UsersXML);
  end;
end;

procedure TLogin.EnterTheProfileClick(Sender: TObject);

var
  enteredUser, enteredPassword: String;
  i: integer;

begin
  enteredUser := Username.Text;
  enteredPassword := Password.Text;

  for i := 0 to length(users) - 1 do
  begin
    if (enteredUser = users[i].Name) and (enteredPassword = users[i].Password) then
    begin
      Authorization.Login.close;
      MainMenu.Menu.EnterTheTraining.Enabled := True;
      MainMenu.Menu.CreateNewTraining.Enabled := True;
      MainMenu.Menu.CreateNewExercise.Enabled := True;
      MainMenu.Menu.ShowTheStatistics.Enabled := True;
      MainMenu.Menu.LoginCautionMessage.Visible := False;
      MainMenu.Menu.ID.Caption := intToStr(i);

      MainMenu.Menu.UserName.Caption := users[i].Name;
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

procedure TLogin.FormCreate(Sender: TObject);
begin
  ParseToObj(UsersXML);
end;

end.
