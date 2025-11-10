program TestVectorsPerf;

{$mode objfpc}{$H+}
{$modeswitch advancedrecords}
{$optimization fastmath}

uses
  SysUtils, Math, Vectors;

const
  Iterations = 100000000;

var
  V1, V2, V3: TVector;
  T0, T1: QWord;

procedure Benchmark(const Name: string; const Proc: TProcedure);
begin
  T0 := GetTickCount64;
  Proc;
  T1 := GetTickCount64;
  WriteLn(Name, ': ', (T1 - T0) / 1000:0:4, ' seconds');
end;

procedure TestAdd;
var i: Integer;
begin
  for i := 1 to Iterations do
    V3 := V1 + V2;
end;

procedure TestSub;
var i: Integer;
begin
  for i := 1 to Iterations do
    V3 := V1 - V2;
end;

procedure TestCross;
var i: Integer;
begin
  for i := 1 to Iterations do
    V3 := V1 * V2;
end;

procedure TestScalar;
var i: Integer;
begin
  for i := 1 to Iterations do
    V3 := 2.5 * V1;
end;

procedure TestNorm;
var i: Integer;
begin
  for i := 1 to Iterations do
    V3 := Norm(V1);
end;

procedure TestAngle;
var i: Integer;
begin
  for i := 1 to Iterations do
    Mag(V1); Mag(V2); Ang(V1, V2);
end;

begin
  Randomize;
  V1 := Vector(Random, Random, Random);
  V2 := Vector(Random, Random, Random);

  WriteLn('Technology: Pascal/FPC');
  Benchmark('Addition', @TestAdd);
  Benchmark('Subtraction', @TestSub);
  Benchmark('Cross Product', @TestCross);
  Benchmark('Scalar Multiplication', @TestScalar);
  Benchmark('Normalization', @TestNorm);
  Benchmark('Angle', @TestAngle);
end.

