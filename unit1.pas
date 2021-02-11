unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Spin;

type

  { TForm1 }

  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpinEditGryf: TSpinEdit;
    SpinEditGilza: TSpinEdit;
    SpinEditFolia: TSpinEdit;
    procedure SpinEditGryfChange(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.SpinEditGryfChange(Sender: TObject);
begin

end;

end.

