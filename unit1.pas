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
    Button2: TButton;
    Button3: TButton;
    ComboBoxGryf: TComboBox;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    LabelWynikWagi: TLabel;
    LabelWynikMetrow: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabelKoniec: TLabel;
    LabelPoczatek: TLabel;
    Panel1: TPanel;
    SpinEditWagaWzorcowego: TSpinEdit;
    SpinEditMetryWzorcowego: TSpinEdit;
    SpinEditWagaSzukanego: TSpinEdit;
    SpinEditMetrySzukanego: TSpinEdit;
    SpinEditFolia: TSpinEdit;
    SpinEditGilza: TSpinEdit;
       procedure Button1Click(Sender: TObject);
       procedure Button2Click(Sender: TObject);
       procedure Button3Click(Sender: TObject);
       procedure Label5Click(Sender: TObject);
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

procedure TForm1.Button2Click(Sender: TObject);
var wagaWalkaWzorcowego,
    wagaWalkaSzukanego,
    metryWalkaWzorcowego,
    wynikLiczeniaMetrow :longint;
begin
    wagaWalkaWzorcowego:= SpinEditWagaWzorcowego.Value*1000;   // tak zeby dokladniej to na gramy przelicze
    metryWalkaWzorcowego:= SpinEditMetryWzorcowego.Value;  // tu mi metr dokladnosci mi wystarczy
    wagaWalkaSzukanego :=SpinEditWagaSzukanego.Value*1000;


       if (SpinEditWagaSzukanego.Value>0)  then          // szukam wagi
          begin
             wynikLiczeniaMetrow := round((metryWalkaWzorcowego / wagaWalkaWzorcowego)*wagaWalkaSzukanego);
             LabelWynikMetrow.Caption:= inttostr(wynikLiczeniaMetrow)+' m';
             LabelWynikWagi.Caption:= inttostr(SpinEditWagaSzukanego.Value)+' kg';
             SpinEditMetrySzukanego.Value:=wynikLiczeniaMetrow;
          end;


end;

procedure TForm1.Button3Click(Sender: TObject);
var wagaWalkaWzorcowego,
    metryWalkaWzorcowego,
    metryWalkaSzukanego,
    wynikLiczeniaWagi :longint;
begin
    wagaWalkaWzorcowego:= SpinEditWagaWzorcowego.Value*1000;   // tak zeby dokladniej to na gramy przelicze
    metryWalkaWzorcowego:= SpinEditMetryWzorcowego.Value;  // tu mi metr dokladnosci mi wystarczy
    metryWalkaSzukanego :=SpinEditMetrySzukanego.Value;

       if (SpinEditMetrySzukanego.Value>0) then          // szukam metrow
          begin
             wynikLiczeniaWagi := round(((wagaWalkaWzorcowego / metryWalkaWzorcowego)*metryWalkaSzukanego)*0.001);
             LabelWynikWagi.Caption:= inttostr(wynikLiczeniaWagi)+' kg';
             LabelWynikMetrow.Caption:= inttostr(SpinEditMetrySzukanego.Value)+' m';
             SpinEditWagaSzukanego.Value:=wynikLiczeniaWagi;
          end;


end;

procedure TForm1.Label5Click(Sender: TObject);
begin

end;


 procedure TForm1.Rysuj(Sender: TObject);
       var gryfgilzarozmiar,
           gryfgilzafoliarozmiar,
           gryfrozmiar,
           gilzarozmiar,
           foliarozmiar,
           xgryf,
           ygryf,
           xgilza,
           ygilza,
           xfolia,
           yfolia ,
           srodek,
           przesuniecie:integer;
  begin


    gryfrozmiar  :=  strtoint(form1.ComboBoxGryf.text) ;          // nadajemy wartosc rozmiaru gryfu
    gilzarozmiar :=  form1.spineditgilza.Value;                   // nadajemy wartosc rozmiaru gilzy
    foliarozmiar :=  form1.spineditfolia.Value;                   // nadajemy wartosc rozmiaru folii

    gryfgilzarozmiar := gryfrozmiar+(gilzarozmiar*2);             // czyli grubosc gryfu plus dwie scianki gilzy
    gryfgilzafoliarozmiar := gryfrozmiar+(foliarozmiar*2);        // bo mierze od gryfu a nie od gilzy
    form1.labelpoczatek.Caption := gryfgilzarozmiar.ToString;     // suma gryfu i gilzy
    form1.labelkoniec.Caption := gryfgilzafoliarozmiar.ToString;  // suma gryfu gilzy i foli
    przesuniecie:=50;                                             // przesuniecie tak zeby od samego rogu nie zaczynalo

    xfolia:=przesuniecie;
    yfolia:=xfolia+gryfgilzafoliarozmiar;

    srodek:=  round(yfolia*0.5)+round(przesuniecie*0.5);

    xgilza:=srodek-round(gilzarozmiar+(0.5*gryfrozmiar));
    ygilza:=srodek+round(gilzarozmiar+(0.5*gryfrozmiar));

   form1.panel1.Top:=srodek+100;

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
         form1.Canvas.TextOut(round(srodek-foliarozmiar*0.3),0,gryfgilzafoliarozmiar.ToString);                                // wymiary
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
         form1.Canvas.TextOut(srodek-20,20,gryfgilzarozmiar.ToString);                        // tekst rozmiar gryfu
         form1.Canvas.Brush.Color:=clyellow;
         form1.canvas.Ellipse(xgryf,xgryf,ygryf,ygryf);                                       // kolo gryfu



 end;




end.
