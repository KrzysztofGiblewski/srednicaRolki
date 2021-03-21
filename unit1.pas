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
    Bevel2: TBevel;
    ButtonZamknijProgram: TButton;
    ButtonPrzeliczZKiloNaMetry: TButton;
    ButtonPrzeliczZMetrowNaKilo: TButton;
    ComboBoxListaFolii: TComboBox;
    ComboBoxGryf: TComboBox;
    FloatSpinEditWagaWzorcowego: TFloatSpinEdit;
    FloatSpinEditWagaSzukanego: TFloatSpinEdit;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
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
    MemoPamiecOstatniego: TMemo;
    Panel1: TPanel;
    SpinEditMetryWzorcowego: TSpinEdit;
    SpinEditWagaSzukanego: TSpinEdit;
    SpinEditMetrySzukanego: TSpinEdit;
    SpinEditFolia: TSpinEdit;
    SpinEditGilza: TSpinEdit;
       procedure ButtonZamknijProgramClick(Sender: TObject);
       procedure ButtonPrzeliczZKiloNaMetryClick(Sender: TObject);
       procedure ButtonPrzeliczZMetrowNaKiloClick(Sender: TObject);
       procedure FormActivate(Sender: TObject);
       procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
       procedure Rysuj(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;


implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.ButtonZamknijProgramClick(Sender: TObject);
begin
  application.Terminate;
end;



procedure TForm1.ButtonPrzeliczZKiloNaMetryClick(Sender: TObject);
var wagaWalkaWzorcowego,
    wagaWalkaSzukanego,
    metryWalkaWzorcowego,
    wynikLiczeniaMetrow :double;
    wynikKgWStringu,wynikMetrWStringu:string;


begin
       wagaWalkaWzorcowego:= FloatSpinEditWagaWzorcowego.Value*1000;       // dla dokladnosci z przecinkiem
       metryWalkaWzorcowego:= SpinEditMetryWzorcowego.Value;               // tu mi metr dokladnosci mi wystarczy
       wagaWalkaSzukanego :=FloatSpinEditWagaSzukanego.Value*1000;


       if (FloatSpinEditWagaSzukanego.Value>0)  then                             // szukam wagi
          begin
             wynikLiczeniaMetrow := (metryWalkaWzorcowego / wagaWalkaWzorcowego)*wagaWalkaSzukanego;

             wynikKgWStringu:=   FloatToStrF((wagaWalkaSzukanego*0.001),fffixed,8,2);    // zaokraglam do dwuch miejsc po przecinku
              wynikMetrWStringu:=FloatToStrF(wynikLiczeniaMetrow,fffixed,8,2);


             LabelWynikMetrow.Caption:= wynikMetrWStringu+' m';
             LabelWynikWagi.Caption:= wynikKgWStringu+' kg';      // float na stringa robie
             SpinEditMetrySzukanego.Value:=wynikLiczeniaMetrow;
          end;


end;

procedure TForm1.ButtonPrzeliczZMetrowNaKiloClick(Sender: TObject);
var wagaWalkaWzorcowego,
    metryWalkaWzorcowego,
    metryWalkaSzukanego,
    wynikLiczeniaWagi :double;
    wynikKgWStringu ,wynikMetrWStringu:string;

begin
     wagaWalkaWzorcowego:= FloatSpinEditWagaWzorcowego.Value*1000;
     metryWalkaWzorcowego:= SpinEditMetryWzorcowego.Value;  // tu mi metr dokladnosci mi wystarczy
     metryWalkaSzukanego :=SpinEditMetrySzukanego.Value;


       if (SpinEditMetrySzukanego.Value>0) then          // szukam metrow
          begin
             wynikLiczeniaWagi := ((wagaWalkaWzorcowego / metryWalkaWzorcowego)*metryWalkaSzukanego)*0.001;

              wynikKgWStringu:=   FloatToStrF(wynikLiczeniaWagi,fffixed,8,2);    // zaokraglam do dwuch miejsc po przecinku
              wynikMetrWStringu:=FloatToStrF(metryWalkaSzukanego,fffixed,3,2);

             LabelWynikWagi.Caption:= wynikKgWStringu+' kg';
             LabelWynikMetrow.Caption:= wynikMetrWStringu+' m';
             SpinEditWagaSzukanego.Value:=wynikLiczeniaWagi;

          end;


end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    MemoPamiecOstatniego.Lines.LoadFromFile('bazaRolekFolii.txt');
    FloatSpinEditWagaWzorcowego.Value := strtofloat(MemoPamiecOstatniego.Lines.ValueFromIndex[1]); // bo linia 0 to jej nazwa czyli string 'ostatnia'
    SpinEditMetryWzorcowego.Value:=strtofloat(MemoPamiecOstatniego.Lines.ValueFromIndex[2]);
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
TF : TextFile;
 begin

 MemoPamiecOstatniego.Lines.Clear;
 MemoPamiecOstatniego.Lines.Add('ostatnia');
 MemoPamiecOstatniego.Lines.Add(floattostr(FloatSpinEditWagaWzorcowego.Value));
 MemoPamiecOstatniego.Lines.Add(floattostr(SpinEditMetryWzorcowego.Value));

  AssignFile(TF, 'bazaRolekFolii.txt');
  ReWrite(TF);
  Writeln(TF, 'ostatnia');
  Writeln(TF, floattostr(FloatSpinEditWagaWzorcowego.Value));
  Writeln(TF, floattostr(SpinEditMetryWzorcowego.Value));
  CloseFile(TF);
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
