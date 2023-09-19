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
, StdActns
, ComCtrls
, ExtCtrls
, StdCtrls
, HtmlView, FramView, FramBrwz
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
    fbFrameBrowser: TFrameBrowser;
    fvFrameViewer: TFrameViewer;
    gbResource: TGroupBox;
    gbFile: TGroupBox;
    gbEvents: TGroupBox;
    hvHtmlViewer: THtmlViewer;
    mnuFile: TMenuItem;
    mnuFileExit: TMenuItem;
    mmMain: TMainMenu;
    panFrameViewerButtons: TPanel;
    panFrameBrowserButtons: TPanel;
    panHTMLViewerButtons: TPanel;
    pcMain: TPageControl;
    tsTFrameBrowser: TTabSheet;
    tsTFrameViewer: TTabSheet;
    tsHTMLViewer: TTabSheet;
    procedure actHTMLViewerOnHotSpotClickExecute(Sender: TObject);
    procedure actHTMLViewerPageWithInlineCSSFileExecute(Sender: TObject);
    procedure actHTMLViewerPageWithInlineCSSResExecute(Sender: TObject);
    procedure actHTMLViewerSimplePageFileExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actHTMLViewerSimplePageResExecute(Sender: TObject);
  private
    procedure InitShortCuts;
    procedure HTMLViewerLoadFromResource(AResource: UnicodeString);
    procedure HTMLViewerLoadFromFile(AResource: UnicodeString);
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
  crInfoPageHtmlViewer = 'INFOPAGEHTMLVIEWER';
  crInfoPageFrameViewer = 'INFOPAGEFRAMEVIEWER';
  crInfoPageBrowserViewer = 'INFOPAGEBROWSERVIEWER';
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
  HTMLViewerLoadFromResource(crInfoPageHtmlViewer);
  pcMain.ActivePageIndex:= 0;
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

procedure TfrmMain.HTMLViewerLoadFromResource(AResource: UnicodeString);
var
  resourceStream: TResourceStream;
begin
  // Using a resource stream because the LoadFromresource of the component
  // fails to get the resource.
  resourceStream:= TResourceStream.Create(HINSTANCE, AnsiString(AResource), RT_HTML);
  try
    hvHtmlViewer.LoadFromStream(resourceStream);
  finally
    resourceStream.Free;
  end;
end;

procedure TfrmMain.HTMLViewerLoadFromFile(AResource: UnicodeString);
begin
  hvHtmlViewer.LoadFromFile(UnicodeFormat(cHTMLPath, [AResource]));
end;

procedure TfrmMain.OnHotSpotClick(Sender: TObject; const URL: UnicodeString;
  var Handled: Boolean);
begin
  ShowMessage(Format(cLinkClicked, [URL]));
  Handled:= True;
end;

procedure TfrmMain.actHTMLViewerSimplePageResExecute(Sender: TObject);
begin
  HTMLViewerLoadFromResource(crSimplePage);
end;

procedure TfrmMain.actHTMLViewerPageWithInlineCSSResExecute(Sender: TObject);
begin
  HTMLViewerLoadFromResource(crPageWithInlineCSS);
end;

procedure TfrmMain.actHTMLViewerSimplePageFileExecute(Sender: TObject);
begin
  HTMLViewerLoadFromFile(cSimplePage);
end;

procedure TfrmMain.actHTMLViewerPageWithInlineCSSFileExecute(Sender: TObject);
begin
  HTMLViewerLoadFromFile(cPageWithInlineCSS);
end;

procedure TfrmMain.actHTMLViewerOnHotSpotClickExecute(Sender: TObject);
begin
  HTMLViewerLoadFromResource(crSimplePageWithAnchor);
end;

end.

