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
    ComboBoxGryf: TComboBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LabelKoniec: TLabel;
    LabelPoczatek: TLabel;
    Panel1: TPanel;
    SpinEditFolia: TSpinEdit;
    SpinEditGilza: TSpinEdit;
       procedure Button1Click(Sender: TObject);
       procedure Rysuj(Sender: TObject);
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






 procedure TForm1.Rysuj(Sender: TObject);
         var gryfgilzarozmiar,gryfgilzafoliarozmiar,gryfrozmiar,gilzarozmiar,foliarozmiar,xgryf,ygryf,xgilza,ygilza,xfolia,yfolia ,srodek,przesuniecie:integer;
  begin
    if spineditfolia.Value<=spineditgilza.Value then
    spineditfolia.value:=spineditgilza.value+1;

    gryfrozmiar:=  strtoint(form1.ComboBoxGryf.text) ;
        gilzarozmiar :=form1.spineditgilza.Value;
        foliarozmiar:= form1.spineditfolia.Value;
    gryfgilzarozmiar:=gryfrozmiar+(gilzarozmiar*2);  //czyli grubosc gryfu plus dwie scianki gilzy
    gryfgilzafoliarozmiar :=gryfgilzarozmiar+(foliarozmiar*2);  // bo mierze od gryfu a nie od gilzy
    form1.labelkoniec.Caption:=gryfgilzafoliarozmiar.ToString;
    form1.labelpoczatek.Caption:=gryfgilzarozmiar.ToString;
    przesuniecie:=50;

xfolia:=przesuniecie;
yfolia:=xfolia+gryfgilzafoliarozmiar;//+(form1.spineditgilza.Value*2)+(form1.spineditfolia.Value*2);


srodek:=  round(yfolia*0.5)+round(przesuniecie*0.5);

xgilza:=srodek-round((0.5*gilzarozmiar)+(0.5*gryfrozmiar));
ygilza:=srodek+round((0.5*gilzarozmiar)+(0.5*gryfrozmiar));


form1.panel1.Top:=srodek+200;
form1.panel1.Width:=form1.Width;


xgryf:=srodek-round(0.5*gryfrozmiar);
ygryf:=srodek+round(0.5*gryfrozmiar);
form1.Canvas.Brush.Color:=clwhite;
form1.canvas.FillRect(0,0,form1.Width,form1.Height);
form1.Canvas.Brush.Color:=clred;
form1.canvas.Pen.color := clRed;
form1.canvas.Ellipse(xfolia,xfolia,yfolia,yfolia);                                   // kolo
form1.Canvas.Line(xfolia,srodek+80,xfolia,0);                                        // lewa linia
form1.Canvas.Line(xfolia,10,yfolia,10);                                              // przekatna
form1.Canvas.Line(yfolia,srodek+80,yfolia,0);                                        // prawa linia
form1.Canvas.Font.Size:=12;
form1.Canvas.TextOut(srodek,0,gryfgilzafoliarozmiar.ToString);                                // wymiary
form1.Canvas.Polygon([Point(xfolia,10),Point(xfolia+5,5), Point(xfolia+5,15)]);      // lewy trujkacik na koncu lini
form1.Canvas.Polygon([Point(yfolia,10),Point(yfolia-5,5), Point(yfolia-5,15)]);      // prawy trujkacik na koncu lini


form1.canvas.Pen.color := clgray;
form1.Canvas.Brush.Color:=clgray;
form1.canvas.Ellipse(xgilza,xgilza,ygilza,ygilza);                                   // kolo gilzy
form1.canvas.Pen.color := clblack;
form1.Canvas.Line(xgilza,srodek+50,xgilza,20);                                       // lewa linia gilzy
form1.Canvas.Line(xgilza,30,ygilza,30);                                              // przekatna gilzy
form1.Canvas.Line(ygilza,srodek+50,ygilza,20);                                       // prawa linia gilzy
form1.Canvas.Polygon([Point(xgilza,30),Point(xgilza+5,25), Point(xgilza+5,35)]);     // lewy trujkacik na koncu lini
form1.Canvas.Polygon([Point(ygilza,30),Point(ygilza-5,25), Point(ygilza-5,35)]);     // prawy trujkacik na koncu lini


form1.Canvas.Brush.Color:=clgray;
form1.Canvas.Font.Color:=clwhite;
form1.Canvas.TextOut(srodek,20,gryfgilzarozmiar.ToString);
form1.Canvas.Brush.Color:=clyellow;
form1.canvas.Ellipse(xgryf,xgryf,ygryf,ygryf);         // kolo gryfu



 end;




end.
