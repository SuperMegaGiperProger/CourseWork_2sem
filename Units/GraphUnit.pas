unit GraphUnit;

interface

uses
  listOfPointersUnit;

type
  TVertex = record
    latitude, longitude: real;  // ������, �������
    edgesList: TListOfPointers;  // ����� �� ������ �������
  end;
  TVertexPt = ^TVertex;
  TEdge = record
    movingType: (car, plane, foot);
    weight: real;  // ��� �����
    endPoint: TVertexPt;  // �������, � ������� ����� ��� �����
  end;
  TGraphList = TListOfPointers;

implementation

end.
