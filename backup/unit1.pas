unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Spin,
  ExtCtrls, Arrow;

type

  { TForm1 }

  TForm1 = class(TForm)
    ArrowPoprzednia: TArrow;
    ArrowKolejny: TArrow;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Button1: TButton;
    ButtonZapamietajHistoria: TButton;
    ButtonZamknijProgram: TButton;
    ButtonPrzeliczZKiloNaMetry: TButton;
    ButtonPrzeliczZMetrowNaKilo: TButton;
    ComboBoxGryf: TComboBox;
    EditNazwaFoliWalka: TEdit;
    FloatSpinEditFolia: TFloatSpinEdit;
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
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    LabelZSrednicy: TLabel;
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
    MemoHistoria: TMemo;
    MemoBazaFolii: TMemo;
    MemoPamiecOstatniego: TMemo;
    Panel1: TPanel;
    SpinEditSrenica: TSpinEdit;
    SpinEditMetryWzorcowego: TSpinEdit;
    SpinEditMetrySzukanego: TSpinEdit;
    SpinEditGilza: TSpinEdit;
    procedure ArrowKolejnyClick(Sender: TObject);
    procedure ArrowPoprzedniaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ButtonZapamietajHistoriaClick(Sender: TObject);
    procedure ButtonZamknijProgramClick(Sender: TObject);
    procedure ButtonPrzeliczZKiloNaMetryClick(Sender: TObject);
    procedure ButtonPrzeliczZMetrowNaKiloClick(Sender: TObject);
    procedure Rysuj(Sender: TObject);
    procedure Zapamietaj(Sender: TObject);
    procedure Wczytaj(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  k ,ij ,iloscLini : integer; // do histori

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.ButtonZamknijProgramClick(Sender: TObject); // przycisk zamykajacy program
begin
   Zapamietaj(Sender);
   application.Terminate;
end;

procedure TForm1.Button1Click(Sender: TObject);
var poleCalaRolka , poleResztaRolka,srednicaLiczonej,gryfgilzarozmiar,
gryfgilzafoliarozmiar,gilzarozmiar,foliarozmiar,gryfrozmiar ,
gramaturaWzoru, masaCalejRolki,masaResztyWalka,
promienCalej, promienReszty, promienGilzy, pi:double;
begin
  masaCalejRolki:=form1.FloatSpinEditWagaWzorcowego.Value;
  gryfrozmiar := StrToInt(form1.ComboBoxGryf.Text);   // nadajemy wartosc rozmiaru gryfu
  gilzarozmiar := form1.spineditgilza.Value;   // nadajemy wartosc rozmiaru gilzy
  foliarozmiar := form1.FloatSpinEditFolia.Value;    // nadajemy wartosc rozmiaru folii
  srednicaLiczonej:=form1.SpinEditSrenica.Value; // wpisywana recznie w panelu
  gryfgilzarozmiar := gryfrozmiar + (gilzarozmiar * 2);  // czyli grubosc gryfu plus dwie scianki gilzy
  gryfgilzafoliarozmiar := gryfrozmiar + (foliarozmiar * 2);  // bo mierze od gryfu a nie od gilzy
  promienCalej:=gryfgilzafoliarozmiar*0.5;
  promienReszty:=  srednicaLiczonej*0.5;
  promienGilzy   :=gryfgilzarozmiar*0.5;
  pi:=3.14159;
  poleCalaRolka :=(pi*(promienCalej*promienCalej))-(pi*(promienGilzy*promienGilzy));
  poleResztaRolka:=(pi*(promienReszty*promienReszty))-(pi*(promienGilzy*promienGilzy));

  gramaturaWzoru:=masaCalejRolki/poleCalaRolka;   // przeliczam gramature czyli mase jednostki folii
  masaResztyWalka:=poleResztaRolka* gramaturaWzoru;
  LabelZSrednicy.Caption:=FloatToStrF(masaResztyWalka, fffixed, 8, 2) +' kg';
  form1.FloatSpinEditWagaSzukanego.Value:=masaResztyWalka;
  form1.ButtonPrzeliczZKiloNaMetry.Click;
end;


procedure TForm1.ButtonZapamietajHistoriaClick(Sender: TObject);
var TF:TextFile;
  i:integer;
begin
   for i:=0 to round(iloscLini*0.1)-1 do
        memohistoria.Lines.Delete(0);

      MemoHistoria.Lines.Add(floattostr(FloatSpinEditWagaWzorcowego.Value)); // zapisze wage wzorcowego
      MemoHistoria.Lines.Add(floattostr(SpinEditMetryWzorcowego.Value));     // zapisze metry wzorcowego
      MemoHistoria.Lines.Add( floattostr( FloatSpinEditFolia.Value ));               // zapisze ostatnia srednice foli (po lewej stronie)
      MemoHistoria.Lines.Add(inttostr(SpinEditGilza.Value));               // zapisze ostatnia srednice foli (po lewej stronie)
      MemoHistoria.Lines.Add(ComboBoxGryf.Text);               // zapisze ostatnia srednice foli (po lewej stronie)
      MemoHistoria.Lines.Add(EditNazwaFoliWalka.Text);               // zapisze nazwae foli rolki

  AssignFile(TF, 'historia.txt');
  ReWrite(TF);
  for i:=0 to iloscLini-1 do
  begin
  Writeln(TF, MemoHistoria.Lines.ValueFromIndex[i]);
  end;
  CloseFile(TF);
  k:=iloscLini;
  showmessage('dane rolki '+ EditNazwaFoliWalka.Text+' zapisane waga '+floattostr(FloatSpinEditWagaWzorcowego.Value)
  +' długość '+floattostr(SpinEditMetryWzorcowego.Value)
  +' m i tak dalej ;)' );
 end;

procedure TForm1.ArrowPoprzedniaClick(Sender: TObject);
 begin
   MemoHistoria.Lines.LoadFromFile('historia.txt');// do memo wczytuje plik txt

   if (k>=round(iloscLini*0.1)) then
   begin
   k:=k-round(iloscLini*0.1);
   FloatSpinEditWagaWzorcowego.Value := strtofloat(MemoHistoria.Lines.ValueFromIndex[k]);  // bo linia 0 to jej nazwa czyli string 'ostatnia'
   SpinEditMetryWzorcowego.Value     :=   strtoint(MemoHistoria.Lines.ValueFromIndex[k+1]);
   FloatSpinEditFolia.Value          := strtofloat(MemoHistoria.Lines.ValueFromIndex[k+2]);// srednica ostatniej miezonej rolki
   SpinEditGilza.Value               :=   strtoint(MemoHistoria.Lines.ValueFromIndex[k+3]);
   ComboBoxGryf.Text                 :=            MemoHistoria.Lines.ValueFromIndex[k+4];
   label19.Caption                   :=            MemoHistoria.Lines.ValueFromIndex[k+5];  // nazwa foli

  end;

end;

procedure TForm1.ArrowKolejnyClick(Sender: TObject);
 begin
   MemoHistoria.Lines.LoadFromFile('historia.txt');// do memo wczytuje plik txt
   if (k<((iloscLini*0.1)-1) ) then
   begin
     k:=k+round(iloscLini*0.1);

   FloatSpinEditWagaWzorcowego.Value := strtofloat(MemoHistoria.Lines.ValueFromIndex[k]);  // bo linia 0 to jej nazwa czyli string 'ostatnia'
   SpinEditMetryWzorcowego.Value     :=   strtoint(MemoHistoria.Lines.ValueFromIndex[k+1]);
   FloatSpinEditFolia.Value          := strtofloat(MemoHistoria.Lines.ValueFromIndex[k+2]);                  // srednica ostatniej miezonej rolki
   SpinEditGilza.Value               :=   strtoint(MemoHistoria.Lines.ValueFromIndex[k+3]);
   ComboBoxGryf.Text                 :=            MemoHistoria.Lines.ValueFromIndex[k+4];
   label19.Caption                   :=            MemoHistoria.Lines.ValueFromIndex[k+5];  // nazwa foli

   end;

end;


procedure TForm1.Wczytaj(Sender:TObject); // na starcie wczytuje poprzednie wartosci do programu z pliku ostatnie.txt
  begin
    MemoPamiecOstatniego.Lines.LoadFromFile('ostatnia.txt');                                        // do memo wczytuje plik txt
    MemoHistoria.Lines.LoadFromFile('historia.txt');
    FloatSpinEditWagaWzorcowego.Value := strtofloat(MemoPamiecOstatniego.Lines.ValueFromIndex[1]);  // bo linia 0 to jej nazwa czyli string 'ostatnia'
    SpinEditMetryWzorcowego.Value     := strtoint(MemoPamiecOstatniego.Lines.ValueFromIndex[2]);
    FloatSpinEditFolia.Value          := strtofloat(MemoPamiecOstatniego.Lines.ValueFromIndex[3]);                  // srednica ostatniej miezonej rolki
    SpinEditGilza.Value               := strtoint(MemoPamiecOstatniego.Lines.ValueFromIndex[4]);
    ComboBoxGryf.Text                 := MemoPamiecOstatniego.Lines.ValueFromIndex[5];
    label19.Caption                   :=            'ostatnia'  ;        // nazwa foli
    iloscLini:=60; // zmienna okreslajaca ile lini w pliku txt trzymam
    k:=iloscLini;   // k sluzy do skakania po liniach


end;

procedure TForm1.Zapamietaj(Sender:TObject); // do zapamietywania w pliku txt ostatnich danych
var TF:TextFile;
  ll:integer;
begin

  MemoPamiecOstatniego.Lines.Clear;
  MemoPamiecOstatniego.Lines.Add('ostatnia');
  MemoPamiecOstatniego.Lines.Add(floattostr(FloatSpinEditWagaWzorcowego.Value)); // zapisze wage wzorcowego
  MemoPamiecOstatniego.Lines.Add(floattostr(SpinEditMetryWzorcowego.Value));     // zapisze metry wzorcowego
  MemoPamiecOstatniego.Lines.Add( floattostr( FloatSpinEditFolia.Value ));               // zapisze ostatnia srednice foli (po lewej stronie)
  MemoPamiecOstatniego.Lines.Add(inttostr(SpinEditGilza.Value));               // zapisze ostatnia srednice foli (po lewej stronie)
  MemoPamiecOstatniego.Lines.Add(ComboBoxGryf.Text);               // zapisze ostatnia srednice foli (po lewej stronie)

  AssignFile(TF, 'ostatnia.txt');
  ReWrite(TF);
  for ll:=0 to 5 do
  Writeln(TF, MemoPamiecOstatniego.Lines.ValueFromIndex[ll]);

  CloseFile(TF);
  k:=60;
 end;

procedure TForm1.ButtonPrzeliczZKiloNaMetryClick(Sender: TObject); // przycisk do przeliczania z kilogramow na metry
var
  wagaWalkaWzorcowego, wagaWalkaSzukanego, metryWalkaWzorcowego,
  wynikLiczeniaMetrow: double;
  wynikKgWStringu, wynikMetrWStringu: string;

begin
  wagaWalkaWzorcowego := FloatSpinEditWagaWzorcowego.Value * 1000;  // dla dokladnosci z przecinkiem
  metryWalkaWzorcowego := SpinEditMetryWzorcowego.Value;           // tu mi metr dokladnosci mi wystarczy
  wagaWalkaSzukanego := FloatSpinEditWagaSzukanego.Value * 1000;

  if (FloatSpinEditWagaSzukanego.Value > 0) then                 // szukam wagi
  begin
    wynikLiczeniaMetrow := (metryWalkaWzorcowego / wagaWalkaWzorcowego) * wagaWalkaSzukanego;

    wynikKgWStringu := FloatToStrF((wagaWalkaSzukanego * 0.001), fffixed, 8, 2);      // zaokraglam do dwuch miejsc po przecinku
    wynikMetrWStringu := FloatToStrF(wynikLiczeniaMetrow, fffixed, 8, 2);

    LabelWynikMetrow.Caption := wynikMetrWStringu + ' m';
    LabelWynikWagi.Caption := wynikKgWStringu + ' kg';                  // float na stringa robie
    SpinEditMetrySzukanego.Value := wynikLiczeniaMetrow;
  end;

end;

procedure TForm1.ButtonPrzeliczZMetrowNaKiloClick(Sender: TObject); // przycisk przeliczajacy z metrow na kilogramy
var
  wagaWalkaWzorcowego, metryWalkaWzorcowego, metryWalkaSzukanego,
  wynikLiczeniaWagi: double;
  wynikKgWStringu, wynikMetrWStringu: string;

begin
  wagaWalkaWzorcowego := FloatSpinEditWagaWzorcowego.Value * 1000;
  metryWalkaWzorcowego := SpinEditMetryWzorcowego.Value;     // tu mi metr dokladnosci mi wystarczy
  metryWalkaSzukanego := SpinEditMetrySzukanego.Value;


  if (SpinEditMetrySzukanego.Value > 0) then          // szukam metrow
  begin
    wynikLiczeniaWagi := ((wagaWalkaWzorcowego / metryWalkaWzorcowego) * metryWalkaSzukanego) * 0.001;

    wynikKgWStringu := FloatToStrF(wynikLiczeniaWagi, fffixed, 8, 2);    // zaokraglam do dwuch miejsc po przecinku
    wynikMetrWStringu := FloatToStrF(metryWalkaSzukanego, fffixed, 3, 2);

    LabelWynikWagi.Caption := wynikKgWStringu + ' kg';
    LabelWynikMetrow.Caption := wynikMetrWStringu + ' m';
    FloatSpinEditWagaSzukanego.Value := wynikLiczeniaWagi;

  end;


end;


procedure TForm1.Rysuj(Sender: TObject);  // rysuje kola-walki folii
var
   xgryf, ygryf, xgilza, ygilza, xfolia, yfolia, srodek,
  przesuniecie: integer;
  gryfgilzarozmiar, gryfgilzafoliarozmiar, gryfrozmiar, gilzarozmiar,
  foliarozmiar: double;
begin

  gryfrozmiar := StrToInt(form1.ComboBoxGryf.Text);   // nadajemy wartosc rozmiaru gryfu
  gilzarozmiar := form1.spineditgilza.Value;   // nadajemy wartosc rozmiaru gilzy
  foliarozmiar := form1.FloatSpinEditFolia.Value;    // nadajemy wartosc rozmiaru folii

  gryfgilzarozmiar := gryfrozmiar + (gilzarozmiar * 2);  // czyli grubosc gryfu plus dwie scianki gilzy
  gryfgilzafoliarozmiar := gryfrozmiar + (foliarozmiar * 2);  // bo mierze od gryfu a nie od gilzy
  form1.labelpoczatek.Caption := gryfgilzarozmiar.ToString;     // suma gryfu i gilzy
  form1.labelkoniec.Caption := gryfgilzafoliarozmiar.ToString;   // suma gryfu gilzy i foli
  przesuniecie := 50;                                           // przesuniecie tak zeby od samego rogu nie zaczynalo

  xfolia := przesuniecie;
  yfolia := xfolia + round(gryfgilzafoliarozmiar);

  srodek := round(yfolia * 0.5) + round(przesuniecie * 0.5);

  xgilza := srodek - round(gilzarozmiar + (0.5 * gryfrozmiar));
  ygilza := srodek + round(gilzarozmiar + (0.5 * gryfrozmiar));

  xgryf := srodek - round(0.5 * gryfrozmiar);
  ygryf := srodek + round(0.5 * gryfrozmiar);

  form1.panel1.Width := form1.Width;
  form1.Canvas.Pen.Width:=1;  // taka linia grubosc 1
  form1.Canvas.Pen.Style:=PsSolid;  // taka linia ciagla
  form1.canvas.Pen.color := clblack;  // kolor czarny

  form1.Canvas.Brush.Color := clwhite;
  form1.canvas.FillRect(0, 0, form1.Width, form1.Height);
  form1.Canvas.Brush.Color := clred;
  form1.canvas.Pen.color := clRed;
  form1.canvas.Ellipse(xfolia, xfolia, yfolia, yfolia);   // kolo folia
  form1.Canvas.Line(xfolia, srodek + 80, xfolia, 0);      // lewa linia foli
  form1.Canvas.Line(xfolia, 10, yfolia, 10);              // przekatna foli
  form1.Canvas.Line(yfolia, srodek + 80, yfolia, 0);      // prawa linia foli
  form1.Canvas.Font.Size := 12;
  form1.Canvas.TextOut(round(srodek - foliarozmiar * 0.3), 0,    gryfgilzafoliarozmiar.ToString);                                // wymiary
  form1.Canvas.Polygon([Point(xfolia, 10), Point(xfolia + 5, 5), Point(xfolia + 5, 15)]);  // lewy trujkacik na koncu lini
  form1.Canvas.Polygon([Point(yfolia, 10), Point(yfolia - 5, 5), Point(yfolia - 5, 15)]);  // prawy trujkacik na koncu lini


  form1.canvas.Pen.color := clyellow;        // zmiana koloru na gilze
  form1.Canvas.Brush.Color := clyellow;      // zmiana koloru na gilze
  form1.canvas.Ellipse(xgilza, xgilza, ygilza, ygilza);  // kolo gilzy

  form1.Canvas.Pen.Width:=1;  // taka linia grubosc 1
  form1.Canvas.Pen.Style:=PsSolid;  // taka linia ciagla
  form1.canvas.Pen.color := clblack;  // kolor czarny
  form1.Canvas.Brush.Color := clblack;

  form1.Canvas.Line(xgilza, srodek + 50, xgilza, 20);   // lewa linia gilzy
  form1.Canvas.Line(xgilza, 30, ygilza, 30);      // przekatna gilzy
  form1.Canvas.Line(ygilza, srodek + 50, ygilza, 20);   // prawa linia gilzy
  form1.Canvas.Polygon([Point(xgilza, 30), Point(xgilza + 5, 25),     Point(xgilza + 5, 35)]);   // lewy trujkacik na koncu lini
  form1.Canvas.Polygon([Point(ygilza, 30), Point(ygilza - 5, 25),     Point(ygilza - 5, 35)]);     // prawy trujkacik na koncu lini

  form1.Canvas.Brush.Color := clgray;
  form1.Canvas.Font.Color := clwhite;
  form1.Canvas.TextOut(srodek - 20, 20, gryfgilzarozmiar.ToString);  // tekst rozmiar gryfu
  form1.Canvas.Brush.Color := clgray;                 // kolorek gryfu
  form1.Canvas.Pen.Width:=10;                         // taka linia grubsza
  form1.Canvas.Pen.Color:=clgray;                     // kolorek gryfu
  form1.Canvas.Pen.Style:=PsDash;                     // taka linia przerywana
  form1.canvas.Ellipse(xgryf, xgryf, ygryf, ygryf);   // kolo gryfu


end;


end.
