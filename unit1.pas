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
    LabelKoniec: TLabel;
    LabelPoczatek: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    SpinEditGryf: TSpinEdit;
    SpinEditGilza: TSpinEdit;
    SpinEditFolia: TSpinEdit;
    procedure licz(Sender: TObject);
    procedure SpinEditFoliaChange(Sender: TObject);
    procedure SpinEditGilzaChange(Sender: TObject);
    procedure SpinEditGryfChange(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
   srednicakoniec ,srednicapoczatek : integer ;


implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.licz(Sender: TObject);

  begin

     srednicakoniec :=  spineditgryf.Value+(spineditgilza.Value*2)+(spineditfolia.Value*2);
     srednicapoczatek :=spineditgryf.Value+(spineditgilza.Value*2);
     labelKoniec.Caption := srednicakoniec.ToString;
     labelPoczatek.Caption :=srednicapoczatek.ToString;
end;

procedure TForm1.SpinEditFoliaChange(Sender: TObject);
   begin

    srednicakoniec :=  spineditgryf.Value+(spineditgilza.Value*2)+(spineditfolia.Value*2);
     srednicapoczatek :=spineditgryf.Value+(spineditgilza.Value*2);
     labelKoniec.Caption := srednicakoniec.ToString;
     labelPoczatek.Caption :=srednicapoczatek.ToString;

end;

procedure TForm1.SpinEditGilzaChange(Sender: TObject);

   begin

      srednicakoniec :=  spineditgryf.Value+(spineditgilza.Value*2)+(spineditfolia.Value*2);
     srednicapoczatek :=spineditgryf.Value+(spineditgilza.Value*2);
     labelKoniec.Caption := srednicakoniec.ToString;
     labelPoczatek.Caption :=srednicapoczatek.ToString;
end;

procedure TForm1.SpinEditGryfChange(Sender: TObject);
 begin
      srednicakoniec :=  spineditgryf.Value+(spineditgilza.Value*2)+(spineditfolia.Value*2);
           srednicapoczatek :=spineditgryf.Value+(spineditgilza.Value*2);
           labelKoniec.Caption := srednicakoniec.ToString;
           labelPoczatek.Caption :=srednicapoczatek.ToString;    end;

end.

