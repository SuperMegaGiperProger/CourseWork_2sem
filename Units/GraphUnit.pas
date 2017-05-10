unit GraphUnit;

//----------------------------------------------------------------------------//

interface

uses
  listOfPointersUnit, EdgeUnit, Dialogs;

type
  TVertexPt = ^TVertex;
  TVertex = record
    latitude, longitude: real;  // coordinates
    edgesList: TListOfPointers;  // list of TEdge
    distation: real;  // distation to some vertex
    parent: TVertexPt;  // vertex from which we came
    used: boolean;  // flag
  end;
  TMovingType = (plane, car, foot);     // you can go by foot beside a road
  TMovingTypeSet = set of TMovingType;  // in any direction
  TEdge = record
    road: TRoadGraphPt;
    weight: real;  // in meters
    movingType: TMovingType;
    endPoint: TVertexPt;  // end of the edge
  end;
  TEdgePt = ^TEdge;
  TGraphList = TListOfPointers;  // list of TVertex

const
  INF = 1000000000;  // infinity way
var
  mapGraph: TGraphList = nil;

function createVertex(latitude, longitude: real): TVertexPt;
function createEdge(a, b: TVertexPt; weight: real;
  movingTYpe: TMovingType; road: TRoadGraphPt = nil;
  reversible: boolean = false): TEdgePt;
function psevdoDistation(a, b: TVertex): real;  // "distation" in degrees
function getTheShortestWay(s, f: TVertexPt; out distation: real;
  out way: TListOfPointers; movingTypeSet: TMovingTypeSet = [car, foot, plane]):
  boolean;
  // return does way exist or not
function getTheShortestWayThroughtSeveralPoints(point: array of TVertexPt;
  out distation: real; out way: TListOfPointers;
  movingTypeSet: TMovingTypeSet = [car, foot, plane]): boolean;
  // return does way exist or not
function getTheShortestWayThroughtSeveralPointsWithStart(
  point: array of TVertexPt; out distation: real; out way: TListOfPointers;
  movingTypeSet: TMovingTypeSet = [car, foot, plane]): boolean;
  // start := first point
function getTheShortestWayThroughtSeveralPointsWithFinish(point: array of TVertexPt;
  out distation: real; out way: TListOfPointers;
  movingTypeSet: TMovingTypeSet = [car, foot, plane]): boolean;
  // finish := last point
function getTheShortestWayThroughtSeveralPointsWithStartAndFinish(
  point: array of TVertexPt; out distation: real; out way: TListOfPointers;
  movingTypeSet: TMovingTypeSet = [car, foot, plane]): boolean;
  // start := first point; finish := last point

//----------------------------------------------------------------------------//

implementation

type
  TGamiltonWay = record
    i, mask, mask0: integer;
  end;
  TGamiltonWayPt = ^TgamiltonWay;

function getGamiltonWayPt(i, mask0: integer; dmask: integer = 0): TGamiltonWayPt;
begin
  new(result);
  result^.i := i;
  result^.mask0 := mask0;
  result^.mask := mask0 - dmask;
end;

procedure min(var a: real; b: real);  // a := min(a, b);
begin
  if a > b then a := b;
end;

function getTheShortestWayThroughtSeveralPointsWithFinish(point: array of TVertexPt;
  out distation: real; out way: TListOfPointers;
  movingTypeSet: TMovingTypeSet = [car, foot, plane]): boolean;
var
  g: array of array of real;
  used: array of array of boolean;
  d: array of array of real;
  wayPart: array of array of TListOfPointers;
  stack: TListOfPointers;
  itEnd: TEltPt;
  it: TGamiltonWayPt;
  n, i, i0, j, mask, mask00, start, finish: integer;
