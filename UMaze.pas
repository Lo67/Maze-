unit UMaze;

interface

uses
  UStack;

const
  SizeOfMaze = 30;

type
  TMass = array [0..SizeOfMaze, 0..SizeOfMaze] of Char;
  TMaze = class
    fMazeMatrix: TMass;
    fStartPoint: TCoordinate;
    fFinishPoint: TCoordinate;
    fCurrentPoint: TCoordinate;
    fUnvisitedCount: Integer;
  public
    constructor CreateMaze();
  private
    procedure GenStartMatrix();
    procedure GenMakeVisited ();
    function GenRandomDirection(): Integer;
    procedure GenDestroyWall(aDirection: Integer);
  end;

implementation

procedure TMaze.GenStartMatrix();
var
  i, j: Integer;
begin
  for i := 0 to SizeOfMaze do
    for j := 0 to SizeOfMaze do
      if (i mod 2 <> 0) and (j mod 2 <> 0) and (i < SizeOfMaze) and (j < SizeOfMaze) then
        fMazeMatrix[i,j] := '0'
      else
        fMazeMatrix[i,j] := '#';
end;

constructor TMaze.CreateMaze();   //Main procedure
var
  Stack: TMyStack;
  Direction: Integer;
begin
  //Preparation
  with Self do
  begin
    fUnvisitedCount := sqr(SizeOfMaze div 2);
    GenStartMatrix();
    fStartPoint.X := 1;
    fStartPoint.Y := 1;
    fCurrentPoint := fStartPoint;
    GenMakeVisited();
  end;

  Stack := TMyStack.Create;
  //Generation of Maze
  while fUnvisitedCount > 0 do //Проверить условие
  begin
    if Self.GenRandomDirection <> -1 then
    begin
      Stack.Add(Self.fCurrentPoint);
      Direction:= Self.GenRandomDirection;
      Self.GenDestroyWall(Direction);
    end
    else
      if not Stack.isEmpty then
      begin
        Self.fCurrentPoint := Stack.Take;
      end;
  end;
  //Mark Start and Finish
  with Self do
  begin
    fMazeMatrix[fStartPoint.X, fStartPoint.Y] := '0';
    fFinishPoint.X := SizeOfMaze - 1;
    fFinishPoint.Y := SizeOfMaze - 1;
    fMazeMatrix[fFinishPoint.X, fFinishPoint.Y] := '1';
  end;
end;

procedure TMaze.GenMakeVisited ();
begin
  with Self.fCurrentPoint do
    Self.fMazeMatrix[X,Y] := ' ';
  Dec(Self.fUnvisitedCount);
end;

function TMaze.GenRandomDirection(): Integer;
var
  RandomMass: array [0..3] of Integer;
  Count: Integer;
begin
  Count := 0;
  //Search true direction
  if (Self.fCurrentPoint.X - 2 > 0) and (Self.fMazeMatrix[Self.fCurrentPoint.X - 2,Self.fCurrentPoint.Y] <> ' ') then
  begin
    RandomMass[Count] := 0;
    Inc(Count);
  end;

  if (Self.fCurrentPoint.Y + 2 < SizeOfMaze) and (Self.fMazeMatrix[Self.fCurrentPoint.X,Self.fCurrentPoint.Y + 2] <> ' ') then
  begin
    RandomMass[Count] := 1;
    Inc(Count);
  end;

  if (Self.fCurrentPoint.X + 2 < SizeOfMaze) and (Self.fMazeMatrix[Self.fCurrentPoint.X + 2,Self.fCurrentPoint.Y] <> ' ') then
  begin
    RandomMass[Count] := 2;
    Inc(Count);
  end;

  if (Self.fCurrentPoint.Y - 2 > 0) and (Self.fMazeMatrix[Self.fCurrentPoint.X,Self.fCurrentPoint.Y - 2] <> ' ') then
  begin
    RandomMass[Count] := 3;
    Inc(Count);
  end;

  //Get random Direction
  Randomize;
  if Count <> 0 then
    Result := RandomMass[Random(111) mod Count]
  else
    Result := -1;
end;

procedure TMaze.GenDestroyWall(aDirection: Integer);
begin
  case aDirection of
    0:
    begin
      Self.fMazeMatrix[Self.fCurrentPoint.X - 1, Self.fCurrentPoint.Y] := ' ';
      Self.fCurrentPoint.X := Self.fCurrentPoint.X - 2;
      Self.GenMakeVisited;
    end;
    1:
    begin
      Self.fMazeMatrix[Self.fCurrentPoint.X, Self.fCurrentPoint.Y + 1] := ' ';
      Self.fCurrentPoint.Y := Self.fCurrentPoint.Y + 2;
      Self.GenMakeVisited;
    end;
    2:
    begin
      Self.fMazeMatrix[Self.fCurrentPoint.X + 1, Self.fCurrentPoint.Y] := ' ';
      Self.fCurrentPoint.X := Self.fCurrentPoint.X + 2;
      Self.GenMakeVisited;
    end;
    3:
    begin
      Self.fMazeMatrix[Self.fCurrentPoint.X, Self.fCurrentPoint.Y - 1] := ' ';
      Self.fCurrentPoint.Y := Self.fCurrentPoint.Y - 2;
      Self.GenMakeVisited;
    end;
  end;
end;

end.
