unit ExsEditing;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Xml.xmldom, Xml.XMLIntf,
  Xml.XMLDoc, MSXML_TLB;

type
  TEditForm = class(TForm)
    IsWeightedCheck: TCheckBox;
    SaveButton: TButton;
    NameLabel: TLabel;
    DescriptionLabel: TLabel;
    Description: TEdit;
    NameOfTheTraining: TEdit;
    UsersXML: TXMLDocument;
    procedure SaveButtonClick(Sender: TObject);
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

procedure TEditForm.SaveButtonClick(Sender: TObject);

  var exsNode: IXMLNode;
  var xml: string;

begin
  UsersXML.LoadFromXML(Authorization.Login.UsersXML.XML.Text);

  exsNode := Authorization.Login.UsersXML.DocumentElement.ChildNodes[UserID].ChildNodes['exercises'];

  exsNode.ChildNodes[ButtonID].ChildNodes['name'].Text := NameOfTheTraining.Text;
  exsNode.ChildNodes[ButtonID].ChildNodes['description'].Text := Description.Text;

  if IsWeightedCheck.Checked = True then
    exsNode.ChildNodes[ButtonID].ChildNodes['isweighted'].Text := 'True'
  else
    exsNode.ChildNodes[ButtonID].ChildNodes['isweighted'].Text := 'False';

  UsersXML.SaveToFile('users.xml');

  xml := Authorization.Login.UsersXML.XML.Text;

  UsersXML.SaveToXML(XML);

  Exercises.Actions.Close;
  ExsEditing.EditForm.Close;
  Exercises.Actions.Show;
end;

end.
