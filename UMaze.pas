unit UMaze;

interface

uses
  UStack;
const
  SizeOfMaze = 22;

type
  TMass = array [0..SizeOfMaze, 0..SizeOfMaze] of Char;
  TMaze = class
    fMazeMatrix: TMass;
    fStartPoint: TCoordinate;
    fFinishPoint: TCoordinate;
    fUnvisitedCount: Integer;
  public
    procedure StartMatrix();
    constructor CreateMaze();
    procedure MakeVisited (aCurrentPoint: TCoordinate);
    function RandomDirection(aCurrentPoint: TCoordinate): Integer;
    procedure DestroyWall(aCurrentPoint: TCoordinate; aDirection: Integer);
  end;

implementation

procedure TMaze.StartMatrix();
var
  i, j: Integer;
begin
  for i := 0 to SizeOfMaze do
    for j := 0 to SizeOfMaze do
      if (i mod 2 <> 0) and (j mod 2 <> 0) and (i < SizeOfMaze) and (j < SizeOfMaze) then
        fMazeMatrix[i,j] := ' '
      else
        fMazeMatrix[i,j] := '1';
  fMazeMatrix[21,0] := ' ';
  with fStartPoint do
  begin
    X := 1;
    Y := 1;
  end;
  with fFinishPoint do  //В конце присвоить финальной клетке текущую клетку
  begin
    X := 21;
    Y := 21;
  end;
end;

constructor TMaze.CreateMaze();   //Main procedure
var
  CurrentPoint: TCoordinate;
  Stack: TMyStack;
begin
  Self.fUnvisitedCount := sqr(SizeOfMaze div 2);
  Self.StartMatrix;

  CurrentPoint := fStartPoint;

  Self.MakeVisited(CurrentPoint);

  Stack.Create;

  while fUnvisitedCount > 0 do //Проверить условие
  begin
    if self.RandomDirection(CurrentPoint) <> -1 then
    begin
      Stack.Add(CurrentPoint);
      Self.DestroyWall(CurrentPoint,Self.RandomDirection(CurrentPoint));
    end
    else
      if not Stack.isEmpty then
      begin
        CurrentPoint := Stack.Take;
      end;
  end;
end;

procedure TMaze.MakeVisited (aCurrentPoint: TCoordinate);
begin
  with aCurrentPoint do
    Self.fMazeMatrix[X,Y] := '0';
  Dec(Self.fUnvisitedCount);
end;

function TMaze.RandomDirection(aCurrentPoint: TCoordinate): Integer;
var
  RandomMass: array [0..3] of Integer;
  Count: Integer;
begin
  Count := 0;
  //Search true direction
  if (aCurrentPoint.X - 2 > 0) and (Self.fMazeMatrix[aCurrentPoint.X - 2,aCurrentPoint.Y] <> '0') then
  begin
    RandomMass[Count] := 0;
    Inc(Count);
  end;

  if (aCurrentPoint.Y + 2 < SizeOfMaze) and (Self.fMazeMatrix[aCurrentPoint.X,aCurrentPoint.Y + 2] <> '0') then
  begin
    RandomMass[Count] := 1;
    Inc(Count);
  end;

  if (aCurrentPoint.X + 2 < SizeOfMaze) and (Self.fMazeMatrix[aCurrentPoint.X + 2,aCurrentPoint.Y] <> '0') then
  begin
    RandomMass[Count] := 2;
    Inc(Count);
  end;

  if (aCurrentPoint.Y - 2 > 0) and (Self.fMazeMatrix[aCurrentPoint.X,aCurrentPoint.Y - 2] <> '0') then
  begin
    RandomMass[Count] := 3;
    Inc(Count);
  end;

  //Get random Direction
  Randomize;
  if Count <> 0 then
    Result := Random(111) mod Count
  else
    Result := -1;
end;

procedure TMaze.DestroyWall(aCurrentPoint: TCoordinate; aDirection: Integer);
begin
  case aDirection of
    0:
    begin
      Self.fMazeMatrix[aCurrentPoint.X - 1, aCurrentPoint.Y] := '0';
      aCurrentPoint.X := aCurrentPoint.X - 2;
      Self.MakeVisited(aCurrentPoint);
    end;
    1:
    begin
      Self.fMazeMatrix[aCurrentPoint.X, aCurrentPoint.Y + 1] := '0';
      aCurrentPoint.Y := aCurrentPoint.Y + 2;
      Self.MakeVisited(aCurrentPoint);
    end;
    2:
    begin
      Self.fMazeMatrix[aCurrentPoint.X + 1, aCurrentPoint.Y] := '0';
      aCurrentPoint.X := aCurrentPoint.X + 2;
      Self.MakeVisited(aCurrentPoint);
    end;
    3:
    begin
      Self.fMazeMatrix[aCurrentPoint.X, aCurrentPoint.Y - 1] := '0';
      aCurrentPoint.Y := aCurrentPoint.Y - 2;
      Self.MakeVisited(aCurrentPoint);
    end;
  end;
end;

end.
