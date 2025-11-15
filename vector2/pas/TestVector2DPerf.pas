program TestVector2DPerf;

{$mode objfpc}{$H+}

uses
  SysUtils, DateUtils, Vector2D;

const
  Iterations = 100000000;

var
  i: Integer;
  startTime, endTime: TDateTime;

procedure Benchmark(const labelText: string; operation: TProcedure);
begin
  startTime := Now;
  operation;
  endTime := Now;
  WriteLn(labelText, ': ', FormatDateTime('s.zzzzzzzz', endTime - startTime), ' seconds');
end;

procedure TestAdd;
var i: Integer; v1, v2: TVector2D;
begin
  v1.x := 1.0; v1.y := 2.0;
  v2.x := 3.0; v2.y := 4.0;
  for i := 1 to Iterations do
    Add(v1, v2);
end;

procedure TestSubtract;
var i: Integer; v1, v2: TVector2D;
begin
  v1.x := 1.0; v1.y := 2.0;
  v2.x := 3.0; v2.y := 4.0;
  for i := 1 to Iterations do
    Subtract(v1, v2);
end;

procedure TestScale;
var i: Integer; v1: TVector2D;
begin
  v1.x := 1.0; v1.y := 2.0;
  for i := 1 to Iterations do
    Scale(v1, 2.5);
end;

procedure TestNormalize;
var i: Integer; v1: TVector2D;
begin
  v1.x := 1.0; v1.y := 2.0;
  for i := 1 to Iterations do
    Normalize(v1);
end;

procedure TestAngle;
var i: Integer; res: Double; v1, v2: TVector2D;
begin
  v1.x := 1.0; v1.y := 2.0;
  v2.x := 3.0; v2.y := 4.0;
  for i := 1 to Iterations do
    Angle(v1, v2);
end;

begin
  WriteLn('Technology: Pascal/FPC');
  Benchmark('Addition', @TestAdd);
  Benchmark('Subtraction', @TestSubtract);
  Benchmark('Scaling', @TestScale);
  Benchmark('Normalization', @TestNormalize);
  Benchmark('Angle', @TestAngle);
end.

