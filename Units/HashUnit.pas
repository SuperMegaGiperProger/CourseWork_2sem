unit HashUnit;
         
//----------------------------------------------------------------------------//

interface

uses
  listOfPointersUnit;

type
  THashFunc = function (key: variant; arg: variant): integer;
    // arg[0]: THashList
  TCorrectFunc = function (elt: TEltPt; key: variant): boolean;
    // is the element has the same key
  THashList = record
    table: array of TListOfPointers;
    hashFunc: THashFunc;
    size: integer;
  end;

const
  STANDART_HASH_TABLE_SIZE = 1000;

function standartHashFunc(key: variant; arg: variant): integer;
  // O(1)

const
  STANDART_HASH_FUNC: THashFunc = HashUnit.standartHashFunc;

function createHashList(hashFunc: THashFunc{ = STANDART_HASH_FUNC};
  size: integer = STANDART_HASH_TABLE_SIZE): THashList;
function get(hashList: THashList; key: Variant; correct: TCorrectFunc): TEltPt;
procedure push(hashList: THashList; key: Variant; data: Pointer); overload;

//----------------------------------------------------------------------------//

implementation

procedure push(hashList: THashList; key: Variant; data: Pointer);
begin
  push_top(hashList.table[hashList.hashFunc(key, hashList.size)], data);
end;

function get(hashList: THashList; key: Variant; correct: TCorrectFunc): TEltPt;
var
  it: TEltPt;
begin
  with hashList do
  begin
    it := table[hashFunc(key, size)];
    while (it <> nil) and not correct(it, key) do
      it := it^.next;
    result := it;
  end;
end;

function createHashList(hashFunc: THashFunc{ = STANDART_HASH_FUNC};
  size: integer = STANDART_HASH_TABLE_SIZE): THashList;
begin
  result.size := size;
  SetLength(result.table, size);
  result.hashFunc := hashFunc;
end;

function standartHashFunc(key: variant; arg: variant): integer;
begin
  result := integer(key) mod integer(arg);
end;

//----------------------------------------------------------------------------//

end.
