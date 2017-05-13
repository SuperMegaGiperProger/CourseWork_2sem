unit MapLoaderUnit;
      
//----------------------------------------------------------------------------//

interface

uses
  GraphUnit, Dialogs, HashUnit, SysUtils, GeoUnit;

procedure LoadMapFromFile(fileName: string);

//----------------------------------------------------------------------------//

implementation

procedure LoadMapFromFile(fileName: string);
var
  f: TextFile;
  str: string;
  id: int64;
  lat, lon: real;
  v1, v2: TVertexPt;
begin
  try
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
        createVertex(lat, lon, id);
      end;
      if eof(f) then showMessage('endoffile');
      repeat
        readln(f, str);
      until str = 'edges';
      while not eof(f) do
      begin
        readln(f, id);
        v1 := TVertexPt(get(mapGraph, id, correctVertex)^.data);
        while not eof(f) do
        begin
          readln(f, str);
          if str = '' then break;
          id := StrToInt64(str);
          v2 := TVertexPt(get(mapGraph, id, correctVertex)^.data);
          createEdge(v1, v2, distation(v1, v2), foot, true);
          v1 := v2;
        end;
      end;
    except
      //ShowMessage('������������ ����');
      on E : Exception do
        ShowMessage(E.ClassName+' ������ � ���������� : '+E.Message);
    end;
  except
    ShowMessage('������ ������ �����');
  end;
end;

//----------------------------------------------------------------------------//

end.
 