unit DrawUnit;


// ������� ����� � ����� ������ ������
// ������� ��������� ������������������ / ������


//----------------------------------------------------------------------------//

interface                   

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GraphUnit, ExtCtrls, listOfPointersUnit, StdCtrls, Buttons,
  HashUnit, ShellAPI, GeoUnit, MapLoaderUnit, Math, ComCtrls;

type
  TForm1 = class(TForm)
    mapImage: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn10: TBitBtn;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    OpenDialog1: TOpenDialog;
    ProgressBar1: TProgressBar;
    procedure BitBtn1Click(Sender: TObject);
    procedure mapImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label2MouseEnter(Sender: TObject);
    procedure Label2MouseLeave(Sender: TObject);
    procedure mapImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure mapImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  STANDART_RADIUS = 0.00005;
  STANDART_WIDTH = 0.0032;
  MAX_SCALE = 0.01;
  MIN_SCALE = 0.0005;
  DRAWING_RADIUS =  0.500;  // km

var
  Form1: TForm1;
  scale: real = 0.001;
  latitude0: real = 53.93;
  longitude0: real =  27.58;
  x0, y0: real;
  way: TListOfPointers = nil;
  pointPicture: TBitmap;

procedure drawFullGraph;
procedure drawGraph(x1, y1, x2, y2: real; clear: boolean = true);

//----------------------------------------------------------------------------//

implementation

{$R *.dfm}

function getX(longitude: real): integer;
begin
  result := round((getXDecartCoordinates(longitude) - x0) / scale);
end;

function getY(latitude: real): integer;
begin
  result := round((y0 - getYDecartCoordinates(latitude)) / scale);
end;

procedure drawVertex(v: TVertex; w: real = STANDART_RADIUS);
var
  x, y, r: integer;
begin
  with v do
  begin
    x := getX(longitude);
    y := getY(latitude);
    r := round(w / (2 * scale));
  end;
  Form1.mapImage.Canvas.Pen.Width := 0;
  Form1.mapImage.Canvas.Ellipse(x - r, y - r, x + r, y + r);
end;

procedure drawPoint(x, y, num: integer);
begin
  with Form1.mapImage.Canvas do
  begin
    Draw(x - pointPicture.Width div 2, y - pointPicture.Height, pointPicture);
    Font.Name := 'Arial';
    Font.Style := [fsBold];
    Brush.Style := bsClear;
    TextOut(x - length(IntToStr(num)) * 3 - 1, y - 26, IntToStr(num));
  end;
end;

procedure clearPoint(x, y: integer);
begin
  with Form1.mapImage.Canvas do
  begin
    Pen.Style := psClear;
    Brush.Color := clWhite;
    Rectangle(x - pointPicture.Width div 2, y - pointPicture.Height,
      x + (pointPicture.Width + 1) div 2 + 1, y);
    Pen.Style := psSolid;
    drawGraph(x0 + (x - pointPicture.Width div 2) * scale,
      y0 - y * scale, x0 + (x + (pointPicture.Width + 1) div 2 + 1) * scale,
      y0 - (y - pointPicture.Height) * scale, false);
  end;
end;

procedure drawArrow(x, y: integer; angle: real = 0; length: integer = 20);
var
  stx, sty: integer;
begin
  with Form1.mapImage.Canvas do
  begin
    moveTo(x, y);
    lineTo(x - round(length * cos(angle)), y - round(length * sin(angle)));
    stx := x - round(length * cos(angle) / 1.2);
    sty := y - round(length * sin(angle) / 1.2);
    angle := angle + pi / 2;
    moveTo(x, y);
    lineTo(stx - round(length * cos(angle) / 2),
      sty - round(length * sin(angle) / 4));
    moveTo(x, y);
    lineTo(stx + round(length * cos(angle) / 2),
      sty + round(length * sin(angle) / 4));
  end;
end;

procedure setStyle(edge: TEdge);
begin
  with Form1.mapImage.Canvas do
  begin
    case edge.movingType of
      car: Pen.width := round(edge.width * STANDART_WIDTH / scale);
      foot: Pen.width := round(edge.width * STANDART_WIDTH / scale);
    end;
  end;
end;

procedure drawRoad(edge: TEdge; direction: boolean = false);
var
  x1, x2, y1, y2, len: integer;
  angle: real;
