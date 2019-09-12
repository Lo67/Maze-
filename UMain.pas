unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, USize, UMaze;

type
  TfmMain = class(TForm)
    btnGenerate: TButton;
    btnFindExit: TButton;
    btnExit: TButton;
    pntMaze: TPaintBox;
    btnPlay: TButton;
    procedure btnGenerateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpDateImage(aMaze: TMass; aSizeOfMaze: Integer);
    procedure DrawCell(aSizeOfMaze: Integer; Symbol: Char; i, j: Integer);
    procedure btnFindExitClick(Sender: TObject);
    procedure CleanImage;
    procedure btnExitClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPlayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  Maze: TMaze;

implementation

{$R *.dfm}

procedure TfmMain.btnExitClick(Sender: TObject);
begin
  fmMain.Close;
end;

procedure TfmMain.btnFindExitClick(Sender: TObject);
begin
  btnPlay.Enabled := False;
  Maze.ExitMaze;
  UpDateImage(Maze.fMazeMatrix, Maze.fSizeOfMaze);
end;

procedure TfmMain.btnGenerateClick(Sender: TObject);
begin
  fmSize.ShowModal;
  if fmSize.Tag <> 0 then
  begin
    Maze.fSizeOfMaze := fmSize.Tag;
    Maze.CreateMaze;
    UpDateImage(Maze.fMazeMatrix, Maze.fSizeOfMaze);
    btnFindExit.Enabled:= True;
    btnPlay.Enabled:= True;
  end;
end;

procedure TfmMain.btnPlayClick(Sender: TObject);
begin
  btnFindExit.Enabled:= False;
end;

//Don't work
procedure TfmMain.btnPlayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    38:
    begin
      Maze.PlayMaze(0);
      UpDateImage(Maze.fMazeMatrix, Maze.fSizeOfMaze);
    end;
    39:
    begin
      Maze.PlayMaze(1);
      UpDateImage(Maze.fMazeMatrix, Maze.fSizeOfMaze);
    end;
    40:
    begin
      Maze.PlayMaze(2);
      UpDateImage(Maze.fMazeMatrix, Maze.fSizeOfMaze);
    end;
    37:
    begin
      Maze.PlayMaze(3);
      UpDateImage(Maze.fMazeMatrix, Maze.fSizeOfMaze);
    end;
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  btnFindExit.Enabled:= False;
  btnPlay.Enabled := False;
  Maze:= TMaze.Create;
end;

//Don't work
procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    38:
    begin
      Maze.PlayMaze(0);
      UpDateImage(Maze.fMazeMatrix, Maze.fSizeOfMaze);
    end;
    39:
    begin
      Maze.PlayMaze(1);
      UpDateImage(Maze.fMazeMatrix, Maze.fSizeOfMaze);
    end;
    40:
    begin
      Maze.PlayMaze(2);
      UpDateImage(Maze.fMazeMatrix, Maze.fSizeOfMaze);
    end;
    37:
    begin
      Maze.PlayMaze(3);
      UpDateImage(Maze.fMazeMatrix, Maze.fSizeOfMaze);
    end;
  end;
end;

procedure TfmMain.UpDateImage(aMaze: TMass; aSizeOfMaze: Integer);
var
  i,j: Integer;
begin
  CleanImage;
  for i := 0 to aSizeOfMaze do
    for j := 0 to aSizeOfMaze do
      DrawCell(aSizeOfMaze, aMaze[i,j], i, j);
end;

procedure TfmMain.DrawCell(aSizeOfMaze: Integer; Symbol: Char; i, j: Integer);
const
  N = 603;
var
  SquareSide: Integer;
  x1, y1, x2, y2: Integer;
begin
  SquareSide:= {pntMaze.Width}N div aSizeOfMaze;
  x1:= SquareSide * i;
  y1:= SquareSide * j;
  x2:= x1 + SquareSide;
  y2:= y1 + SquareSide;
  case Symbol of
    '#':
      pntMaze.Canvas.Brush.Color:= clBlack;
    ' ':
      pntMaze.Canvas.Brush.Color:= clWhite;
    '.':
      pntMaze.Canvas.Brush.Color:= clGreen;
    '-':
      pntMaze.Canvas.Brush.Color:= clWhite;
    '0':
      pntMaze.Canvas.Brush.Color:= clRed;
    '1':
      pntMaze.Canvas.Brush.Color:= cLGray;
  end;
  pntMaze.Canvas.Pen.Color := clBlack;
  pntMaze.Canvas.Rectangle(x1, y1, x2, y2);
end;

procedure TfmMain.CleanImage;
const
  N = 702;
begin
  pntMaze.Canvas.Pen.Color := clBtnFace;
  pntMaze.Canvas.Brush.Color:= clBtnFace;
  pntMaze.Canvas.Rectangle(0, 0, N, N);
end;

end.
