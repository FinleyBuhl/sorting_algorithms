program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  sysutils
  { you can add units after this };
var
  i, i2, timestamp: uint64;
  f_in, f_out: tfilestream;
  s: string;
  split_char: char;
  nums_s: array of string;
  nums: array of double;
  reverse, finished: boolean;
  temp: double;
label
  jmp, jmp2, jmp3;
begin
  timestamp:= gettickcount64;
  reverse:= false;
  for i:= 1 to paramcount do
  begin
    //filecreate(paramstr(i + 1));
    case paramstr(i) of
    '/f1':
      begin
        f_in:= tfilestream.create(paramstr(i + 1), fmopenread);
      end;
    '/f2':
      begin
        f_out:= tfilestream.create(paramstr(i + 1), fmcreate);
      end;
    '/s': split_char:= paramstr(i + 1)[1];
    '/r': reverse:= true;
    end;
  end;
  setlength(s, f_in.size);
  f_in.read(s[1], f_in.size);
  nums_s:= s.split(split_char);
  s:= '';
  setlength(nums, length(nums_s));
  for i:= low(nums_s) to high(nums_s) do
  begin
    nums[i]:= strtofloat(nums_s[i]);
  end;
  for i2:= low(nums) to high(nums) - 1 do
  begin
    finished:= true;
    for i:= low(nums) to high(nums) - 1 do
    begin
      if nums[i] > nums[i + 1] then
      begin
        temp:= nums[i];
        nums[i]:= nums[i + 1];
        nums[i + 1]:= temp;
        finished:= false;
      end;
    end;
    if finished then
        goto jmp;
  end;
  jmp:
  s:= '';
  if reverse then
    goto jmp2;
  for i:= low(nums) to high(nums) - 1 do
    s:= s + floattostr(nums[i]) + #13;
  s:= s + floattostr(nums[high(nums)]);
  goto jmp3;
  jmp2:
  for i:= high(nums) downto low(nums) + 1 do
    s:= s + floattostr(nums[i]) + #13;
  s:= s + floattostr(nums[low(nums)]);
  jmp3:
  f_out.write(s[1], length(s));
  f_in.free;
  f_out.free;
  writeln(floattostr((gettickcount64 - timestamp + 1) / 1000) + 's');
end.