begin
  setStyle(edge);
  if Form1.mapImage.Canvas.Pen.Width <= 0 then exit;
  x1 := getX(edge.startPoint^.longitude);
  y1 := getY(edge.startPoint^.latitude);
  x2 := getX(edge.endPoint^.longitude);
  y2 := getY(edge.endPoint^.latitude);
  if direction then
  begin
    len := 10;
    if sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)) < len + 20 then exit;
    if x1 = x2 then angle := pi / 2
    else angle := arctan((y2 - y1) * 1.0 / ((x2 - x1) * 1.0));
    if x2 - x1 < 0 then angle := angle + pi;
    Form1.mapImage.Canvas.Pen.Color := clBlack;
    Form1.mapImage.Canvas.Pen.Width := 2;
    drawArrow(x2 - (x2 - x1) div 2 + round((len + 15) * cos(angle) / 2),
      y2 - (y2 - y1) div 2 + round((len + 15) * sin(angle) / 2), angle, len);
    exit;
  end;
  with Form1.mapImage.Canvas do
  begin
    moveTo(x1, y1);
    lineTo(x2, y2);
  end;
end;

procedure drawAllRoads(v: TVertex);
var
  it: TEltPt;
  x, y: integer;
begin
  with Form1.mapImage.Canvas do
  begin
    x := getX(v.longitude);
    y := getY(v.latitude);
    it := v.edgesList;
    while it <> nil do
    begin
      setStyle(TEdgePt(it^.data)^);
      if Pen.Width > 0 then
        with TEdgePt(it^.data)^ do
        begin
          moveTo(x, y);
          lineTo(getX(endPoint.longitude), getY(endPoint.latitude));
        end;
      it := it^.next;
    end;
  end;
end;

procedure drawWay(way: TListOfPointers; direction: boolean = false);
var
  it, it2: TEltPt;
begin
  it2 := way;
  while it2 <> nil do
  begin
    it := TEltPt(it2^.data);
    while it <> nil do
    begin
      Form1.mapImage.Canvas.Pen.Color := clGreen;
      drawRoad(TEdgePt(it^.data)^, direction);
      it := it^.next;
    end;
    it2 := it2^.next;
  end;
end;

procedure drawPoints(point: array of TVertexPt);
var
  i: integer;
begin
  for i := 0 to length(point) - 1 do
    drawPoint(getX(point[i]^.longitude), getY(point[i]^.latitude), i + 1);
end;

var
  movType: TMovingType = car;
  arr: array of TVertexPt;

function min(a, b: integer): integer;
begin
  if a < b then result := a
  else result := b;
end;

function max(a, b: integer): integer;
begin
  if a > b then result := a
  else result := b;
end;

procedure drawGraph(x1, y1, x2, y2: real; clear: boolean = true);
var
  it: TEltPt;
  v: TVertex;
  i, j: integer;
begin
  if clear then Form1.mapImage.Picture.Graphic := nil;
  Form1.mapImage.Canvas.Brush.Color := clRed;
  Form1.mapImage.Canvas.Pen.Color := clRed;
  with mapGraph do
  begin
    for i := max(hashFunc(y1 - minY - DRAWING_RADIUS, k), 0) to
      min(hashFunc(y2 - minY + DRAWING_RADIUS, k), height - 1) do
    begin
      for j := max(hashFunc(x1 - minX - DRAWING_RADIUS, k), 0) to
        min(hashFunc(x2 - minX + DRAWING_RADIUS, k), width - 1) do
      begin
        it := mapGraph.table[i][j];
        while it <> nil do
        begin
          v := TVertexPt(it^.data)^;
          drawVertex(v);
          drawAllRoads(v);
          it := it^.next;
        end;
      end;
    end;
  end;
  drawWay(way);
  drawWay(way, true);
  drawPoints(arr);
end;

procedure drawFullGraph;
begin
  drawGraph(x0, y0 - Form1.mapImage.Height * scale,
    x0 + Form1.mapImage.Width * scale, y0);
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  //scale := 1 / 150;
  drawFullGraph;
end;

function findClosestVertex(X, Y: real): TVertexPt;
const
  SEARCHING_RADIUS = 20;  // px
var
  d, i, j: integer;
  closestVert: TVertexPt;
  it: TEltPt;
  mouseV, v: TVertex;
  l, r, t, b: integer;
begin
  result := nil;
  y := -y * scale + y0;
  x := x * scale + x0;
  mouseV.latitude := getLatitude(y);
  mouseV.longitude := getLongitude(x);
  with mapGraph do
  begin
    d := round(SEARCHING_RADIUS * scale * k);
    i := hashFunc(y - minY, k);
    j := hashFunc(x - minX, k);
    if (i >= height) or (j >= width) then exit;
    b := max(i - d, 0);
    t := min(i + d, height - 1);
    l := max(j - d, 0);
    r := min(j + d, width - 1);
    for i := b to t do
      for j := l to r do
      begin
        it := mapGraph.table[i][j];
        if it = nil then continue;
        closestVert := TVertexPt(it^.data);
        while it <> nil do
        begin
          v := TVertexPt(it^.data)^;
          if Distation(@v, @mouseV) < Distation(closestVert, @mouseV) then
            closestVert := it^.data;
          it := it^.next;
        end;
        if result = nil then result := closestVert
        else
          if Distation(closestVert, @mouseV) < Distation(result, @mouseV) then
            result := closestVert;
      end;
  end;
