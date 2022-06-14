
{**************************************************************************************************}
{                                                                                                  }
{                                         XML Data Binding                                         }
{                                                                                                  }
{         Generated on: 14.06.2022 5:57:19                                                         }
{       Generated from: D:\Programming Projects\Курсач\WorkOut\Win32\Debug\default exercises.xml   }
{                                                                                                  }
{**************************************************************************************************}

unit defaultexercises;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward Decls }

  IXMLMainType = interface;
  IXMLExerciseType = interface;

{ IXMLMainType }

  IXMLMainType = interface(IXMLNode)
    ['{5E5FA9B3-170A-4728-91D9-5E70836978A5}']
    { Property Accessors }
    function Get_Exercise: IXMLExerciseType;
    { Methods & Properties }
    property Exercise: IXMLExerciseType read Get_Exercise;
  end;

{ IXMLExerciseType }

  IXMLExerciseType = interface(IXMLNode)
    ['{FE96FC06-3B90-4186-BDEB-4DD1EF4A8ABF}']
    { Property Accessors }
    function Get_Name: UnicodeString;
    function Get_Description: UnicodeString;
    function Get_Isweighted: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Description(Value: UnicodeString);
    procedure Set_Isweighted(Value: UnicodeString);
    { Methods & Properties }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Description: UnicodeString read Get_Description write Set_Description;
    property Isweighted: UnicodeString read Get_Isweighted write Set_Isweighted;
  end;

{ Forward Decls }

  TXMLMainType = class;
  TXMLExerciseType = class;

{ TXMLMainType }

  TXMLMainType = class(TXMLNode, IXMLMainType)
  protected
    { IXMLMainType }
    function Get_Exercise: IXMLExerciseType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLExerciseType }

  TXMLExerciseType = class(TXMLNode, IXMLExerciseType)
  protected
    { IXMLExerciseType }
    function Get_Name: UnicodeString;
    function Get_Description: UnicodeString;
    function Get_Isweighted: UnicodeString;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Description(Value: UnicodeString);
    procedure Set_Isweighted(Value: UnicodeString);
  end;

{ Global Functions }

function Getmain(Doc: IXMLDocument): IXMLMainType;
function Loadmain(const FileName: string): IXMLMainType;
function Newmain: IXMLMainType;

const
  TargetNamespace = '';

implementation

uses Xml.xmlutil;

{ Global Functions }

function Getmain(Doc: IXMLDocument): IXMLMainType;
begin
  Result := Doc.GetDocBinding('main', TXMLMainType, TargetNamespace) as IXMLMainType;
end;

function Loadmain(const FileName: string): IXMLMainType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('main', TXMLMainType, TargetNamespace) as IXMLMainType;
end;

function Newmain: IXMLMainType;
begin
  Result := NewXMLDocument.GetDocBinding('main', TXMLMainType, TargetNamespace) as IXMLMainType;
end;

{ TXMLMainType }

procedure TXMLMainType.AfterConstruction;
begin
  RegisterChildNode('exercise', TXMLExerciseType);
  inherited;
end;

function TXMLMainType.Get_Exercise: IXMLExerciseType;
begin
  Result := ChildNodes['exercise'] as IXMLExerciseType;
end;

{ TXMLExerciseType }

function TXMLExerciseType.Get_Name: UnicodeString;
begin
  Result := ChildNodes['name'].Text;
end;

procedure TXMLExerciseType.Set_Name(Value: UnicodeString);
begin
  ChildNodes['name'].NodeValue := Value;
end;

function TXMLExerciseType.Get_Description: UnicodeString;
begin
  Result := ChildNodes['description'].Text;
end;

procedure TXMLExerciseType.Set_Description(Value: UnicodeString);
begin
  ChildNodes['description'].NodeValue := Value;
end;

function TXMLExerciseType.Get_Isweighted: UnicodeString;
begin
  Result := ChildNodes['isweighted'].Text;
end;

procedure TXMLExerciseType.Set_Isweighted(Value: UnicodeString);
begin
  ChildNodes['isweighted'].NodeValue := Value;
end;

end.