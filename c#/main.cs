// Online C# Editor for free
// Write, Edit and Run your C# code using C# Online Compiler

using System;

public class main
{
    public static void Main(string[] args)
    {
        for (int i = 1; i < 100; i++){
            Console.Write(FizzBuzz(i)+" ");
        }
    }
    
    public static string FizzBuzz(int number){
        string s = "";
        if (number % 3 == 0){
            s += "Fizz";
        }
        if (number % 5 == 0){
            s +="Buzz";
        }
        if (s == ""){
            s += Convert.ToString(number);
        }
        return s;
    }
}