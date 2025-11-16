program LinearSearchPerf;

{$mode objfpc}{$H+}

uses
  SysUtils, DateUtils;

const
  N = 1000000000;

type
  TIntArray = array of Integer;

function LinearSearch(arr: TIntArray; target: Integer): Integer;
var
  i: Integer;
begin
  for i := 0 to High(arr) do
    if arr[i] = target then
      Exit(i);
  Result := -1;
end;

procedure BenchmarkSearch(arr: TIntArray; target: Integer; labelText: string);
var
  startTime, endTime: TDateTime;
  index: Integer;
begin
  startTime := Now;
  index := LinearSearch(arr, target);
  endTime := Now;
  WriteLn(Format('%s: %s seconds',
    [labelText, FormatDateTime('s.zzz', endTime - startTime)]));
end;

var
  data: TIntArray;
  i: Integer;
begin
  WriteLn('Generating array of ', N, ' integers...and searching for values located at');
  WriteLn('Technology: Pascal/FPC');
  SetLength(data, N);
  for i := 0 to N - 1 do
    data[i] := i;

  BenchmarkSearch(data, data[N div 100], '0%');       // 0%
  BenchmarkSearch(data, data[N div 20], '5%');        // 5%
  BenchmarkSearch(data, data[N * 15 div 100], '15%'); // 15%
  BenchmarkSearch(data, data[N div 4], '25%');        // 25%
  BenchmarkSearch(data, data[N div 2], '50%');        // 50%
  BenchmarkSearch(data, data[N * 3 div 4], '75%');    // 75%
  BenchmarkSearch(data, data[N - 1], '100%');         // ~100%
end.

