program FFTPerf;

{$mode objfpc}
uses
  sysutils, math, unix;

const
  N = 1 shl 20;
  PI = 3.14159265358979323846;

type
  TComplex = record
    re, im: Double;
  end;

var
  data: array of TComplex;

function GetTimeSec: Double;
var
  tv: TimeVal;
begin
  fpgettimeofday(@tv, nil);
  Result := tv.tv_sec + tv.tv_usec * 1e-6;
end;

procedure FFT(var x: array of TComplex; n: Integer);
var
  even, odd: array of TComplex;
  i: Integer;
  t, u: TComplex;
  angle, cosA, sinA: Double;
begin
  if n <= 1 then Exit;

  SetLength(even, n div 2);
  SetLength(odd, n div 2);

  for i := 0 to (n div 2) - 1 do
  begin
    even[i] := x[2 * i];
    odd[i] := x[2 * i + 1];
  end;

  FFT(even, n div 2);
  FFT(odd, n div 2);

  for i := 0 to (n div 2) - 1 do
  begin
    angle := -2 * PI * i / n;
    cosA := cos(angle);
    sinA := sin(angle);
    t.re := cosA * odd[i].re - sinA * odd[i].im;
    t.im := sinA * odd[i].re + cosA * odd[i].im;

    u := even[i];
    x[i].re := u.re + t.re;
    x[i].im := u.im + t.im;
    x[i + n div 2].re := u.re - t.re;
    x[i + n div 2].im := u.im - t.im;
  end;
end;

var
  i: Integer;
  startTime, endTime: Double;
begin
  Writeln('Generating ', N, '-point complex FFT input...');
  Writeln('Technology: Pascal/FPC');

  SetLength(data, N);
  for i := 0 to N - 1 do
  begin
    data[i].re := i mod 256;
    data[i].im := 0.0;
  end;

  startTime := GetTimeSec;
  FFT(data, N);
  endTime := GetTimeSec;

  Writeln('FFT ', N, ' points: ', FormatFloat('0.000000', endTime - startTime), ' seconds');
end.