begin
  ////preparation
  n := length(point);
  SetLength(g, n);
  SetLength(used, n);
  SetLength(d, n);
  SetLEngth(wayPart, n);
  stack := nil;
  distation := INF;
  start := 0;
  finish := n - 1;
  ////creating graph
  for i := 0 to n - 1 do
  begin
    SetLength(g[i], n);
    SetLength(used[i], 1 shl n);
    SetLength(d[i], 1 shl n);
    SetLEngth(wayPart[i], n);
    for j := 0 to n - 1 do getTheShortestWay(point[i], point[j], g[i][j],
      wayPart[i][j], movingTypeSet);
    for mask := 0 to (1 shl n) - 1 do
    begin
      d[i][mask] := INF;
      used[i][mask] := false;
    end;
    d[i][0] := g[i][finish];
  end;
  ////getting the shortes way throught all points which starts in i0
  for i0 := 0 to finish - 1 do
  begin
    mask00 := (1 shl finish) - 1 - (1 shl i0);
    if not used[i0][mask00] then
    begin
      clear(stack);
      push_top(stack, getGamiltonWayPt(i0, mask00));
      while not isEmpty(stack) do
      begin
        it := stack^.data;
        if used[it^.i][it^.mask0] then
        begin
          pop_top(stack);
          continue;
        end;
        for j := 0 to finish - 1 do
          if (it^.mask and (1 shl j)) <> 0 then
            if used[j][it^.mask0 - (1 shl j)] then
            begin
              min(d[it^.i][it^.mask0], d[j][it^.mask0 - (1 shl j)] + g[it^.i][j]);
              dec(it^.mask, 1 shl j);
            end
            else
              push_top(stack, getGamiltonWayPt(j, it^.mask0 - (1 shl j)));
        if it^.mask = 0 then used[it^.i][it^.mask0] := true;
      end;
    end;
    if distation > d[i0][mask00] then
    begin
      distation := d[i0][mask00];
      start := i0;
    end;
  end;
  result := (distation < INF);
  if not result then exit;
  /////getting way
  way := nil;
  i := start;
  mask := (1 shl finish) - 1 - (1 shl start);
  //push_top(way, point[i]);
  //itEnd := way;
  while mask <> 0 do
    for j := 0 to finish - 1 do
      if ((mask and (1 shl j)) <> 0) and
        (d[i][mask] = d[j][mask - (1 shl j)] + g[i][j]) then
      begin
        push_top(way, wayPart[i][j]);
        i := j;
        dec(mask, 1 shl j);
        break;
      end;
  push_top(way, wayPart[i][finish]);
end;

function getTheShortestWayThroughtSeveralPointsWithStartAndFinish(
  point: array of TVertexPt; out distation: real; out way: TListOfPointers;
  movingTypeSet: TMovingTypeSet = [car, foot, plane]): boolean;
var
  g: array of array of real;
  used: array of array of boolean;
  d: array of array of real;
  wayPart: array of array of TListOfPointers;
  stack: TListOfPointers;
  itEnd: TEltPt;
  it: TGamiltonWayPt;
  n, i, i0, j, mask, mask00, start, finmask, finish: integer;
