unit listOfPointersUnit;

//----------------------------------------------------------------------------//

interface

type
  TEltPt = ^TElt;
  TElt = record //������� ������
    data: Pointer;
    next: TEltPt;
  end;
  TListOfPointers = TEltPt;

procedure push_top(var list: TListOfPointers; data: Pointer);
procedure pop_top(var list: TListOfPointers);
function isEmpty(var list: TListOfPointers): boolean;
procedure clear(var list: TListOfPointers);

//----------------------------------------------------------------------------//

implementation

procedure push_top(var list: TListOfPointers; data: Pointer);
var
  newEltPt: TEltPt;
begin
  new(newEltPt);
  newEltPt^.data := data;
  newEltPt^.next := list;
  list := newEltPt;
end;

procedure pop_top(var list: TListOfPointers);
var
  delEltPt: TEltPt;
begin
  if isEmpty(list) then exit;
  delEltPt := list;
  list := list^.next;
  Dispose(delEltPt);
end;

function isEmpty(var list: TListOfPointers): boolean;
begin
  isEmpty := (list = nil);
end;

procedure clear(var list: TListOfPointers);
begin
  while not isEmpty(list) do pop_top(list);
end;

//----------------------------------------------------------------------------//

end.
