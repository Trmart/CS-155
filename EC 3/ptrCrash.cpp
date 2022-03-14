#include <iostream>

using std::cout; 

int main()
{
    int *crashPtr; 
    crashPtr = nullptr; 
    cout << *crashPtr; 
    return 0; 
}