begin
  ////preparation
  n := length(point);
  SetLength(g, n);
  SetLength(used, n);
  SetLength(d, n);
  SetLEngth(wayPart, n);
  stack := nil;
  distation := INF;
  start := 0;
  finish := n - 1;
  finmask := 1 shl finish;
  ////creating graph
  for i := 0 to n - 1 do
  begin
    SetLength(g[i], n);
    SetLength(used[i], 1 shl n);
    SetLength(d[i], 1 shl n);
    SetLEngth(wayPart[i], n);
    for j := 0 to n - 1 do getTheShortestWay(point[i], point[j], g[i][j],
      wayPart[i][j], movingTypeSet);
    for mask := 0 to (1 shl n) - 1 do
    begin
      d[i][mask] := INF;
      used[i][mask] := false;
    end;
    d[i][0] := g[i][finish];
  end;
  ////getting the shortes way throught all points which starts in i0
  i0 := start;
    mask00 := (1 shl finish) - 1 - (1 shl i0);
    if not used[i0][mask00] then
    begin
      clear(stack);
      push_top(stack, getGamiltonWayPt(i0, mask00));
      while not isEmpty(stack) do
      begin
        it := stack^.data;
        if used[it^.i][it^.mask0] then
        begin
          pop_top(stack);
          continue;
        end;
        for j := 0 to n - 1 - 1 do
          if (it^.mask and (1 shl j)) <> 0 then
            if used[j][it^.mask0 - (1 shl j)] then
            begin
              min(d[it^.i][it^.mask0], d[j][it^.mask0 - (1 shl j)] + g[it^.i][j]);
              dec(it^.mask, 1 shl j);
            end
            else
              push_top(stack, getGamiltonWayPt(j, it^.mask0 - (1 shl j)));
        if it^.mask = 0 then used[it^.i][it^.mask0] := true;
      end;
    end;
  distation := d[i0][mask00];
  result := (distation < INF);
  if not result then exit;
  /////getting way
  way := nil;
  i := start;
  mask := (1 shl finish) - 1 - (1 shl start);
  //push_top(way, point[i]);
  //itEnd := way;
  while mask <> 0 do
    for j := 0 to n - 1 - 1 do
      if ((mask and (1 shl j)) <> 0) and
        (d[i][mask] = d[j][mask - (1 shl j)] + g[i][j]) then
      begin
        push_top(way, wayPart[i][j]);
        i := j;
        dec(mask, 1 shl j);
        break;
      end;
  push_top(way, wayPart[i][finish]);
end;

function getTheShortestWayThroughtSeveralPointsWithStart(
  point: array of TVertexPt; out distation: real; out way: TListOfPointers;
  movingTypeSet: TMovingTypeSet = [car, foot, plane]): boolean;
var
  g: array of array of real;
  used: array of array of boolean;
  d: array of array of real;
  wayPart: array of array of TListOfPointers;
  stack: TListOfPointers;
  itEnd: TEltPt;
  it: TGamiltonWayPt;
  n, i, i0, j, mask, mask00, start: integer;
begin
  ////preparation
  n := length(point);
  SetLength(g, n);
  SetLength(used, n);
  SetLength(d, n);
  SetLEngth(wayPart, n);
  stack := nil;
  distation := INF;
  start := 0;
  ////creating graph
  for i := 0 to n - 1 do
  begin
    SetLength(g[i], n);
    SetLength(used[i], 1 shl n);
    SetLength(d[i], 1 shl n);
    SetLEngth(wayPart[i], n);
    for j := 0 to n - 1 do getTheShortestWay(point[i], point[j], g[i][j],
      wayPart[i][j], movingTypeSet);
    for mask := 0 to (1 shl n) - 1 do
    begin
      d[i][mask] := INF;
      used[i][mask] := false;
    end;
    d[i][0] := 0;
  end;
  ////getting the shortes way throught all points which starts in i0
  i0 := start;
    mask00 := (1 shl n) - 1 - (1 shl i0);
    if not used[i0][mask00] then
    begin
      clear(stack);
      push_top(stack, getGamiltonWayPt(i0, mask00));
      while not isEmpty(stack) do
      begin
        it := stack^.data;
        if used[it^.i][it^.mask0] then
        begin
          pop_top(stack);
          continue;
        end;
        for j := 0 to n - 1 do
          if (it^.mask and (1 shl j)) <> 0 then
            if used[j][it^.mask0 - (1 shl j)] then
            begin
              min(d[it^.i][it^.mask0], d[j][it^.mask0 - (1 shl j)] + g[it^.i][j]);
              dec(it^.mask, 1 shl j);
            end
            else
              push_top(stack, getGamiltonWayPt(j, it^.mask0 - (1 shl j)));
        if it^.mask = 0 then used[it^.i][it^.mask0] := true;
      end;
    end;
  distation := d[i0][mask00];
  result := (distation < INF);
  if not result then exit;
  /////getting way
  way := nil;
  i := start;
  mask := (1 shl n) - 1 - (1 shl start);
  //push_top(way, point[i]);
  //itEnd := way;
  while mask <> 0 do
    for j := 0 to n - 1 do
      if ((mask and (1 shl j)) <> 0) and
        (d[i][mask] = d[j][mask - (1 shl j)] + g[i][j]) then
      begin
        push_top(way, wayPart[i][j]);
        i := j;
        dec(mask, 1 shl j);
        break;
      end;
