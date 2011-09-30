#include <Wire.h>

#define LIGHTSENSOR 3
#define TEMPSENSOR 0x48
#define DOORSENSOR 7
#define TAPSENSOR 4
#define PRESSLEFT 0
#define PRESSRIGHT 1

#define EMPTYKEG 29.7
#define FULLKEG 160.5

void setup() {
  Serial.begin(9600);
  pinMode(DOORSENSOR,INPUT);
  pinMode(TAPSENSOR,INPUT);
  Wire.begin();
}

void loop() {

  Serial.print("$,");
  
  Serial.print("keg1,");
  
  //Temp sensor reading
  Wire.requestFrom(TEMPSENSOR,2);  
  byte MSB = Wire.receive();
  byte LSB = Wire.receive();

  int TemperatureSum = ((MSB << 8) | LSB) >> 4; //it's a 12bit int, using two's compliment for negative
  float celsius = TemperatureSum*0.0625;
  float fahrenheit = (TemperatureSum*0.1125) + 32;  

  //Serial.print("Celsius: ");
  Serial.print(celsius);
  Serial.print(",");

  //Serial.print("Fahrenheit: ");
  Serial.print(fahrenheit);
  Serial.print(",");
  
  //Light sensor reading
  float light = analogRead(LIGHTSENSOR);
  Serial.print(light/330 * 100);
  Serial.print(",");
  
  //Door sensor reading
  int door = digitalRead(DOORSENSOR);
  Serial.print(door);
  Serial.print(",");
  
  //Reed switch reading
  int tap = digitalRead(TAPSENSOR);
  Serial.print(tap);
  Serial.print(",");
  
  //Pressure sensor reading
  int pressL = analogRead(PRESSLEFT);
  int pressR = analogRead(PRESSRIGHT);
  
  
  Serial.print((pressL + pressR) / 2 * .25);
  Serial.print(",");
  Serial.print(pressL);
  Serial.print(",");
  Serial.print(pressR);
  Serial.println(",*");

  delay(500); 
}
