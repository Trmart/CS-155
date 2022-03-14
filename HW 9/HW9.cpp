//  Taylor Martin 
//  CS-155 
//  HW #9
//  4/22/20  
// This program will prompt a user to enter in the size of a string, and then echo the SIZE back to the screen
// The user then will enter a string, the program will echo out the string entered by user on the scren
// leaving numbers untouched and converting lowercase letters to uppercase

#include <iostream> 
#include <string> 
#include <cstring> 
using namespace std; 

string function(char str[])
{
     for(int i = 0; i < strlen(str); i++)
    { 
        if(islower(str[i]))
        {
            str[i] = toupper(str[i]); 
            cout << str[i]; 
        }
        else 
        cout << str[i];  
    }
}

int main()
{   
    const int SIZE = 9 ; 
    int strSize; 
     

    cout << "Please Enter The Length Of A String You Wish To Input (Max String Length can be 9) : "; 
    cin >> strSize; 
    cout << "\nEntered Size: " << strSize << "\n";
    
    char str[SIZE]; 
    
    cout << "Please Enter the String You Wish To Input: "; 
    cin >> str; 

    function(str); 

    return 0; 
}