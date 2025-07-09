#include "UnoJoy.h"
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <SPI.h>
#include <SoftwareSerial.h>

#define BT_RXD 3
#define BT_TXD 2
SoftwareSerial bluetooth(BT_RXD, BT_TXD);

int reedInPin = 3;// define pin 2 for reed switch 
int relayPin = 8;// pin connected to relay 
float distance = 0; // 자전거의 누적 이동 거리
int digitalPin = 5; // Digital Pin(디지털 핀) 2를 입력으로 사용

char buf1[33]={0};
char buf2[33]={0};
char temp[20];
int  onTime= 10; // time in melliseond ON and wait before make another reading.
int  offTime= 10; // time in melliseond OFF and wait before make another reading.
unsigned long time, oldtime, delta = 0;
float spd=0;
float lcdDis = 0.0f; // 자전거의 이동 거리를 LCD출력에 맞게 바꿔즌 값.(단위 수정 or 소숫점 제거)

int ledpin = 2, swpin=8, swval=0, oldswval=0;
int count = 0;  // 리드스위치의 노이즈를 제거하기 위해 카운트를 넣어줍니다.
LiquidCrystal_I2C lcd(0x27, 16, 2);
const int analogPin = A0; // 아날로그 입력 핀 번호

const int A_KEY_CODE = 65; // 'a' 키 코드 값
const int D_KEY_CODE = 68; // 'd' 키 코드 값
const int W_KEY_CODE = 87; // 'w' 키 코드 값

void setup() {
//Robojax Step By Step Arduino Course http://robojax.com/L/?id=338	
    //Serial.begin(9600);
    //SPI.begin();
    pinMode(ledpin, INPUT);
    pinMode(swpin, OUTPUT);
    digitalWrite(ledpin, LOW);
    pinMode(digitalPin, INPUT); // Digital Pin(디지털 핀)을 입력으로 설정
    //lcd.init();
    //lcd.backlight();
    //lcd.print("hello, world!.............");        
    
    pinMode(analogPin, INPUT); // 아날로그 입력 핀을 입력으로 설정 
    delta = 0;
    //Serial.println("Robojax Reed switch");
    //lcd.print("Arduino");
  
    distance = 0; // distance 변수를 0으로 초기화
    spd = 0;
    setupPins();
    setupUnoJoy();
    bluetooth.begin(115200);
}

void loop(){
   digitalWrite(ledpin, LOW);
  count++;
  swval = digitalRead(ledpin);
  //Serial.println(digitalRead(ledpin));
  if (oldswval == LOW && swval == HIGH)
  {
    time = millis();
    delta = millis() - oldtime;
    //26" * 25.4 * 3.141592 = 2.074m, 0.002174 km;
    // * 3600 = 7446.4 km/s
    spd = 7466.4 / (float)delta;
    distance += delta;
    count = 0; 
    sprintf(buf1, "SPEED: %3ldkm/h", (long)spd);
    sprintf(buf2, "Distance: %d.%01dkm", (long)(distance / 1000));
    //Serial.println(buf1);
    //Serial.println(buf2);
    String data = String(buf1) + "," + String(buf2);
    bluetooth.print(data);
    /*
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
    */
    oldtime = time;
    digitalWrite(ledpin, HIGH);
    delay(20);

  }

  count++;
  if(count > 100){ // 카운트가 20이 넘어가면(자전거가 멈췄을 때) 속도를 0으로 바꿔줍니다.
    spd = 0;
    sprintf(buf1, "SPEED: %3ldkm/h", (long)spd);
    sprintf(buf2, "Distance:%d.%01dkm", (long)(distance / 1000));
    //Serial.println(buf1);
    //Serial.println(buf2);
    String data = String(buf1) + "," + String(buf2);
    bluetooth.print(data);
    //digitalWrite(5, HIGH);
  }
  digitalWrite(ledpin, LOW);
  //digitalWrite(5, LOW);
  oldswval = swval;
  //Serial.println("1");
  int sensorValue = analogRead(analogPin); // 아날로그 입력 값을 읽어옴
  //Serial.println(sensorValue/100); // 읽어온 값 시리얼 모니터에 출력
  //int sensorValue = digitalRead(digitalPin); // Digital Pin(디지털 핀)의 값을 읽어옴
  //Serial.println(sensorValue);

  if(spd >= 10){            // 속도가 한자리라면 앞에 0을 붙여 줍니다.
    //Keyboard.press('w'); 
    
    //Serial.println(count);
    //delay(100);
  }
  if(count <= 200){
    
    //digitalWrite(5, HIGH);
  }

  if((sensorValue/100)>=1&&(sensorValue/100)<=5) {
    //Serial.println("1");
    //Keyboard.press('a');
    //Keyboard.press(A_KEY_CODE);
    delay(100);
  }
  if((sensorValue/100)>=6&&(sensorValue/100)<=10) {
    //Keyboard.press('d');
    //Serial.println("0");
    //Keyboard.press(D_KEY_CODE);
    delay(100);
  }
  if((sensorValue/100)==0||(sensorValue/100)==1||(sensorValue/100)==10) {
    //Keyboard.release("d");
    //Keyboard.release("a");
    //Keyboard.release(A_KEY_CODE);
    //Keyboard.release(D_KEY_CODE);
    //Keyboard.releaseAll(); //키 해제
    //Serial.println("2");
  }

  dataForController_t controllerData = getControllerData();
  setControllerData(controllerData);
}

void setupPins(void){
  // Set all the digital pins as inputs
  // with the pull-up enabled, except for the 
  // two serial line pins
  for (int i = 2; i <= 12; i++){
    if (i != 4){
      pinMode(i, INPUT);
      digitalWrite(i, LOW);
    }
  }
  pinMode(A4, INPUT);
  digitalWrite(A4, LOW);
  pinMode(A5, INPUT);
  digitalWrite(A5, LOW);
}

dataForController_t getControllerData(void){
  
  // Set up a place for our controller data
  //  Use the getBlankDataForController() function, since
  //  just declaring a fresh dataForController_t tends
  //  to get you one filled with junk from other, random
  //  values that were in those memory locations before
  dataForController_t controllerData = getBlankDataForController();
  // Since our buttons are all held high and
  //  pulled low when pressed, we use the "!"
  //  operator to invert the readings from the pins
  controllerData.triangleOn = 0;
  controllerData.circleOn = 0;
  controllerData.squareOn = 0;
  if(count <= 100){
    controllerData.crossOn = 1;
  }
  if(count >= 100){
    controllerData.crossOn = 0;
  }
  //Serial.println(controllerData.crossOn);
  controllerData.dpadUpOn = 0;
  controllerData.dpadDownOn = 0;
  controllerData.dpadLeftOn = 0;
  controllerData.dpadRightOn = 0;
  controllerData.l1On = 0;
  controllerData.r1On = 0;
  controllerData.selectOn = 0;
  controllerData.startOn = 0;
  controllerData.homeOn = 0;
  
  // Set the analog sticks
  //  Since analogRead(pin) returns a 10 bit value,
  //  we need to perform a bit shift operation to
  //  lose the 2 least significant bits and get an
  //  8 bit number that we can use  
  controllerData.leftStickX = analogRead(A0) >> 2;
  
  
  // And return the data!
  return controllerData;
}