unit TrainingTime;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc;

type
  TTrainingTimeForm = class(TForm)
    TimeLabel: TLabel;
    Time: TEdit;
    DateLabel: TLabel;
    Date: TEdit;
    ConfirmButton: TButton;
    procedure ConfirmButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TrainingTimeForm: TTrainingTimeForm;

implementation

uses TrainingChoosing, ExsRealise, Authorization, MainMenu;

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

procedure TTrainingTimeForm.ConfirmButtonClick(Sender: TObject);
begin
  users[UserID].Stats[ExsRealise.ExsRealiseForm.currentStat].Time := strToInt(Time.Text);
  users[UserID].Stats[ExsRealise.ExsRealiseForm.currentStat].Date := Date.Text;

  TrainingTime.TrainingTimeForm.Close;

  parseToXml(Authorization.Login.UsersXML);
end;

end.