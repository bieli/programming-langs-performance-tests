unit Vector2D;

{$mode objfpc}{$H+}

interface

type
  TVector2D = record
    x, y: Double;
  end;

function Add(a, b: TVector2D): TVector2D;
function Subtract(a, b: TVector2D): TVector2D;
function Scale(v: TVector2D; s: Double): TVector2D;
function Divide(v: TVector2D; s: Double): TVector2D;
function Magnitude(v: TVector2D): Double;
function Normalize(v: TVector2D): TVector2D;
function Angle(a, b: TVector2D): Double;

implementation

uses Math;

function Add(a, b: TVector2D): TVector2D;
begin
  Result.x := a.x + b.x;
  Result.y := a.y + b.y;
end;

function Subtract(a, b: TVector2D): TVector2D;
begin
  Result.x := a.x - b.x;
  Result.y := a.y - b.y;
end;

function Scale(v: TVector2D; s: Double): TVector2D;
begin
  Result.x := v.x * s;
  Result.y := v.y * s;
end;

function Divide(v: TVector2D; s: Double): TVector2D;
begin
  Result.x := v.x / s;
  Result.y := v.y / s;
end;

function Magnitude(v: TVector2D): Double;
begin
  Result := Sqrt(Sqr(v.x) + Sqr(v.y));
end;

function Normalize(v: TVector2D): TVector2D;
var
  mag: Double;
begin
  mag := Magnitude(v);
  if mag <> 0 then
    Result := Divide(v, mag)
  else
    Result := v;
end;

function Angle(a, b: TVector2D): Double;
var
  cross, dot: Double;
begin
  cross := a.x * b.y - a.y * b.x;
  dot := a.x * b.x + a.y * b.y;
  Result := ArcTan2(cross, dot);
end;

end.

