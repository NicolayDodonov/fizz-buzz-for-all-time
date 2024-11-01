
def FizzBuzz(number):
    res = ""
    if number%3 == 0:
        res += "Fizz"
    if number%5 == 0:
        res += "Buzz"
    if res == "":
        res = str(number)
    return res

for i in range(1,100):
    print(FizzBuzz(i), end=" ")
