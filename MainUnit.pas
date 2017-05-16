unit MainUnit;

//----------------------------------------------------------------------------//

interface

uses
  GraphUnit, GeoUnit, Graphics, MapLoaderUnit;

procedure main;

//----------------------------------------------------------------------------//

implementation

procedure main;
{var
  a: array[0..100] of TVertexPt;
  e: array[0..100] of TEdgePt;
  idcount: integer;}
begin
  {idCount := 1;
  a[0] := createVertex(53.910859, 27.595669, 1); //4
  a[1] := createVertex(53.913288, 27.600737, 2); //dion
  a[2] := createVertex(53.919622, 27.593140, 3); //2
  a[3] := createVertex(53.916783, 27.586027, 4); //cym
  a[4] := createVertex(53.916209, 27.584859, 5); //M
  a[5] := createVertex(53.914977, 27.589140, 6); //copir

  a[6] := createVertex(53.920940, 27.596396, 7); //akadem
  a[7] := createVertex(53.919116, 27.598649, 8); //hosp
  a[8] := createVertex(53.918635, 27.597469, 9);
  a[9] := createVertex(53.918483, 27.597104, 10);
  a[10] := createVertex(53.917887, 27.597812, 11);
  a[11] := createVertex(53.916884, 27.596550, 12); //3k

  a[12] := createVertex(53.914771, 27.603885,13); //plat

  e[8] := createEdge(a[2], a[6], 252, car, nil, true);
  createRoadVertex(e[8]^.road^, 53.920940, 27.596396);

  e[9] := createEdge(a[6], a[7], 249, car, nil, true);
  e[10] := createEdge(a[7], a[12], 600, car, nil, true);
  e[11] := createEdge(a[1], a[12], 252, car, nil, true);

  createRoadVertex(e[9]^.road^, 53.919116, 27.598649);
  createRoadVertex(e[10]^.road^, 53.914771, 27.603885);
  createRoadVertex(e[11]^.road^, 53.914771, 27.603885);

  e[12] := createEdge(a[7], a[8], 92, foot, nil, true);
  e[13] := createEdge(a[8], a[9], 28, foot, nil, true);
  e[14] := createEdge(a[8], a[10], 100, foot, nil, true);
  e[15] := createEdge(a[9], a[10], 77, foot, nil, true);
  e[16] := createEdge(a[10], a[11], 177, foot, nil, true);

  createRoadVertex(e[12]^.road^, 53.918635, 27.597469);
  createRoadVertex(e[13]^.road^, 53.918483, 27.597104);
  createRoadVertex(e[14]^.road^, 53.918176, 27.597984);
  createRoadVertex(e[14]^.road^, 53.918018, 27.598048);
  createRoadVertex(e[14]^.road^, 53.917887, 27.597812);
  createRoadVertex(e[15]^.road^, 53.917887, 27.597812);
  createRoadVertex(e[16]^.road^, 53.917581, 27.598155);
  createRoadVertex(e[16]^.road^, 53.916884, 27.596550);
  {createRoadVertex
  createRoadVertex
  createRoadVertex
  createRoadVertex

  e[1] := createEdge(a[0], a[1], 443, car, nil, true);
  //createEdge(a[0], a[1], 443, foot, e[1]^.road, true);
  createRoadVertex(e[1]^.road^, 53.910859, 27.595669);
  createRoadVertex(e[1]^.road^, 53.911624, 27.596930);
  createRoadVertex(e[1]^.road^, 53.913288, 27.600737);

  e[2] := createEdge(a[2], a[11], 380, car);
  createRoadVertex(e[2]^.road^, 53.916884, 27.596550);

  e[2] := createEdge(a[11], a[1], 480, car);
  createRoadVertex(e[2]^.road^, 53.913288, 27.600737);

  e[3] := createEdge(a[2], a[3], 560, car, nil, true);
  //createEdge(a[2], a[3], 560, foot, e[3]^.road, true);
  createRoadVertex(e[3]^.road^, 53.919622, 27.593140);
  createRoadVertex(e[3]^.road^, 53.916783, 27.586027);

  e[4] := createEdge(a[5], a[3], 295, car);
  //createEdge(a[5], a[3], 295, foot, e[4]^.road, true);
  createRoadVertex(e[4]^.road^, 53.916783, 27.586027);
  createRoadVertex(e[4]^.road^, 53.914977, 27.589140);

  e[5] := createEdge(a[3], a[4], 105, car, nil, true);
  //createEdge(a[3], a[4], 105, foot, e[5]^.road, true);
  createRoadVertex(e[5]^.road^, 53.916783, 27.586027);
  createRoadVertex(e[5]^.road^, 53.916565, 27.585428);
  createRoadVertex(e[5]^.road^, 53.916209, 27.584859);

  e[6] := createEdge(a[0], a[5], 630, car);
  //createEdge(a[0], a[5], 630, foot, e[6]^.road, true);
  createRoadVertex(e[6]^.road^, 53.914977, 27.589140);
  createRoadVertex(e[6]^.road^, 53.910859, 27.595669);

  e[7] := createEdge(a[4], a[5], 336, foot, nil, true);
  createRoadVertex(e[7]^.road^, 53.916209, 27.584859);
  createRoadVertex(e[7]^.road^, 53.916172, 27.585170);
  createRoadVertex(e[7]^.road^, 53.915526, 27.586458);
  createRoadVertex(e[7]^.road^, 53.915323, 27.587917);
  createRoadVertex(e[7]^.road^, 53.914753, 27.588861);
  createRoadVertex(e[7]^.road^, 53.914977, 27.589140);

                         }
end;

//----------------------------------------------------------------------------//

initialization
  main;

//----------------------------------------------------------------------------//

end.
