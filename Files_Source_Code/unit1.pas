unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, TAGraph,
  TASeries, TAMultiSeries;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Chart1: TChart;
    Chart1BubbleSeries1: TBubbleSeries;
    Chart1LineSeries1: TLineSeries;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

{функция
входные данные:  коэффициенты А,В,С и значение Х
выходные данные: значение квадратичной функции в точке Х}
function func(a,b,c,x:real):real;
begin
 func:=a*x*x+b*x+c;
end;

procedure TForm1.Button1Click(Sender: TObject);
var i,k,n: integer;
    a,b,c,xi,yi,x0,h:real;
    tLS:TLineSeries;       {объявляю переменную tLS - график по точкам}
    tBS:TBubbleSeries;     {объявляю переменную tBS - пузырьковая диаграмма}
begin
     {Перевод текста, введенного в поля для ввода, в число}
     Val(Edit1.Text,a,k);
     Val(Edit2.Text,b,k);
     Val(Edit3.Text,c,k);

     if ((a=0) and (b=0) and (c=0))
     then  ShowMessage('Вы ввели все нули!!!') {Вывод окна сообщения}
      else begin

     {Очистка области построения графиков}
     Chart1.ClearSeries;

     {Добавлю график tLS в Chart1
     и задам название,которое будет отображаться в Легенде}
     tLS:=TLineSeries.Create(Chart1);
     tLS.Title:='график функции '+FloatToStr(a)+'*x*x+'+FloatToStr(b)+'*x+'+FloatToStr(c);

     {Добавлю график tBS в Chart1, установлю цвет точек
     и задам название,которое будет отображаться в Легенде}
     tBS:=TBubbleSeries.Create(Chart1);
     tBS.BubbleBrush.Color:=TColor($ffff00);
     tBS.Title:='точки пересечения с осью Х';

     n:=500;
     h:=10/n;
     if (a=0) then x0:=0
     else x0:=-b/(2*a);
     for i:=-n to n do
    begin
      xi:=x0+i*h;
      yi:=func(a,b,c,xi); {Координаты точки параболы }
      tLS.AddXY(xi,yi);  {добавляю точку с указанными координатами к графику }
      if (func(a,b,c,xi)*func(a,b,c,xi-h)<=0)
                            then tBS.AddXY(xi-h/2,0,1.0); {отмечаю точкой пересечения с осью Х}
    end;
     Chart1.AddSeries(tLS); {добавляю точки, соединенные линией на график}
     Chart1.AddSeries(tBS); {добавляю точки, отмеченные кружочками}
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

end.

