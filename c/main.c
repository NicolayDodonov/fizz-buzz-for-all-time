#include<stdio.h>
#include <string.h>

void FizzBuzz(int number){
    if(number % 3 == 0 && number % 5 == 0){
        printf("FizzBuzz ");
        return;
    }
    if(number % 3 == 0){
        printf("Fizz ");
        return;
    }
    if(number % 5 == 0){
        printf("Buzz ");
        return;
    } 
    printf("%d ", number);
    return;
}

int main() {
    for(int i = 1; i < 100; i++){
        FizzBuzz(i);
    }
}