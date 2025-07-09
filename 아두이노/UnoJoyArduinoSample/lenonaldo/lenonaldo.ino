#include <LiquidCrystal_I2C.h>
#include <SPI.h>
#include <SoftwareSerial.h>

#define BT_RXD 3
#define BT_TXD 2
SoftwareSerial bluetooth(BT_RXD, BT_TXD);
 
 /*
 * Lesson 12 Reed Switch
 * This is the Arduino code for reed switch to
 * turn a relay ON which the relay
 * can turn a light or alarm ON
* reed switch is connected to pin 2
 * Relay is connected to pin 8
  Please watch video instruction here https://youtu.be/RS7PTtxtlQ4
 This code is available at http://robojax.com/course1/?vid=lecture12
 
with over 100 lectures Free On  YouTube Watch it here http://robojax.com/L/?id=338
Get the code for the course: http://robojax.com/L/?id=339 
 * Written by Ahmad Shamshiri for Robojax, robojax.com http:youTube.com/robojaxTV
 
 * Date: Dec 05, 2017, in Ajax, Ontario, Canada
 
 * 
 * This code is "AS IS" without warranty or liability. Free to be used as long as you keep this note intact.* 
 * This code has been download from Robojax.com
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */


int reedInPin = 3;// define pin 2 for reed switch 
int relayPin = 8;// pin connected to relay 
float distance = 0; // 자전거의 누적 이동 거리

char buf1[33]={0};
char buf2[33]={0};
char temp[20];
int  onTime= 10; // time in melliseond ON and wait before make another reading.
int  offTime= 10; // time in melliseond OFF and wait before make another reading.
unsigned long time, oldtime, delta = 0;
float spd=0;
float lcdDis = 0.0f; // 자전거의 이동 거리를 LCD출력에 맞게 바꿔즌 값.(단위 수정 or 소숫점 제거)
int ledpin = 3, swpin=8, swval=0, oldswval=0;
int count = 0;  // 리드스위치의 노이즈를 제거하기 위해 카운트를 넣어줍니다.
LiquidCrystal_I2C lcd(0x27, 16, 2);
const int analogPin = A0; // 아날로그 입력 핀 번호

void setup() {
//Robojax Step By Step Arduino Course http://robojax.com/L/?id=338   
    Serial.begin(9600);
    bluetooth.begin(9600);
    SPI.begin();
    pinMode(ledpin, INPUT);
    pinMode(swpin, OUTPUT);
    lcd.init();
    lcd.backlight();
    lcd.print("hello, world!.............");        
    pinMode(analogPin, INPUT); // 아날로그 입력 핀을 입력으로 설정 
    //Serial.println("Robojax Reed switch");
    //lcd.print("Arduino");
  
    distance = 0; // distance 변수를 0으로 초기화
}

void loop(){
  count++;
  swval = digitalRead(ledpin);
  if (oldswval == LOW && swval == HIGH)
  {
    time = millis();
    delta = millis() - oldtime;
    //26" * 25.4 * 3.141592 = 2.074m, 0.002174 km;
    // * 3600 = 7446.4 km/s
    spd = (7466.4 / (float)delta)/3;
    distance += delta;
    count = 0; 
    sprintf(buf1, "SPEED: %3ldkm/h", (long)spd);
    sprintf(buf2, "Distance: %d.%01dkm", (long)(distance / 10000));
    Serial.println(buf1);
    Serial.println(buf2);
    String data = String(buf1) + "," + String(buf2);
    bluetooth.print(data);

    lcd.setCursor(0,0);          //커서를 0,0에 지정
    lcd.print("Speed: "); 
    if(spd < 10){            // 속도가 한자리라면 앞에 0을 붙여 줍니다.
      lcd.print('0');
    }
    lcd.print(spd);               
    lcd.print("Km/h");           // 속도를 lcd에 출력합니다.("Speed: xx.xxKm/h");
  
    lcdDis = distance / 100000;
    lcd.setCursor(0,1);          // 커서를 0,1에 지정
    lcd.print("Distance: ");  
    if(lcdDis >= 100){           // 이동거리가 100Km가 넘어가면 소숫점을 지워줍니다.
      lcd.print((int)lcdDis-1.11);
    }
    else{
      lcd.print(lcdDis, 1);               
    }            
    lcd.print("Km");             // 이동거리를 lcd에 출력합니다.("Distance: xx.xxKm")

    oldtime = time;
    delay(20);

  }

  count++;
  if(count > 20000){ // 카운트가 20이 넘어가면(자전거가 멈췄을 때) 속도를 0으로 바꿔줍니다.
    spd = 0;
    sprintf(buf1, "SPEED: %3ldkm/h", (long)spd);
    sprintf(buf2, "Distance:%d.%01dkm", (long)(distance / 10000));
    Serial.println(buf1);
    Serial.println(buf2);
    String data = String(buf1) + "," + String(buf2);
    bluetooth.print(data);
  }
  oldswval = swval;

  int sensorValue = analogRead(analogPin); // 아날로그 입력 값을 읽어옴
  Serial.println(sensorValue/100); // 읽어온 값 시리얼 모니터에 출력
}