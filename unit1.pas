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
    SpinEditGryf: TSpinEdit;
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
  var gilzarozmiar,foliarozmiar,xgryf,ygryf,xgilza,ygilza,xfolia,yfolia ,srodek,przesuniecie:integer;
  begin
 gilzarozmiar :=spineditgryf.Value+(spineditgilza.Value*2);  //czyli grubosc gryfu plus dwie scianki gilzy
     foliarozmiar :=spineditgryf.Value+(spineditfolia.Value*2);  // bo mierze od gryfu a nie od gilzy
    labelkoniec.Caption:=foliarozmiar.ToString;
    labelpoczatek.Caption:=gilzarozmiar.ToString;
przesuniecie:=50;

xfolia:=przesuniecie;
yfolia:=xfolia+spineditgryf.Value+(spineditgilza.Value*2)+(spineditfolia.Value*2);


srodek:=  round(yfolia*0.5)+round(przesuniecie*0.5);
                                                    
xgilza:=srodek-round((0.5*spineditgilza.Value)+(0.5*spineditgryf.Value));
ygilza:=srodek+round((0.5*spineditgilza.Value)+(0.5*spineditgryf.Value));


panel1.Top:=srodek+150;
panel1.Width:=form1.Width;


xgryf:=srodek-round(0.5*spineditgryf.Value);
ygryf:=srodek+round(0.5*spineditgryf.Value);
form1.Canvas.Brush.Color:=clwhite;
form1.canvas.FillRect(0,0,form1.Width,form1.Height);
form1.Canvas.Brush.Color:=clred;
form1.canvas.Pen.color := clRed;
form1.canvas.Ellipse(xfolia,xfolia,yfolia,yfolia);                                   // kolo
form1.Canvas.Line(xfolia,srodek,xfolia,0);                                           // lewa linia
form1.Canvas.Line(xfolia,10,yfolia,10);                                              // przekatna
form1.Canvas.Line(yfolia,srodek,yfolia,0);                                           // prawa linia
form1.Canvas.TextOut(srodek,5,foliarozmiar.ToString);                                // wymiary
form1.Canvas.Polygon([Point(xfolia,10),Point(xfolia+5,5), Point(xfolia+5,15)]);      // lewy trujkacik na koncu lini
form1.Canvas.Polygon([Point(yfolia,10),Point(yfolia-5,5), Point(yfolia-5,15)]);      // prawy trujkacik na koncu lini


form1.canvas.Pen.color := clgray;
form1.Canvas.Brush.Color:=clgray;
form1.canvas.Ellipse(xgilza,xgilza,ygilza,ygilza);                                   // kolo gilzy
form1.canvas.Pen.color := clblack;
form1.Canvas.Line(xgilza,srodek,xgilza,20);                                          // lewa linia gilzy
form1.Canvas.Line(xgilza,30,ygilza,30);                                              // przekatna gilzy
form1.Canvas.Line(ygilza,srodek,ygilza,20);                                          // prawa linia gilzy
form1.Canvas.Polygon([Point(xgilza,30),Point(xgilza+5,25), Point(xgilza+5,35)]);     // lewy trujkacik na koncu lini
form1.Canvas.Polygon([Point(ygilza,30),Point(ygilza-5,25), Point(ygilza-5,35)]);     // prawy trujkacik na koncu lini


form1.Canvas.Brush.Color:=clgray;
form1.Canvas.Font.Color:=clwhite;
form1.Canvas.TextOut(srodek,25,gilzarozmiar.ToString);
form1.Canvas.Brush.Color:=clyellow;
form1.canvas.Ellipse(xgryf,xgryf,ygryf,ygryf);         // kolo gryfu



 end;







end.
