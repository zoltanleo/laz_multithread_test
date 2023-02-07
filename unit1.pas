unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TMyThread }

  TMyThread = class(TThread)
  private
    ThrLabel: TLabel;//uses StdCtrls
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
  end;

  { TFrmMain }

  TFrmMain = class(TForm)
    Label1: TLabel;
    Pnl: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure PnlClick(Sender: TObject);
  private
    Fcnt: Integer;
  public

  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.lfm}

{ TFrmMain }

procedure TFrmMain.PnlClick(Sender: TObject);
var
  new: TMyThread;
begin
  new:= TMyThread.Create(True);
  Inc(Fcnt);
  Label1.Caption:= Format('запущенных процессов: %d',[Fcnt]);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  Label1.Caption:='';
  Fcnt:= 0;
end;

{ TMyThread }

procedure TMyThread.Execute;
//var TickCnt: LongWord;
begin
  //TickCnt:= GetTickCount;
  while True do
  begin
    //if (GetTickCount - TickCnt) > 1000 then
    //begin
    //  ThrLabel.Caption:= FormatDateTime('hh.mm.ss',Now);
    //  TickCnt:= GetTickCount;
    //end;
    ThrLabel.Caption:= FormatDateTime('hh.mm.ss',Now);
    Sleep(1000);

  end;
end;

constructor TMyThread.Create(CreateSuspended: Boolean);
var
  Point: TPoint;//координаты нажатия мыши
begin
  inherited Create(CreateSuspended);
  FreeOnTerminate:= True;
  Priority:= tpLowest;
  ThrLabel:= TLabel.Create(FrmMain);
  ThrLabel.Parent:= FrmMain.Pnl;
  Point:= FrmMain.Pnl.ScreenToClient(Mouse.CursorPos);
  ThrLabel.Left:= Point.x;
  ThrLabel.Top:= Point.y;
  if CreateSuspended then Resume;
end;

destructor TMyThread.Destroy;
begin
  inherited Destroy;
end;

end.

