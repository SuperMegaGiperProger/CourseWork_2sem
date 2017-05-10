unit DrawUnit;

interface                   

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GraphUnit, ExtCtrls, listOfPointersUnit, StdCtrls, Buttons, EdgeUnit;

type
  TForm1 = class(TForm)
    mapImage: TImage;
    BitBtn1: TBitBtn;
    Shape1: TShape;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure mapImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  STANDART_RADIUS = 0.00015;
  STANDART_WIDTH = 0.0001;

var
  Form1: TForm1;
  scale: real = 0.0001;
  latitude0: real = 53.93;
  longitude0: real =  27.58;

procedure drawGraph;

implementation

{$R *.dfm}

function getX(longitude: real): integer;
begin
  result := round((longitude - longitude0) / scale);
end;

function getY(latitude: real): integer;
begin
  result := round((latitude0 - latitude) / scale);
end;

procedure drawVertex(v: TVertex);
var
  x, y, r: integer;
begin
  with v do
  begin
    x := getX(longitude);
    y := getY(latitude);
    r := round(STANDART_RADIUS / scale);
  end;
  Form1.mapImage.Canvas.Pen.Width := 0;
  Form1.mapImage.Canvas.Ellipse(x - r, y - r, x + r, y + r);
end;

procedure drawRoadPart(x1, y1, x2, y2: integer);
begin
  with Form1.mapImage.Canvas do
  begin
    moveTo(x1, y1);
    lineTo(x2, y2);
  end;
end;

procedure drawRoad(list: TListOfPointers; style: TPenStyle; w: integer);
var
  it: TEltPt;
  x, y: integer;
begin
  it := list;
  Form1.mapImage.Canvas.Pen.Width := round(STANDART_WIDTH / scale) * w;
  Form1.mapImage.Canvas.Pen.Style := style;
  with TRoadVertexPt(it^.data)^ do
  begin
    x := getX(longitude);
    y := getY(latitude);
  end;
  Form1.mapImage.Canvas.moveTo(x, y);
  it := it^.next;
  while it <> nil do
  begin
    with TRoadVertexPt(it^.data)^ do
    begin
      x := getX(longitude);
      y := getY(latitude);
    end;
    with Form1.mapImage.Canvas do
    begin
      lineTo(x, y);
      moveTo(x, y);
    end;
    it := it^.next;
  end;
end;

procedure drawAllRoads(list: TListOfPointers);
var
  it: TEltPt;
begin
  it := list;
  while it <> nil do
  begin
    with TEdgePt(it^.data)^ do
      case movingType of
        car: drawRoad(road^, psSolid, 2);
        foot: drawRoad(road^, psDot, 1);
      end;
    it := it^.next;
  end;
end;

procedure drawGraph;
var
  it: TEltPt;
  v: TVertex;
begin
  Form1.mapImage.Picture.Graphic := nil;
  Form1.mapImage.Canvas.Brush.Color := clRed;
  Form1.mapImage.Canvas.Pen.Color := clRed;
  it := mapGraph;
  while it <> nil do
  begin
    v := TVertexPt(it^.data)^;
    drawVertex(v);
    drawAllRoads(v.edgesList);
    it := it^.next;
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  //scale := 1 / 10000;
  drawGraph;
end;

function findClosestVertex(X, Y: Integer): TVertexPt;
var
  closestVert: TVertexPt;
  it: TEltPt;
  v, mouseV: TVertex;
begin
  result := nil;
  if isEmpty(mapGraph) then exit;
  it := mapGraph;
  closestVert := TVertexPt(mapGraph^.data);
  with mouseV do
  begin
    latitude := -y * scale + latitude0;
    longitude := x * scale + longitude0;
  end;
  while it <> nil do
  begin
    v := TVertexPt(it^.data)^;
    if psevdoDistation(v, mouseV) < psevdoDistation(closestVert^, mouseV) then
      closestVert := it^.data;
    it := it^.next;
  end;
  result := closestVert;
end;

var
  start: TVertexPt;

procedure drawTheShortestWay(s, f: TVertexPt; movingTypeSet: TMovingTypeSet);
var
  it: TEltPt;
  dist: real;
  way: TListOfPointers;
begin
  if not getTheShortestWay(s, f, dist, way, movingTypeSet) then
  begin
    showMessage('���� �� ������..');
    exit;
  end;
  Form1.mapImage.Canvas.Brush.Color := clGreen;
  Form1.mapImage.Canvas.Pen.Color := clGreen;
  it := way;
  while it <> nil do
  begin
    drawRoad(TEdgePt(it^.data)^.road^, psDot, 2);
    it := it^.next;
  end;
end;

procedure drawTheShortestWayTroughtSeveralPoints(point: array of TVertexPt;
  start: boolean = false; finish: boolean = false;
  movingTypeSet: TMovingTypeSet = [car, foot, plane]);
var
  it, it2: TEltPt;
  dist: real;
  way: TListOfPointers;
  exist: boolean;
begin
  if finish and start then exist := getTheShortestWayThroughtSeveralPointsWithStartAndFinish(point, dist, way, movingTypeSet)
  else if finish then exist := getTheShortestWayThroughtSeveralPointsWithFinish(point, dist, way, movingTypeSet)
  else if start then exist := getTheShortestWayThroughtSeveralPointsWithStart(point, dist, way, movingTypeSet)
  else exist := getTheShortestWayThroughtSeveralPoints(point, dist, way, movingTypeSet);
  if not exist then
  begin
    showMessage('���� �� ������..');
    exit;
  end;
  Form1.mapImage.Canvas.Brush.Color := clGreen;
  Form1.mapImage.Canvas.Pen.Color := clGreen;
  it2 := way;
  while it2 <> nil do
  begin
    it := TEltPt(it2^.data);
    while it <> nil do
    begin
      drawRoad(TEdgePt(it^.data)^.road^, psDot, 2);
      it := it^.next;
    end;
    it2 := it2^.next;
  end;
end;

var
  movType: TMovingType = car;
  arr: array of TVertexPt;

procedure TForm1.mapImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  v: TVertexPt;
begin
  if isEmpty(mapGraph) then exit;
  //x := x - Form1.mapImage.Left;
  //y := y - Form1.mapImage.Top;
  v := findClosestVertex(x, y);
  Form1.mapImage.Canvas.Brush.Color := clBlue;
  Form1.mapImage.Canvas.Pen.Color := clBlue;
  drawVertex(v^);
  SetLength(arr, length(arr) + 1);
  arr[length(arr) - 1] := v;
  //if start = nil then start := v
  //else drawTheShortestWay(start, v, [movType]);
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  start := nil;
  movType := car;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  start := nil;
  movType := foot;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  SetLength(arr, 0);
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  drawTheShortestWayTroughtSeveralPoints(arr);
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  drawTheShortestWayTroughtSeveralPoints(arr, false, true);
end;

end.
