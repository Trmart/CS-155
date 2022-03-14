//Taylor Martin 
// HW # 8 
// CS-151
// 4/15/20
// This program loops through values assigned to an array 
// in order to find the min and max values located within the array
// then once found, it will display the min and max values to the screen 
#include <iostream> 
using namespace std; 

int main()
{
    
    int array[] = {1,3,7,2,5,4,8,7,0,2}; 
    
    int min = array[0]; 
    int max = array[0]; 

    for (int i = 0; i < 9 ; i++)
    {
        if(array[i] > max)
        {
            max = array[i]; 
        }
        else if(array[i] < min)
        {
            min = array[i]; 
        }
    }

    cout << "Max = " << max << "\n"; 
    cout << "Min = " << min << "\n"; 

    return 0; 
}