end;

procedure drawTheShortestWayTroughSeveralPoints(point: array of TVertexPt;
  start: boolean = false; finish: boolean = false;
  movingTypeSet: TMovingTypeSet = [car, foot, plane]);
var
  dist: real;
  exist: boolean;
begin
  exist := getTheShortestWayThroughSeveralPoints(point, dist, way, start, finish, movingTypeSet);
  if not exist then exit;
  drawFullgraph;
end;

var
  move, itWasMoving: boolean;
  xm, ym: integer;

var
  lastPointV: TVertexPt = nil;

procedure TForm1.mapImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if not move then
  begin
    if lastPointV <> nil then clearPoint(getX(lastPointV^.longitude),
      getY(lastPointV^.latitude));
    lastPointV := findClosestVertex(x, y);
    if lastPointV <> nil then
      drawPoint(getX(lastPointV^.longitude), getY(lastPointV^.latitude),
        length(arr) + 1);
    exit;
  end;
  with Form1.mapImage do
  begin
    //if not ((x0 > rightBorder - Width) or (x0 < leftBorder)) then
    x0 := x0 + (xm - x) * scale;
    minimize(x0, rightBorder - Width * scale);
    maximize(x0, leftBorder);
    //if not ((y0 > topBorder) or (y0 < bottomBorder + Height)) then
    y0 := y0 - (ym - y) * scale;
    minimize(y0, topBorder);
    maximize(y0, bottomBorder + Height * scale);
  end;
  drawFullGraph;
  xm := x;
  ym := y;
  itWasMoving := true;
end;

procedure TForm1.mapImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  xm := x;
  ym := y;
  move := true;
  itWasMoving := false;
end;

procedure TForm1.mapImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  v: TVertexPt;
begin
  move := false;
  if itWasMoving then exit;
  v := findClosestVertex(x, y);
  if v = nil then exit;
  Form1.mapImage.Canvas.Brush.Color := clBlue;
  Form1.mapImage.Canvas.Pen.Color := clBlue;
  SetLength(arr, length(arr) + 1);
  arr[length(arr) - 1] := v;
  //drawPoint(getX(v^.longitude), getY(v^.latitude), length(arr));
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  movType := car;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  movType := foot;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  SetLength(arr, 0);
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  drawTheShortestWayTroughSeveralPoints(arr, false, false, [movType]);
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  drawTheShortestWayTroughSeveralPoints(arr, true, false, [movType]);
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
  drawTheShortestWayTroughSeveralPoints(arr, false, true, [movType]);
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
begin
  drawTheShortestWayTroughSeveralPoints(arr, true, true, [movType]);
end;

procedure TForm1.BitBtn9Click(Sender: TObject);
begin
  if not openDialog1.Execute then exit;
  LoadMapFromFile(OpenDialog1.FileName);
  drawFullGraph;
end;

procedure TForm1.Label2Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil, 'http://www.openstreetmap.org/',
    nil, nil,SW_SHOWNOACTIVATE);
end;

procedure TForm1.Label2MouseEnter(Sender: TObject);
begin
  Label2.Font.Style := [fsUnderline];
end;

procedure TForm1.Label2MouseLeave(Sender: TObject);
begin
  Label2.Font.Style := [];
end;

function onMap(MousePos: TPoint): boolean;
begin
  with form1 do
    with MousePos do
      result := not ((X < Left + mapImage.Left) or
        (X > Left + mapImage.Left + width) or
        (Y < top + mapImage.Top) or (Y > top + mapImage.Top + height));
end;

const
  dScale = 0.0001;

procedure TForm1.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  if scale >= MAX_SCALE then exit;
  if not onMap(MousePos) then exit;
  scale := scale + dScale;
  drawFullGraph;
end;

procedure TForm1.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  if scale <= MIN_SCALE then exit;
  if not onMap(MousePos) then exit;
  scale := scale - dScale;
  drawFullGraph;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if scale <= MIN_SCALE then exit;
  scale := scale - dScale;
  drawFullGraph;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin       
  if scale >= MAX_SCALE then exit;
  scale := scale + dScale;
  drawFullGraph;
end;

//----------------------------------------------------------------------------//

end.
