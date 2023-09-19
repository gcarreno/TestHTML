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
    procedure HTMLLoadFromResource(AResource: UnicodeString);
    procedure HTMLLoadFromFile(AResource: UnicodeString);
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
  crInfoPage = 'INFOPAGE';
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
  HTMLLoadFromResource(crInfoPage);
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

procedure TfrmMain.HTMLLoadFromResource(AResource: UnicodeString);
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

procedure TfrmMain.HTMLLoadFromFile(AResource: UnicodeString);
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
  HTMLLoadFromResource(crSimplePage);
end;

procedure TfrmMain.actHTMLViewerPageWithInlineCSSResExecute(Sender: TObject);
begin
  HTMLLoadFromResource(crPageWithInlineCSS);
end;

procedure TfrmMain.actHTMLViewerSimplePageFileExecute(Sender: TObject);
begin
  HTMLLoadFromFile(cSimplePage);
end;

procedure TfrmMain.actHTMLViewerPageWithInlineCSSFileExecute(Sender: TObject);
begin
  HTMLLoadFromFile(cPageWithInlineCSS);
end;

procedure TfrmMain.actHTMLViewerOnHotSpotClickExecute(Sender: TObject);
begin
  HTMLLoadFromResource(crSimplePageWithAnchor);
end;

end.

