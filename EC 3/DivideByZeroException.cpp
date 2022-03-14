#include <iostream>
using std::cout; 


float division(float num, float den) //division function that recieves a numerator and denominator from main and returns the result 
{
    return (num/den); 
}


int main()
{
    float num = 3.14; 
    float denom = 0.0; //set denominator to zero for divide by zero exception 
    float quotient; 
    
    quotient = division(num,denom); //assign quotient to the result returned by the division function call 

    cout << "The Quotient Of " << num << "/" << denom << " is: " << quotient << "\n"; //output the divide by zero exception and 
                                                                                      //see what happens 
}