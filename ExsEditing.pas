unit ExsEditing;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TEditForm = class(TForm)
    IsWeightedCheck: TCheckBox;
    SaveButton: TButton;
    NameLabel: TLabel;
    DescriptionLabel: TLabel;
    Desciption: TEdit;
    NameOfTheTraining: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditForm: TEditForm;

implementation

{$R *.dfm}

end.
