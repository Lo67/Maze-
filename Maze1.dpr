program Maze1;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {fmMain},
  UMaze in 'UMaze.pas',
  UStack in 'UStack.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
