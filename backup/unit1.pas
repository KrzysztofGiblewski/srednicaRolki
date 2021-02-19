unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Spin,
  ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    ButtonNr3: TButton;
    ButtonNr0: TButton;
    ButtonNr7: TButton;
    ButtonNr8: TButton;
    ButtonNr9: TButton;
    ButtonNr4: TButton;
    ButtonNr5: TButton;
    ButtonNr6: TButton;
    ButtonNr1: TButton;
    ButtonNr2: TButton;
    folia: TShape;
    gilza: TShape;
    gryf: TShape;
    Image1: TImage;
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
       procedure Button1Click(Sender: TObject);
       procedure SpinEditFoliaChange(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;


implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.Button1Click(Sender: TObject);
begin
  application.Terminate;
end;




procedure TForm1.SpinEditFoliaChange(Sender: TObject);
  var srednicakoniec,srednicapoczatek,gryfrozmiar, gilzarozmiar, foliarozmiar,brzegfoli,brzeggilzy,brzeggryfu,xgryf,ygryf,xgilza,ygilza,xfolia,yfolia ,srodek,przesuniecie:integer;
  begin
     srednicakoniec        :=spineditgryf.Value+(spineditfolia.Value*2);
     srednicapoczatek      :=spineditgryf.Value+(spineditgilza.Value*2);
     labelKoniec.Caption   :=srednicakoniec.ToString;
     labelPoczatek.Caption :=srednicapoczatek.ToString;
   // rozmiar
     gryfrozmiar  :=spineditgryf.Value;
     gilzarozmiar :=spineditgryf.Value+(spineditgilza.Value*2);  //czyli grubosc gryfu plus dwie scianki gilzy
     foliarozmiar :=spineditgryf.Value+(spineditfolia.Value*2);  // bo mierze od gryfu a nie od gilzy

     gryf.Height   :=gryfrozmiar;
     gryf.Width    :=gryfrozmiar;
     gilza.Height  :=gilzarozmiar;
     gilza.Width   :=gilzarozmiar;
     folia.Height  :=foliarozmiar;
     folia.Width   :=foliarozmiar;
   // srodek
     gryf.Top:=round((form1.Height-gryfrozmiar)*0.5);
     gryf.Left:=gryf.Top;                               //bo to symetryczne wiec nie ma co liczyc
     gilza.Top:=round((form1.Height-gilzarozmiar)*0.5);
     gilza.Left:=gilza.Top;
     folia.Top:=round((form1.Height-foliarozmiar)*0.5);
     folia.Left:=folia.Top;

     // rysowanie
    {
      //gryf 1
      form1.canvas.MoveTo(gryf.Top,gryf.top);
      form1.canvas.LineTo(gryf.Top,800);
      //gryf2
      form1.canvas.MoveTo(gryf.Top+gryf.Width,gryf.top);
      form1.canvas.LineTo(gryf.Top+gryf.Width,800);
      //gilza1
      form1.canvas.MoveTo(gilza.Top,gilza.top);
      form1.canvas.LineTo(gilza.Top,800);
      //gilza2
      form1.canvas.MoveTo(gilza.Top+gilza.Width,gilza.top);
      form1.canvas.LineTo(gilza.Top+gilza.Width,800);
      //folia1
      form1.canvas.MoveTo(folia.Top,folia.top);
      form1.canvas.LineTo(folia.Top,800);
      //folia2
      form1.canvas.MoveTo(folia.Top+folia.Width,folia.top);
      form1.canvas.LineTo(folia.Top+folia.Width,800);
}
przesuniecie:=250;          

xfolia:=0;
yfolia:=xfolia+round(0.5*spineditgryf)+spineditgilza.Value+spineditfolia.Value;

srodek:=  round(yfolia*0.5);
                                                    
xgilza:=srodek-round((0.5*spineditgilza.Value)+(0.5*spineditgryf.Value));
ygilza:=srodek+round((0.5*spineditgilza.Value)+(0.5*spineditgryf.Value));

xgryf:=srodek-round(0.5*spineditgryf.Value);
ygryf:=srodek+round(0.5*spineditgryf.Value);

form1.Canvas.Clear;
                                                    

form1.canvas.Pen.color := clRed;
form1.canvas.Ellipse(xfolia,xfolia,yfolia,yfolia);
form1.canvas.Pen.color := clgray;
form1.canvas.Ellipse(xgilza,xgilza,ygilza,ygilza);
form1.canvas.Pen.color := clblack;
form1.canvas.Ellipse(xgryf,xgryf,ygryf,ygryf);











end;







end.
