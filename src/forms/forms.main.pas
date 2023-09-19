unit Forms.Main;

{$mode objfpc}{.$H+}

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
, StdActns
, ComCtrls
, ExtCtrls
, StdCtrls
, HtmlView
;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    actHTMLViewerSimplePageRes: TAction;
    actHTMLViewerPageWithInlineCSSRes: TAction;
    actHTMLViewerSimplePageFile: TAction;
    actHTMLViewerPageWithInlineCSSFile: TAction;
    actHTMLViewerOnHotSpotClick: TAction;
    alMain: TActionList;
    actFileExit: TFileExit;
    btnHTMLViewerPageWithInlineCSSFile: TButton;
    btnSimplePageRes: TButton;
    btnHTMLViewerPageWithInlineCSSRes: TButton;
    btnSimplePageFile: TButton;
    btnHTMLViewerOnHotSpotClick: TButton;
    gbResource: TGroupBox;
    gbFile: TGroupBox;
    gbEvents: TGroupBox;
    hvHtmlViewer: THtmlViewer;
    mnuFile: TMenuItem;
    mnuFileExit: TMenuItem;
    mmMain: TMainMenu;
    panHTMLViewerButtons: TPanel;
    pcMain: TPageControl;
    tsHTMLViewer: TTabSheet;
    procedure actHTMLViewerOnHotSpotClickExecute(Sender: TObject);
    procedure actHTMLViewerPageWithInlineCSSFileExecute(Sender: TObject);
    procedure actHTMLViewerPageWithInlineCSSResExecute(Sender: TObject);
    procedure actHTMLViewerSimplePageFileExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actHTMLViewerSimplePageResExecute(Sender: TObject);
  private
    procedure InitShortCuts;
    procedure OnHotSpotClick(Sender: TObject; const URL: UnicodeString;
      var Handled: Boolean);
  public

  end;

var
  frmMain: TfrmMain;

implementation

uses
  LCLType
;

const
  cLinkClicked = 'You clicked on a link.'#13#10+
    'URL: %s';
  cHTMLPath: UnicodeString = '../src/html/%s';
  cSimplePage: UnicodeString = 'simplepage.html';
  cPageWithInlineCSS: UnicodeString = 'pagewithinlinecss.html';
  crSimplePage = 'SIMPLEPAGE';
  crPageWithInlineCSS = 'PAGEWITHINLINECSS';
  crSimplePageWithAnchor = 'SIMPLEPAGEWITHANCHOR';

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Caption:= 'Test HTML v0.1.0';
  InitShortCuts;
  hvHtmlViewer.OnHotSpotClick:= @OnHotSpotClick;
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

procedure TfrmMain.OnHotSpotClick(Sender: TObject; const URL: UnicodeString;
  var Handled: Boolean);
begin
  ShowMessage(Format(cLinkClicked, [URL]));
  Handled:= True;
end;

procedure TfrmMain.actHTMLViewerSimplePageResExecute(Sender: TObject);
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

procedure TfrmMain.actHTMLViewerPageWithInlineCSSResExecute(Sender: TObject);
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

procedure TfrmMain.actHTMLViewerSimplePageFileExecute(Sender: TObject);
begin
  hvHtmlViewer.LoadFromFile(UnicodeFormat(cHTMLPath, [cSimplePage]));
end;

procedure TfrmMain.actHTMLViewerPageWithInlineCSSFileExecute(Sender: TObject);
begin
  hvHtmlViewer.LoadFromFile(UnicodeFormat(cHTMLPath, [cPageWithInlineCSS]));
end;

procedure TfrmMain.actHTMLViewerOnHotSpotClickExecute(Sender: TObject);
var
  resourceStream: TResourceStream;
begin
  // Using a resource stream because the LoadFromresource of the component
  // fails to get the resource.
  resourceStream:= TResourceStream.Create(HINSTANCE, crSimplePageWithAnchor, RT_HTML);
  try
    hvHtmlViewer.LoadFromStream(resourceStream);
  finally
    resourceStream.Free;
  end;
end;

end.

