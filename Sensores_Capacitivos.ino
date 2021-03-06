# FrutiSay
#include <CapacitiveSensor.h>
#include <math.h>
 
////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////// ARDUINO //////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
const int EmSeCa = 2; // Emitter Sensor Capacitive
const int ReSeCa[8] = {3,4,5,6}; // Receptors Sensor Capacitive
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

int i;
int Valor = 0;
int Sensivility = 70;
int Current_States[4];
int Previous_States[4];
long Values[4];

CapacitiveSensor   S1 = CapacitiveSensor(EmSeCa,ReSeCa[0]);
CapacitiveSensor   S2 = CapacitiveSensor(EmSeCa,ReSeCa[1]);
CapacitiveSensor   S3 = CapacitiveSensor(EmSeCa,ReSeCa[2]);
CapacitiveSensor   S4 = CapacitiveSensor(EmSeCa,ReSeCa[3]);
 
void setup() 
{
  Serial.begin(9600);
}

void loop() 
{
  Values[0] =  S1.capacitiveSensor(10);
  Values[1] =  S2.capacitiveSensor(10);
  Values[2] =  S3.capacitiveSensor(10);
  Values[3] =  S4.capacitiveSensor(10);
  
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
  
for (i = 0; i<4; i++)
  { //Serial.print(Values[i]);
    //Serial.print("\t");
    
    if (Values[i] > Sensivility)  Current_States[i] = 0;
    else Current_States[i] = 1;
    if (Previous_States[i] == 1 && Current_States[i] == 0)
    {
      Valor = 1 + i;
      Serial.write(Valor);
      Previous_States[i] = Current_States[i];
    }

    if (Previous_States[i] == 0 && Current_States[i] == 1)
    {   
      Previous_States[i] = Current_States[i];
    } 
  }
  
  //Valor = 0;
  //Serial.println();
  delay(100);
  
}  
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

