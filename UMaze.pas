unit UMaze;

interface

uses
  UStack;

const
  SizeOfMaze = 39;
  Wall = '#';
  Cell = ' ';
  ExitCell = '.';
  WrongCell = '-';

type
  TMass = array [0..SizeOfMaze, 0..SizeOfMaze] of Char;
  TMaze = class
  public
    fMazeMatrix: TMass;
    fSizeOfMaze: Integer;
    fStartPoint: TCoordinate;
    fFinishPoint: TCoordinate;
    fCurrentPoint: TCoordinate;
    constructor Create;
    procedure CreateMaze();
    procedure ExitMaze();
    procedure PlayMaze(aDirection: Integer);
  private
    fUnvisitedCount: Integer;
    procedure GenStartMatrix();
    procedure GenMakeVisited ();
    function GenRandomDirection(): Integer;
    procedure GenDestroyWall(aDirection: Integer);
    function ExitRandomDirection():Integer;
    procedure ExitMakeVisited(aDirection: Integer);
  end;

implementation

constructor TMaze.Create;
begin

end;

procedure TMaze.GenStartMatrix();
var
  i, j: Integer;
begin
  for i := 0 to fSizeOfMaze do
    for j := 0 to fSizeOfMaze do
      if (i mod 2 <> 0) and (j mod 2 <> 0) and (i < fSizeOfMaze) and (j < fSizeOfMaze) then
        fMazeMatrix[i,j] := '0'
      else
        fMazeMatrix[i,j] := Wall;
end;

procedure TMaze.CreateMaze();   //Main procedure
var
  Stack: TMyStack;
  Direction: Integer;
begin
  //Preparation
  with Self do
  begin
    fUnvisitedCount := sqr(fSizeOfMaze div 2);
    GenStartMatrix();
    fStartPoint.X := 1;
    fStartPoint.Y := 1;
    fCurrentPoint := fStartPoint;
    GenMakeVisited();
  end;

  Stack := TMyStack.Create;
  //Generation of Maze
  while fUnvisitedCount > 0 do
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
    fMazeMatrix[fStartPoint.X, fStartPoint.Y - 1] := '0';
    fFinishPoint.X := fSizeOfMaze - 1;
    fFinishPoint.Y := fSizeOfMaze - 1;
    fMazeMatrix[fFinishPoint.X + 1, fFinishPoint.Y] := '1';
  end;
end;

procedure TMaze.GenMakeVisited ();
begin
  with Self.fCurrentPoint do
    Self.fMazeMatrix[X,Y] := Cell;
  Dec(Self.fUnvisitedCount);
end;

function TMaze.GenRandomDirection(): Integer;
var
  RandomMass: array [0..3] of Integer;
  Count: Integer;
begin
  Count := 0;
  //Search true direction
  if (Self.fCurrentPoint.X - 2 > 0) and (Self.fMazeMatrix[Self.fCurrentPoint.X - 2,Self.fCurrentPoint.Y] <> Cell) then
  begin
    RandomMass[Count] := 0;
    Inc(Count);
  end;

  if (Self.fCurrentPoint.Y + 2 < fSizeOfMaze) and (Self.fMazeMatrix[Self.fCurrentPoint.X,Self.fCurrentPoint.Y + 2] <> Cell) then
  begin
    RandomMass[Count] := 1;
    Inc(Count);
  end;

  if (Self.fCurrentPoint.X + 2 < fSizeOfMaze) and (Self.fMazeMatrix[Self.fCurrentPoint.X + 2,Self.fCurrentPoint.Y] <> Cell) then
  begin
    RandomMass[Count] := 2;
    Inc(Count);
  end;

  if (Self.fCurrentPoint.Y - 2 > 0) and (Self.fMazeMatrix[Self.fCurrentPoint.X,Self.fCurrentPoint.Y - 2] <> Cell) then
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
      Self.fMazeMatrix[Self.fCurrentPoint.X - 1, Self.fCurrentPoint.Y] := Cell;
      Self.fCurrentPoint.X := Self.fCurrentPoint.X - 2;
      Self.GenMakeVisited;
    end;
    1:
    begin
      Self.fMazeMatrix[Self.fCurrentPoint.X, Self.fCurrentPoint.Y + 1] := Cell;
      Self.fCurrentPoint.Y := Self.fCurrentPoint.Y + 2;
      Self.GenMakeVisited;
    end;
    2:
    begin
      Self.fMazeMatrix[Self.fCurrentPoint.X + 1, Self.fCurrentPoint.Y] := Cell;
      Self.fCurrentPoint.X := Self.fCurrentPoint.X + 2;
      Self.GenMakeVisited;
    end;
    3:
    begin
      Self.fMazeMatrix[Self.fCurrentPoint.X, Self.fCurrentPoint.Y - 1] := Cell;
      Self.fCurrentPoint.Y := Self.fCurrentPoint.Y - 2;
      Self.GenMakeVisited;
    end;
  end;
