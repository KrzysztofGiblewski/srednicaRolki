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
yfolia:=xfolia+round(0.5*spineditgryf.Value)+spineditgilza.Value+spineditfolia.Value;


srodek:=  round(yfolia*0.5)+round(przesuniecie*0.5);
                                                    
xgilza:=srodek-round((0.5*spineditgilza.Value)+(0.5*spineditgryf.Value));
ygilza:=srodek+round((0.5*spineditgilza.Value)+(0.5*spineditgryf.Value));

xgryf:=srodek-round(0.5*spineditgryf.Value);
ygryf:=srodek+round(0.5*spineditgryf.Value);
form1.Canvas.Brush.Color:=clwhite;
form1.canvas.FillRect(0,0,form1.Width,form1.Height);
form1.Canvas.Brush.Color:=clred;
form1.canvas.Pen.color := clRed;
form1.canvas.Ellipse(xfolia,xfolia,yfolia,yfolia);
form1.Canvas.Line(xfolia,srodek,xfolia,0);
form1.Canvas.Line(xfolia,10,yfolia,10);
form1.Canvas.Line(yfolia,srodek,yfolia,0);
form1.Canvas.TextOut(srodek,5,foliarozmiar.ToString);


form1.canvas.Pen.color := clgray;
form1.Canvas.Brush.Color:=clgray;
form1.canvas.Ellipse(xgilza,xgilza,ygilza,ygilza);
form1.canvas.Pen.color := clblack;
form1.Canvas.Line(xgilza,srodek,xgilza,20);
form1.Canvas.Line(xgilza,30,ygilza,30);
form1.Canvas.Line(ygilza,srodek,ygilza,20);
                                                     
form1.Canvas.Brush.Color:=clgray;
form1.Canvas.TextOut(srodek,25,gilzarozmiar.ToString);
                                    
form1.Canvas.Brush.Color:=clyellow;
form1.canvas.Ellipse(xgryf,xgryf,ygryf,ygryf);


 end;







end.
