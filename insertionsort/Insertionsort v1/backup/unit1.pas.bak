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
  private

  public

  end;

var
  Form1: TForm1;
  f_in, f_out: textfile;
  timestamp, i, i2: uint64;
  nums: array of double;
  nums_s: array of string;
  s: string;
  temp: double;
  correct: boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
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
      nums[i2]:= strtofloat(nums_s[i]);
      inc(i2);
    end;
  end;
  for i:= 1 to length(nums) - 1 do
  begin
    correct:= false;
    i2:= i;
    while correct = false do
    begin
      if nums[i2] < nums[i2 - 1] then
      begin
        temp:= nums[i2 - 1];
        nums[i2 - 1]:= nums[i2];
        nums[i2]:= temp;
        i2:= i2 - 1
      end
      else
        correct:= true;
    end;
  end;
  label1.caption:= floattostr((gettickcount64 - timestamp) / 1000) + 's';
  for i:= 0 to length(nums) - 1 do
    writeln(f_out, floattostr(nums[i]));
  closefile(f_in);
  closefile(f_out);
end;

end.

