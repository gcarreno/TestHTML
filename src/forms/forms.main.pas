unit Forms.Main;

{$mode objfpc}{$H+}

interface

uses
  Classes
, SysUtils
, Forms
, Controls
, Graphics
, Dialogs
, Menus
, ActnList
, StdActns, ComCtrls, ExtCtrls, StdCtrls, HtmlView;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    actHTMLViewerSimplePage: TAction;
    actHTMLViewerPageWithInlineCSS: TAction;
    alMain: TActionList;
    actFileExit: TFileExit;
    btnSimplePage: TButton;
    btnHTMLViewerPageWithInlineCSS: TButton;
    hvHtmlViewer: THtmlViewer;
    mnuFile: TMenuItem;
    mnuFileExit: TMenuItem;
    mmMain: TMainMenu;
    panHTMLViewerButtons: TPanel;
    pcMain: TPageControl;
    tsHTMLViewer: TTabSheet;
    procedure actHTMLViewerPageWithInlineCSSExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actHTMLViewerSimplePageExecute(Sender: TObject);
  private
    procedure InitShortCuts;
  public

  end;

var
  frmMain: TfrmMain;

implementation

uses
  LCLType
;

const
  cHTMLPath = '../src/html/';
  crSimplePage = 'SIMPLEPAGE';
  crPageWithInlineCSS = 'PAGEWITHINLINECSS';

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Caption:= 'Test HTML v0.1.0';
  InitShortCuts;
end;

procedure TfrmMain.InitShortCuts;
begin
{$IFDEF UNIX}
  actFileExit.ShortCut := KeyToShortCut(VK_Q, [ssCtrl]);
{$ENDIF}
{$IFDEF WINDOWS}
  actFileExit.ShortCut := KeyToShortCut(VK_X, [ssAlt]);
{$ENDIF}
end;

procedure TfrmMain.actHTMLViewerSimplePageExecute(Sender: TObject);
var
  resourceStream: TResourceStream;
begin
  // Using a resource stream because the LoadFromresource of the component
  // fails to get the resource.
  resourceStream:= TResourceStream.Create(HINSTANCE, crSimplePage, RT_HTML);
  try
    hvHtmlViewer.LoadFromStream(resourceStream);
  finally
    resourceStream.Free;
  end;
end;

procedure TfrmMain.actHTMLViewerPageWithInlineCSSExecute(Sender: TObject);
var
  resourceStream: TResourceStream;
begin
  // Using a resource stream because the LoadFromresource of the component
  // fails to get the resource.
  resourceStream:= TResourceStream.Create(HINSTANCE, crPageWithInlineCSS, RT_HTML);
  try
    hvHtmlViewer.LoadFromStream(resourceStream);
  finally
    resourceStream.Free;
  end;
end;

end.

