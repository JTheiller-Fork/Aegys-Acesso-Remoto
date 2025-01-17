Unit TThreadTimer;

interface

uses
  Classes;
{
tpIdle          The thread executes only when the system is idle. The system will not interrupt other threads to execute a thread with tpIdle priority.
tpLowest        The thread�s priority is two points below normal.
tpLower         The thread�s priority is one point below normal.
tpNormalThe thread has normal priority.
tpHigherThe thread�s priority is one point above normal.
tpHighestThe thread�s priority is two points above normal.
tpTimeCriticalThe thread gets highest priority.
}

type
{------------------------------------------------------------------------------}
  TxybTimer = class;
{------------------------------------------------------------------------------}
TxybTimerThread = class(TThread)
private
   { Private declarations }
   FTimer : TxybTimer;
protected
   { Protected declarations }
   procedure DoTimer;
public
   { Public declarations }
   constructor Create(ATimer : TxybTimer; PriorityValue : TThreadPriority);
   destructor  Destroy;override;
   procedure Execute;override;
published
   { Published declarations}
end;
{------------------------------------------------------------------------------}
  TxybTimer = class(TComponent)
  private
    FEnabled: Boolean;
    FInterval: Cardinal;
    FOnTimer: TNotifyEvent;
    vPriorityValue : TThreadPriority;
    procedure SetEnabled(const Value: Boolean);
    procedure SetInterval(const Value: Cardinal);
    { Private declarations }
  protected
    { Protected declarations }
    FTimerThread : TxybTimerThread;
    procedure UpdateTimer;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
    destructor  Destroy;override;
  published
    { Published declarations}
    property Enabled  : Boolean         Read FEnabled       Write SetEnabled;
    property Interval : Cardinal        Read FInterval      Write SetInterval;
    property Priority : TThreadPriority Read vPriorityValue Write vPriorityValue;
  published
    property OnTimer : TNotifyEvent read FOnTimer write FOnTimer;
  end;
{------------------------------------------------------------------------------}

Procedure Register;

implementation

Uses
 Windows, SysUtils;

{$IFDEF MSWINDOWS}
Procedure Register;
Begin
 RegisterComponents('XyberPower Utils', [TxybTimer]);
End;
{$ENDIF}
{$IFNDEF MSWINDOWS}
Procedure Register;
Begin
 RegisterComponents('XyberPower Utils', [TxybTimer]);
End;
{$ENDIF}

{ TxybTimerThread }
{------------------------------------------------------------------------------}
constructor TxybTimerThread.Create(ATimer: TxybTimer; PriorityValue : TThreadPriority);
begin
  inherited Create(True);
  Priority        := PriorityValue;
  FreeOnTerminate := True;
  FTimer          := ATimer;
end;
{------------------------------------------------------------------------------}
destructor TxybTimerThread.Destroy;
begin
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TxybTimerThread.DoTimer;
begin
  if Assigned(FTimer.OnTimer) then
    FTimer.OnTimer(FTimer);
end;
{------------------------------------------------------------------------------}
procedure TxybTimerThread.Execute;
begin
 While (not Terminated) and (FTimer.Enabled) do
  begin
    WaitForSingleObject(Self.Handle,FTimer.Interval);
    Synchronize(DoTimer);
  end;
end;
{------------------------------------------------------------------------------}

{ TxybTimer }
{------------------------------------------------------------------------------}
constructor TxybTimer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEnabled       := True;
  FInterval      := 1000;
  vPriorityValue := tpLowest;
end;
{------------------------------------------------------------------------------}
destructor TxybTimer.Destroy;
begin
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TxybTimer.UpdateTimer;
begin
  if Assigned(FTimerThread) then
  begin
    FTimerThread.Terminate;
    FTimerThread := nil;
  end;
  if Enabled then
  begin
    FTimerThread := TxybTimerThread.Create(Self, vPriorityValue);
    FTimerThread.Resume;
  end;
end;
{------------------------------------------------------------------------------}

//Getters - Setters\\
{------------------------------------------------------------------------------}
procedure TxybTimer.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
  UpdateTimer;
end;
{------------------------------------------------------------------------------}
procedure TxybTimer.SetInterval(const Value: Cardinal);
begin
  if Value <> FInterval then
  begin
    FInterval := Value;
    UpdateTimer;
  end;
end;
{------------------------------------------------------------------------------}

end.