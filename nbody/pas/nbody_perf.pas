program NBodyPerf;

{$mode objfpc}
uses
  sysutils, math, unix;

const
  N = 10000;             // Number of bodies
  STEPS = 10;            // Number of simulation steps
  DT = 0.01;             // Time step
  G = 6.67430e-11;       // Gravitational constant

type
  TBody = record
    x, y, z: Double;
    vx, vy, vz: Double;
    mass: Double;
  end;

var
  Bodies: array of TBody;

function GetTimeSec: Double;
var
  tv: TimeVal;
begin
  fpgettimeofday(@tv, nil);
  Result := tv.tv_sec + tv.tv_usec * 1e-6;
end;

procedure InitBodies(var B: array of TBody);
var
  i: Integer;
begin
  Randomize;
  for i := 0 to High(B) do
  begin
    B[i].x := Random * 1e5;
    B[i].y := Random * 1e5;
    B[i].z := Random * 1e5;
    B[i].vx := 0.0;
    B[i].vy := 0.0;
    B[i].vz := 0.0;
    B[i].mass := Random * 1e22 + 1e20;
  end;
end;

procedure Simulate(var B: array of TBody; Steps: Integer; dt: Double);
var
  s, i, j: Integer;
  fx, fy, fz, dx, dy, dz, dist, force: Double;
begin
  for s := 1 to Steps do
  begin
    for i := 0 to High(B) do
    begin
      fx := 0; fy := 0; fz := 0;
      for j := 0 to High(B) do
      begin
        if i = j then Continue;
        dx := B[j].x - B[i].x;
        dy := B[j].y - B[i].y;
        dz := B[j].z - B[i].z;
        dist := sqrt(dx*dx + dy*dy + dz*dz) + 1e-9;
        force := G * B[i].mass * B[j].mass / (dist * dist);
        fx += force * dx / dist;
        fy += force * dy / dist;
        fz += force * dz / dist;
      end;
      B[i].vx += fx / B[i].mass * dt;
      B[i].vy += fy / B[i].mass * dt;
      B[i].vz += fz / B[i].mass * dt;
    end;

    for i := 0 to High(B) do
    begin
      B[i].x += B[i].vx * dt;
      B[i].y += B[i].vy * dt;
      B[i].z += B[i].vz * dt;
    end;
  end;
end;

var
  startTime, endTime: Double;
  i: Integer;
begin
  Writeln('Running N-body simulation with ', N, ' bodies for ', STEPS, ' steps...');
  Writeln('Technology: Pascal/FPC');

  SetLength(Bodies, N);
  InitBodies(Bodies);

  startTime := GetTimeSec;
  Simulate(Bodies, STEPS, DT);
  endTime := GetTimeSec;

  Writeln(N, '-bodies for ', STEPS, ' steps: ', FormatFloat('0.000000', endTime - startTime), ' seconds');
end.

