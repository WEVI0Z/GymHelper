unit Exercises;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, StdCtrls, Xml.xmldom, Xml.XMLIntf,
  Xml.XMLDoc, Vcl.Buttons;

type
  TActions = class(TForm)
    UsersXML: TXMLDocument;
    ListOfTheExsLabel: TLabel;
    CreateNewExs: TButton;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
  public
  end;

var
  Actions: TActions;
  labels: array of TLabel;
  buttons: array of TSpeedButton;
  buttonID: integer;

implementation

uses Authorization, MainMenu, ExsEditing;

{$R *.dfm}

procedure DrawTheList(XML : TXMLDocument);

var exsNode: IXMLNode;
    i: Integer;

begin
  XML.LoadFromFile('users.xml');

  exsNode := XML.DocumentElement.ChildNodes[1].ChildNodes['exercises'];

  setLength(labels, exsNode.ChildNodes.Count);
  setLength(buttons, exsNode.ChildNodes.Count);

  for i := 0 to exsNode.ChildNodes.Count - 1 do
  begin
    labels[i] := TLabel.Create(Actions);
    labels[i].Parent := Actions;
    labels[i].Top := 40 * (i + 1);
    labels[i].Left := 20;
    labels[i].Caption := exsNode.ChildNodes[i].ChildNodes['name'].Text;
    labels[i].Width := 200;
    labels[i].Height := 30;

    buttons[i] := TSpeedButton.Create(Actions);
    buttons[i].Parent := Actions;
    buttons[i].Top := 40 * (i + 1);
    buttons[i].Left := 230;
    buttons[i].Caption := '>';
    buttons[i].Width := 30;
    buttons[i].Height := 30;
  end;

end;

procedure TActions.Button1Click(Sender: TObject);

var
  i: Integer;
  exsNode: IXMLNode;
begin
  UsersXML.LoadFromFile('users.xml');

  exsNode := UsersXML.DocumentElement.ChildNodes[UserID].ChildNodes['exercises'];

  ExsEditing.EditForm.Show;

  for i := 0 to length(buttons) - 1 do
    if buttons[i] = Sender then
      ButtonID := i;
  ExsEditing.EditForm.Desciption.Text := exsNode.ChildNodes[ButtonID].ChildNodes['description'].Text;
  ExsEditing.EditForm.NameOfTheTraining.Text := exsNode.ChildNodes[ButtonID].ChildNodes['name'].Text;
//  if exsNode.ChildNodes[ButtonID].ChildNodes['isweighted'].Text = 'True' then
    ExsEditing.EditForm.IsWeightedCheck.Caption := exsNode.ChildNodes[ButtonID].ChildNodes['isweighted'].Text;
end;

procedure TActions.FormCreate(Sender: TObject);

var i : integer;

begin
  DrawTheList(UsersXML);

  for i := 0 to length(buttons) - 1 do
    buttons[i].OnClick := Button1Click;
  Button1.Free;
end;

end.
