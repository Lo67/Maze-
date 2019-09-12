unit USize;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfmSize = class(TForm)
    txtSizeQuestion: TStaticText;
    rbtSize9: TRadioButton;
    rbtSize15: TRadioButton;
    rbtSize39: TRadioButton;
    btnOk: TButton;
    procedure FormCreate(Sender: TObject);
    procedure rbtSize9Click(Sender: TObject);
    procedure rbtSize15Click(Sender: TObject);
    procedure rbtSize39Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSize: TfmSize;

implementation

{$R *.dfm}

procedure TfmSize.btnOkClick(Sender: TObject);
begin
  if rbtSize9.Checked = True then
    fmSize.Tag:= 8;
  if rbtSize15.Checked = True then
    fmSize.Tag:= 14;
  if rbtSize39.Checked = True then
    fmSize.Tag:= 38;
  fmSize.Close;
end;

procedure TfmSize.FormCreate(Sender: TObject);
begin
  btnOk.Enabled := False;
end;

procedure TfmSize.rbtSize15Click(Sender: TObject);
begin
  btnOk.Enabled := True;
end;

procedure TfmSize.rbtSize39Click(Sender: TObject);
begin
  btnOk.Enabled := True;
end;

procedure TfmSize.rbtSize9Click(Sender: TObject);
begin
  btnOk.Enabled := True;
end;

end.
