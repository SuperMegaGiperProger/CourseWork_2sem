unit GeoUnit;
 
//----------------------------------------------------------------------------//

interface

uses
  math, graphUnit;

const
  R = 6371;  // km

function radToDeg(rad: real): real;
function degToRad(deg: real): real;
function getLatitude(y: real): real;  // deg
function getLongitude(x: real): real;  // deg
function getXDecartCoordinates(longitude: real): real;  // km
function getYDecartCoordinates(latitude: real): real;   // km
function distation(v1, v2: TVertexPt): real;  // km
procedure maximize(var a: real; b: real);
procedure minimize(var a: real; b: real);

//----------------------------------------------------------------------------//

implementation

function radToDeg(rad: real): real;
begin
  result := rad * 180.0 / pi;
end;

function degToRad(deg: real): real;
begin
  result := deg * pi / 180.0;
end;

function getLatitude(y: real): real;
begin
  result := arctan(exp(y / r)) - pi / 4.0;
  result := radToDeg(result * 2.0);
end;

function getLongitude(x: real): real;
begin
  result := radToDeg(x / R);
end;

function getXDecartCoordinates(longitude: real): real;
begin
  result := R * degToRad(longitude);
end;

function getYDecartCoordinates(latitude: real): real;
begin
  result := tan(pi / 4.0 + degToRad(latitude) / 2.0);
  result := R * ln(result);
end;

function distation(v1, v2: TVertexPt): real;
begin
  result := sin(v1^.latitude) * sin(v2^.latitude) +
    cos(v1^.latitude) * cos(v2^.latitude) * cos(v1^.longitude - v2^.longitude);
  result := R * arccos(result);
end;
 
procedure maximize(var a: real; b: real);
begin
  if a < b then a := b;
end;

procedure minimize(var a: real; b: real);
begin
  if a > b then a := b;
end;

//----------------------------------------------------------------------------//

end.
