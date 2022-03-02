unit Notepad;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, XMLPropStorage;

type

  { TNotepadForm }

  TNotepadForm = class(TForm)
    DBMemo: TDBMemo;
    XMLPropStorage: TXMLPropStorage;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NotepadForm: TNotepadForm;

implementation

{$R *.lfm}

procedure TNotepadForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TNotepadForm.FormCreate(Sender: TObject);
begin
  XMLPropStorage.FileName := GetUserDir + DirectorySeparator + '.aquabasesession.xml';
end;

end.
