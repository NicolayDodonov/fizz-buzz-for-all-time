program main;
    
function FizzBuzz(number: integer): string;
var
  res: string;
begin
  if number mod 3 = 0 then
    res := res + 'Fizz';
  if number mod 5 = 0 then
    res := res + 'Buzz';
  if res = '' then
    res := IntToStr(number);
  FizzBuzz := res
end;  

begin
  for var i:= 1 to 100 do 
    write(FizzBuzz(i)+' ');
end.