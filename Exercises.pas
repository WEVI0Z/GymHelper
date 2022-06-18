unit Exercises;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, StdCtrls, Xml.xmldom, Xml.XMLIntf,
  Xml.XMLDoc, Vcl.Buttons;

type
  TActions = class(TForm)
    ListOfTheExsLabel: TLabel;
    CreateNewExs: TButton;
    Button1: TButton;
    UsersXML: TXMLDocument;
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
  XML.Active := False;
end;

procedure TActions.Button1Click(Sender: TObject);

var
  i: Integer;
  exsNode: IXMLNode;
begin
  UsersXML.LoadFromXML(Authorization.Login.UsersXML.XML.Text);

  exsNode := UsersXML.DocumentElement.ChildNodes[UserID].ChildNodes['exercises'];

  ExsEditing.EditForm.Show;

  for i := 0 to length(buttons) - 1 do
    if buttons[i] = Sender then
      ButtonID := i;

  ExsEditing.EditForm.Description.Text := exsNode.ChildNodes[ButtonID].ChildNodes['description'].Text;
  ExsEditing.EditForm.NameOfTheTraining.Text := exsNode.ChildNodes[ButtonID].ChildNodes['name'].Text;

  if exsNode.ChildNodes[ButtonID].ChildNodes['isweighted'].Text = 'True' then
    ExsEditing.EditForm.IsWeightedCheck.Checked := True;
end;

procedure TActions.FormCreate(Sender: TObject);

var i : integer;

begin
  DrawTheList(Authorization.Login.UsersXML);

  for i := 0 to length(buttons) - 1 do
    buttons[i].OnClick := Button1Click;
  Button1.Free;
end;

end.