end;

function getTheShortestWayThroughtSeveralPoints(point: array of TVertexPt;
  out distation: real; out way: TListOfPointers;
  movingTypeSet: TMovingTypeSet = [car, foot, plane]): boolean;
var
  g: array of array of real;
  used: array of array of boolean;
  d: array of array of real;
  wayPart: array of array of TListOfPointers;
  stack: TListOfPointers;
  itEnd: TEltPt;
  it: TGamiltonWayPt;
  n, i, i0, j, mask, mask00, start: integer;
begin
  ////preparation
  n := length(point);
  SetLength(g, n);
  SetLength(used, n);
  SetLength(d, n);
  SetLEngth(wayPart, n);
  stack := nil;
  distation := INF;
  start := 0;
  ////creating graph
  for i := 0 to n - 1 do
  begin
    SetLength(g[i], n);
    SetLength(used[i], 1 shl n);
    SetLength(d[i], 1 shl n);
    SetLEngth(wayPart[i], n);
    for j := 0 to n - 1 do getTheShortestWay(point[i], point[j], g[i][j],
      wayPart[i][j], movingTypeSet);
    for mask := 0 to (1 shl n) - 1 do
    begin
      d[i][mask] := INF;
      used[i][mask] := false;
    end;
    d[i][0] := 0;
  end;
  ////getting the shortes way throught all points which starts in i0
  for i0 := 0 to n - 1 do
  begin
    mask00 := (1 shl n) - 1 - (1 shl i0);
    if not used[i0][mask00] then
    begin
      clear(stack);
      push_top(stack, getGamiltonWayPt(i0, mask00));
      while not isEmpty(stack) do
      begin
        it := stack^.data;
        if used[it^.i][it^.mask0] then
        begin
          pop_top(stack);
          continue;
        end;
        for j := 0 to n - 1 do
          if (it^.mask and (1 shl j)) <> 0 then
            if used[j][it^.mask0 - (1 shl j)] then
            begin
              min(d[it^.i][it^.mask0], d[j][it^.mask0 - (1 shl j)] + g[it^.i][j]);
              dec(it^.mask, 1 shl j);
            end
            else
              push_top(stack, getGamiltonWayPt(j, it^.mask0 - (1 shl j)));
        if it^.mask = 0 then used[it^.i][it^.mask0] := true;
      end;
    end;
    if distation > d[i0][mask00] then
    begin
      distation := d[i0][mask00];
      start := i0;
    end;
  end;
  result := (distation < INF);
  if not result then exit;
  /////getting way
  way := nil;
  i := start;
  mask := (1 shl n) - 1 - (1 shl start);
  //push_top(way, point[i]);
  //itEnd := way;
  while mask <> 0 do
    for j := 0 to n - 1 do
      if ((mask and (1 shl j)) <> 0) and
        (d[i][mask] = d[j][mask - (1 shl j)] + g[i][j]) then
      begin
        push_top(way, wayPart[i][j]);
        i := j;
        dec(mask, 1 shl j);
        break;
      end;
end;

procedure minDistationVertex(var a: TVertexPt; b: TVertexPt); // a := min(a, b);
begin
  if not b^.used and (a^.distation > b^.distation) then a := b;
end;

procedure relax(a, b: TVertexPt; weight: real);
begin
  if a^.distation > b^.distation + weight then
  begin
    a^.distation := b^.distation + weight;
    a^.parent := b;
  end;
