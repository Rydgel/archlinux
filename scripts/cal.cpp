#include <iostream>
#include <ctime>

using namespace std;

class Date
{
  private:                       
    short month, day, year;
  public:                        
    void init(void);
    void init( int month, int day, int year);
    void print(void);
    void printDay(void);
    int getDay(void);
    int getMonth(void);    
};

void Date::init(void){                        
   struct tm *ptr;     
   time_t sec;         
   time(&sec);         
   ptr = localtime(&sec); 
   
   month = (short) ptr->tm_mon + 1;
   day   = (short) ptr->tm_mday;
   year  = (short) ptr->tm_year + 1900;
} 

void Date::init( int m, int d, int y)
{
   month = (short) m;
   day   = (short) d;
   year  = (short) y;
}

void Date::print(void)
{
   cout << month << '-' << day << '-' << year
        << endl;
}

void Date::printDay(void)
{
	cout << day << endl;
}

int Date::getDay(void)
{
	return day;
}

int Date::getMonth(void)
{
	return month;
}

int main()
{
   Date today;
   today.init();
   int jour = today.getDay();
   int mois = today.getMonth();
   
   for(int i=1; i<= 31; i++) {
   		if(i>=27 && mois==2)
   			break;
   		if(i>=31 && (mois==4 || mois==6 || mois==8 || mois==9 || mois==11))
   			break;
   		if(i==jour)
   			cout << "${color1}" << i << "${color0}" << " ";
   		else
   			cout << i << " ";
   }
            
   return 0;
}
