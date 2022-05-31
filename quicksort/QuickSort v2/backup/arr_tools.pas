unit arr_tools;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, math;

implementation

procedure txt_read(var f_in: file; var arr: array of double; split_char: char);
var
  s, s2: string;
  str_array: array of string;
  i: uint64;
  out_arr: array of double;
begin
  try
  begin
    while not eof(f_in) do
    begin
      reset(f_in);
      readln(f_in, s);
      s2:= s2 + s;
      str_array:= s2.split(split_char);
      setlength(out_arr, length(str_array));
      for i:= 0 to length(str_array) - 1 do
        out_arr[i]:= strtofloat(str_array[i]);
    end;
  end;
  finally
  end;
end;

procedure arr_swap(var in_array: array of double; var i1, i2: uint64);
var
  temp: double;
begin
  temp:= in_array[i1];
  in_array[i1]:= in_array[i2];
  in_array[i2]:= temp;
end;

end.

