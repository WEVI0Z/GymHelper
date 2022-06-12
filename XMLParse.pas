unit XMLParse;

interface

uses
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc;

var
  users: IXMLNodeList;

implementation
  function getUsers(XMLDoc : TXMLDocument) : IXMLNodeList;
  begin
    getUsers := XMLDoc.DocumentElement.childNodes;
  end;
end.