end;

procedure preparation;
var
  it: TEltPt;
begin
  it := mapGraph;
  while it <> nil do
  begin
    with TVertexPt(it^.data)^ do
    begin
      parent := nil;
      used := false;
      distation := INF;
    end;
    it := it^.next;
  end;
end;

function getTheShortestWay(s, f: TVertexPt; out distation: real;
  out way: TListOfPointers; movingTypeSet: TMovingTypeSet = [car, foot, plane]):
  boolean;
var
  it, itV2, edgeIt: TEltPt;
  itV: TVertexPt;
  minV: TVertexPt;  // vertex with min distation
  infV: TVertex;
begin
  preparation;
  result := false;
  way := nil;
  s^.distation := 0;
  infV.distation := INF;
  infV.used := true;
  //// searching the shortest way
  while not f^.used do
  begin
    it := mapGraph;
    minV := @infV;
    while it <> nil do
    begin
      minDistationVertex(minV, it^.data);
      it := it^.next;
    end;
    if minV^.used or (minV^.distation >= INF) then exit;
    if minV = f then
    begin
      result := true;
      break;
    end;
    minV^.used := true;
    edgeIt := minV^.edgesList;
    while edgeIt <> nil do
    begin
      with TEdgePt(edgeIt^.data)^ do
        if (movingType in movingTypeSet) and not endPoint^.used then
          relax(endPoint, minV, weight);
      edgeIt := edgeIt^.next;
    end;
  end;
  distation := f^.distation;
  if not result then exit;
  //// restoring way
  itV := f;
  while itV^.parent <> nil do
  begin
    itV2 := itV^.parent^.edgesList;
    while (itV2 <> nil) and (TEdgePt(itV2^.data)^.endPoint <> itV) do
      itV2 := itV2^.next;
    if (itV2 = nil) or (TEdgePt(itV2^.data)^.endPoint <> itV) then
    begin
      showMessage('Output error');
      exit;
    end;
    push_top(way, itV2^.data);
    itV := itV^.parent;
  end;
end;

function psevdoDistation(a, b: TVertex): real;
begin
  result := sqrt((a.latitude - b.latitude) * (a.latitude - b.latitude) +
    (a.longitude - b.longitude) * (a.longitude - b.longitude));
end;

function createEdge(a, b: TVertexPt; weight: real;
  movingTYpe: TMovingType; road: TRoadGraphPt = nil;
  reversible: boolean = false): TEdgePt;
var
  newE: TEdgePt;
begin
  new(newE);
  newE^.weight := weight;
  newE^.movingType := movingType;
  newE^.endPoint := b;
  if road = nil then new(newE^.road)
  else newE^.road := road;
  newE^.road^ := nil;
  createRoadVertex(newE^.road^, a^.latitude, a^.longitude);
  push_top(a^.edgesList, newE);
  result := newE;
  if reversible then
    createEdge(b, a, weight, movingType)^.road := newE^.road;
  if movingType = car then createEdge(a, b, weight, foot, newE^.road, true);
end;

function compareVertices(a, b: Pointer): boolean;
begin
  if TVertexPt(a)^.latitude = TVertexPt(b)^.latitude then
    result := (TVertexPt(a)^.longitude < TVertexPt(b)^.longitude)
  else
    result := (TVertexPt(a)^.latitude < TVertexPt(b)^.latitude);
end;

function createVertex(latitude, longitude: real): TVertexPt;
var
  newV: TVertexPt;
begin
  new(newV);
  newV^.latitude := latitude;
  newV^.longitude := longitude;
  with newV^ do
  begin
    edgesList := nil;
    parent := nil;
    used := false;
    distation := INF;
  end;
  push_top(mapGraph, newV);
  result := newV;
  //push(mapGraph, newV, compareVertices);
end;

//----------------------------------------------------------------------------//

end.
