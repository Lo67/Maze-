program Maze1;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {fmMain},
  UMaze in 'UMaze.pas',
  UStack in 'UStack.pas',
  USize in 'USize.pas' {fmSize};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmSize, fmSize);
  Application.Run;
end.
