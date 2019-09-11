unit UStack;

interface

type

  TCoordinate = record
    X: Integer;
    Y: Integer;
  end;

  TNodePointer = ^TNode;
  TNode = record
    Point: TCoordinate;
    Next: TNodePointer;
  end;

  TMyStack = class
  private
    fHead: TNodePointer;
  public
    constructor Create;
    destructor Destroy;
    procedure Add(Item: TCoordinate);
    function Take: TCoordinate;
    function isEmpty: Boolean;
  end;

implementation

constructor TMyStack.Create;
begin
  fHead:= nil;
end;

destructor TMyStack.Destroy;
begin
  while not isEmpty do
    Take;
  fHead:= nil;
end;

procedure TMyStack.Add(Item: TCoordinate);
var
  Temp: TNodePointer;
begin
  New(Temp);
  Temp^.Point:= Item;
  Temp^.Next:= nil;
  if (isEmpty) then
    fHead:= Temp
  else
    Temp^.Next:= fHead;
    fHead:= Temp;
end;

function TMyStack.Take: TCoordinate;
var
  Temp: TNodePointer;
begin
  Temp:= fHead;
  fHead:= fHead^.Next;
  Result:= Temp^.Point;
  Dispose(Temp);
end;

function TMyStack.isEmpty: boolean;
begin
  result:= fHead = nil;
end;
end.
