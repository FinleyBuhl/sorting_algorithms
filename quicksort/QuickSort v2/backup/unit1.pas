unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  nums_main, nums_temp: array of array of double;
  nums, temp1, temp2: array of double;
  f_in, f_out: textfile;
  nums_s: array of string;
  s: string = '';
  timestamp, i, i2: uint64;
  sorted: boolean = false;
  end_of_arr: boolean = false;
  avg: double = 0;
  check: double = 0;
begin
  if opendialog1.execute then
    assignfile(f_in, opendialog1.filename);
  if savedialog1.execute then
    assignfile(f_out, savedialog1.filename);
  timestamp:= gettickcount64;
  reset(f_in);
  rewrite(f_out);
  i2:= 0;
  while not eof(f_in) do
  begin
    readln(f_in, s);
    nums_s:= s.split(edit1.text[1]);
    if nums_s[length(nums_s) - 1] = '' then
        setlength(nums_s, length(nums_s) - 1);
    setlength(nums, length(nums_s));
    for i:= 0 to length(nums_s) - 1 do
    begin
      nums[i]:= strtofloat(nums_s[i]);
    end;
  end;
  setlength(nums_main, 1);
  nums_main[0]:= nums;
  while sorted = false do
  begin
    sorted:= true;
    setlength(nums_temp, 0);
    for i:= 0 to length(nums_main) - 1 do
    begin
      avg:= 0;
      for i2:= 0 to length(nums_main[i]) - 1 do
      begin
        avg:= avg + nums_main[i, i2];
      end;
      avg:= avg / (i2 + 1);
      for i2:= 0 to length(nums_main[i]) - 1 do
      begin
        if nums_main[i, i2] < avg then
        begin
          setlength(temp1, length(temp1) + 1);
          temp1[length(temp1) - 1]:= nums_main[i, i2];
          sorted:= false;
        end
        else
        begin
          setlength(temp2, length(temp2) + 1);
          temp2[length(temp2) - 1]:= nums_main[i, i2];
        end;
      end;
      if length(temp1) > 0 then
      begin
        setlength(nums_temp, length(nums_temp) + 1);
        nums_temp[length(nums_temp) - 1]:= temp1;
      end;
      if length(temp2) > 0 then
      begin
        setlength(nums_temp, length(nums_temp) + 1);
        nums_temp[length(nums_temp) - 1]:= temp2;
      end;
      temp1:= [];
      temp2:= [];
    end;
    nums_main:= nums_temp;
  end;
  for i:= 0 to length(nums_main) - 1 do
    for i2:= 0 to length(nums_main[i]) - 1 do
      writeln(f_out, floattostr(nums_main[i, i2]));
  closefile(f_in);
  closefile(f_out);
  label1.caption:= floattostr((gettickcount64 - timestamp) / 1000) + 's';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  edit1.clear;
end;

end.