end;

procedure TMaze.ExitMaze;
var
  Stack: TMyStack;
  Direction: Integer;
begin
  Stack := TMyStack.Create;

  Self.fCurrentPoint := Self.fStartPoint;
  Self.fMazeMatrix[Self.fCurrentPoint.X,Self.fCurrentPoint.Y]:= ExitCell;
  while (Self.fCurrentPoint.X <> Self.fFinishPoint.X) or (Self.fCurrentPoint.Y <> Self.fFinishPoint.Y) do
  begin
    if Self.ExitRandomDirection <> -1 then
    begin
      Stack.Add(Self.fCurrentPoint);
      Direction:= Self.ExitRandomDirection;
      Self.ExitMakeVisited(Direction);
    end
    else
      if not Stack.isEmpty then
      begin
        Self.fMazeMatrix[Self.fCurrentPoint.X,Self.fCurrentPoint.Y] := WrongCell;
        Self.fCurrentPoint := Stack.Take;
      end;
  end;
  fMazeMatrix[fStartPoint.X, fStartPoint.Y - 1] := '.';
  fMazeMatrix[fFinishPoint.X + 1, fFinishPoint.Y] := '0';
end;

procedure TMaze.ExitMakeVisited(aDirection: Integer);
begin
  case aDirection of
    0:
    begin
      Dec(Self.fCurrentPoint.X);
      Self.fMazeMatrix[Self.fCurrentPoint.X,Self.fCurrentPoint.Y] := ExitCell;
    end;
    1:
    begin
      Inc(Self.fCurrentPoint.Y);
      Self.fMazeMatrix[Self.fCurrentPoint.X,Self.fCurrentPoint.Y] := ExitCell;
    end;
    2:
    begin
      Inc(Self.fCurrentPoint.X);
      Self.fMazeMatrix[Self.fCurrentPoint.X,Self.fCurrentPoint.Y] := ExitCell;
    end;
    3:
    begin
      Dec(Self.fCurrentPoint.Y);
      Self.fMazeMatrix[Self.fCurrentPoint.X,Self.fCurrentPoint.Y] := ExitCell;
    end;
  end;
end;

function TMaze.ExitRandomDirection(): Integer;
var
  RandomMass: array [0..3] of Integer;
  Count: Integer;
begin
  Count := 0;
  //Search true direction
  if (Self.fMazeMatrix[fCurrentPoint.X - 1,fCurrentPoint.Y] = Cell) then
  begin
    RandomMass[Count] := 0;
    Inc(Count);
  end;

  if (Self.fMazeMatrix[fCurrentPoint.X,fCurrentPoint.Y + 1] = Cell) then
  begin
    RandomMass[Count] := 1;
    Inc(Count);
  end;

  if (Self.fMazeMatrix[fCurrentPoint.X + 1,fCurrentPoint.Y] = Cell) then
  begin
    RandomMass[Count] := 2;
    Inc(Count);
  end;

  if (Self.fMazeMatrix[fCurrentPoint.X,fCurrentPoint.Y - 1] = Cell) then
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

procedure TMaze.PlayMaze(aDirection: Integer);
var
  X, Y: Integer;
begin
  X:= Self.fCurrentPoint.X;
  Y:= Self.fCurrentPoint.Y;
  case aDirection of
    0:
    if (Self.fMazeMatrix[X - 1, Y] = Cell) or (Self.fMazeMatrix[X - 1, Y] = ExitCell) then
      Self.ExitMakeVisited(aDirection);
    1:
    if (Self.fMazeMatrix[X, Y + 1] = Cell) or (Self.fMazeMatrix[X - 1, Y] = ExitCell) then
      Self.ExitMakeVisited(aDirection);
    2:
    if (Self.fMazeMatrix[X + 1, Y] = Cell) or (Self.fMazeMatrix[X - 1, Y] = ExitCell) then
      Self.ExitMakeVisited(aDirection);
    3:
    if (Self.fMazeMatrix[X, Y - 1] = Cell) or (Self.fMazeMatrix[X - 1, Y] = ExitCell) then
      Self.ExitMakeVisited(aDirection);
  end;
end;

end.
