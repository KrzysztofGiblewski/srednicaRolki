unit Unit2;

{$mode objfpc}{$H+}

interface

uses
Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Spin ;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    ButtonPrzeLiczMaseRolki: TButton;
    FloatSpinEditMasaOryginalu: TFloatSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpinEditOrginalny: TSpinEdit;
    SpinEditLiczony: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure ButtonPrzeLiczMaseRolkiClick(Sender: TObject);
    procedure FloatSpinEditMasaOryginaluChange(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;
  masa , SzerokoscLiczonej , SzerokoscOrginalu , wagaWynik:double;

implementation
{$R *.lfm}

{ TForm2, TForm1 }



procedure TForm2.ButtonPrzeLiczMaseRolkiClick(Sender: TObject);
begin

  //form2.Hide;
  masa:=form2.FloatSpinEditMasaOryginalu.Value;
  SzerokoscOrginalu:=form2.SpinEditOrginalny.Value;
  SzerokoscLiczonej:=form2.SpinEditLiczony.Value;
  wagaWynik:=masa / SzerokoscOrginalu * SzerokoscLiczonej;
  form2.Label4.Caption:=wagaWynik.ToString(wagaWynik);


end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  form2.Hide;
end;

procedure TForm2.FloatSpinEditMasaOryginaluChange(Sender: TObject);
begin

    label4.Caption:='wynik';
end;


end.

