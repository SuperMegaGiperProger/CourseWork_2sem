unit MapLoaderUnit;
      
//----------------------------------------------------------------------------//

interface

uses
  GraphUnit, Dialogs, HashUnit, SysUtils, GeoUnit, ListOfPointersUnit;

const
  MIN_CELL_CAPARCITY = 0.01;  // km

var
  topBorder, bottomBorder, leftBorder, rightBorder: real;  // in Decart coord
  memorySize: integer = 100 * 1024 * 1024;  // to store graph

function LoadMapFromFile(fileName: string): boolean;

//----------------------------------------------------------------------------//

implementation

function min(a, b: real): real;
begin
  if a < b then result := a
  else result := b;
end;

function movingType(str: string): TMovingType;
begin
  result := foot;
  if str = 'car' then result := car
  else if str = 'plane' then result := plane;
end;

function LoadMapFromFile(fileName: string): boolean;
var
  f: TextFile;
  str: string;
  id: int64;
  lat, lon: real;
  v1, v2: TVertexPt;
  rev: boolean;
  width: byte;
  mov: TMovingType;
  maxLat, minLat, maxLon, minLon: real;
  vertList: THashList;
  k, h, w: real;
  i: integer;
  it: TEltPt;
  v: TVertex;

  filled: boolean;
  cnt, j: integer;
begin
  maxLat := -90;
  minLat := 90;
  maxLon := -180;
  minLon := 180;
  result := true;
  try
    clear(mapGraph);
    vertList := createHashList(standartHashFunc);
    Assign(f, fileName);
    Reset(f);
    try
      repeat
        readln(f, str);
      until str = 'vertices';
      while not eof(f) do
      begin
        readln(f, str);
        if str = '' then break;
        id := StrToInt64(str);
        readln(f, lat);
        readln(f, lon);
        maximize(maxLat, lat);
        minimize(minLat, lat);
        maximize(maxLon, lon);
        minimize(minLon, lon);
        createVertex(lat, lon, id, vertList);
      end;
      if eof(f) then showMessage('endoffile');
      repeat
        readln(f, str);
      until str = 'edges';
      {# movingType(car, foot, plane)
      # weight(lanes number)(if foot then weight = 1)
      # reversed(oneway=no)
      # links
      # \n                                           }
      while not eof(f) do
      begin
        readln(f, str);
        if str = '' then continue;
        mov := movingType(str);
        readln(f, width);
        readln(f, str);
        rev := (str = 'True');
        readln(f, id);
        v1 := TVertexPt(get(vertList, id, correctVertexId)^.data);
        while not eof(f) do
        begin
          readln(f, str);
          if str = '' then break;
          id := StrToInt64(str);
          v2 := TVertexPt(get(vertList, id, correctVertexId)^.data);
          createEdge(v1, v2, distation(v1, v2), width, mov, rev);
          v1 := v2;
        end;
      end;
    except
      ShowMessage('������������ ����');
      result := false;
      //on E : Exception do
        //ShowMessage(E.ClassName+' ������ � ���������� : '+E.Message);
    end;
  except
    ShowMessage('������ ������ �����');
    result := false;
  end;
  //// creating hash matrix
  leftBorder := getXDecartCoordinates(minLon);
  rightBorder := getXDecartCoordinates(maxLon);
  bottomBorder := getYDecartCoordinates(minLat);
  topBorder := getYDecartCoordinates(maxLat);
  h := topBorder - bottomBorder;  // height = max(cy) - min(cy)
  w := rightBorder - leftBorder;  // width = max(cx) - min(cx)
  k := trunc(sqrt((memorySize div SizeOf(TListOfPointers)) / (h * w)));
    // k = trunc(mem / S)  // S = height * width  // k = 1 / cell capacity
  minimize(k, 1 / MIN_CELL_CAPARCITY);
  w := w * k;
  h := h * k;
  mapGraph := CreateHashMatrix(trunc(h), trunc(w), trunc(k),
    leftBorder, bottomBorder, matrixHashFunc);
  //// filling in matrix
  for i := 0 to vertList.size - 1 do
  begin
    filled := false;
    it := vertList.table[i];
    while it <> nil do
    begin
      v := TVertexPt(it^.data)^;
      push(mapGraph, getYDecartCoordinates(v.latitude),
        getXDecartCoordinates(v.longitude), it^.data);
      it := it^.next;
    end;
  end;
  clear(vertList);

  cnt := 0;
  for i := 0 to mapGraph.height - 1 do
    for j := 0 to mapGraph.width - 1 do
      if mapGraph.table[i][j] <> nil then inc(cnt);
  ShowMessage(FloatToStr(cnt * 100.0 / (mapGraph.height * mapGraph.width)) + ' %');
end;

//----------------------------------------------------------------------------//

end.
