#include <Math.h>

#define datarate 50000
byte x;
byte y;
byte z;
byte no_puede;
#include <SoftwareSerial.h>

SoftwareSerial mySerial(0, 7); // RX, TX
SoftwareSerial mySerial2(4, 1); // RX, TX

const float L1 = 2;
const float L2 = 5;
const float L3 = 5;
const float L4 = 6;
const float Pi = 3.14159;
const float CTE = 360/(2*Pi);

float theta1;
float theta2;
float theta3;
float theta4;

int phi_angles[361];


void setup() {
  Serial.begin(115200);
  mySerial.begin(datarate);
  mySerial2.begin(24890);

  pinMode(13, OUTPUT);

  phi_angles[0] = 0;
  for (int i=1; i <= 181; i++){
    phi_angles[(2*i)-1] = i;
    phi_angles[2*i] = -i;
  }

}

bool check(){
  if (abs(theta1*CTE)<=90 && (theta2*CTE)<=180 && (theta2*CTE)>=0 && abs(theta3*CTE)<=90 && abs(theta4*CTE)<=90 && (theta4*CTE)<=0){
    return true;
  }
  return false;
}

void inv_k (float dx, float dy, float dz) {
  float phi;
  
  float aux1 = theta1;
  float aux2 = theta2;
  float aux3 = theta3;
  float aux4 = theta4;
  for (int i=0; i <= 360; i++){
    phi = phi_angles[i]*(1/CTE);

    //try{
      float aux = theta1;
      theta1= atan2(dy,dx);
      float A=(dx - (L4*cos(theta1)*cos(phi)));
      float B=(dy-L4*sin(theta1)*cos(phi));
      float C=(dz-L1-L4*sin(phi));
      float var = ((pow(A,2)+pow(B,2)+pow(C,2)-pow(L2,2)-pow(L3,2))/(2*L2*L3));
      if (abs(var) < 1){
        no_puede = 0;
        theta3 = acos(var);
        float a=(L3*sin(theta3));
        float b=(L2+L3*cos(theta3));
        float c=(dz-L1-L4*sin(phi));
        float r=sqrt(pow(a,2)+pow(b,2));
        theta2 = atan2(c,sqrt(pow(r,2)-pow(c,2)))-atan2(a,b);
        theta4 = phi-theta2-theta3; 
      }
      else {
        no_puede = 1;
        theta1 = aux;
      }
    
    //}
    //catch(Exception e){}

    if (check()){ break; }
    else{
      theta2 = theta2 + theta3;
      theta3 = -theta3;
      theta4 = phi-theta2-theta3;
      if (check()){ break; }
    }

  }
  
//  if (!check()){
//    theta1 = aux1;
//    theta2 = aux2;
//    theta3 = aux3;
//    theta4 = aux4;
//    no_puede = 1;
//  }
//  else{ no_puede = 0; }
//  
  Serial.print("XYZ");
  Serial.print("\n");
  Serial.print(dx);
  Serial.print("\t");
  Serial.print(dy);
  Serial.print("\t");
  Serial.print(dz);
  Serial.print("\n");
  Serial.print("angulos");
  Serial.print("\n");
  Serial.print((byte)(map(180-(theta1*CTE + 90),0,180,0,255)));
  Serial.print("\t");
  Serial.print((byte)(map((180 - theta2*CTE),0,180,0,255)));
  Serial.print("\t");
  Serial.print((byte)(map((180 - (theta3*CTE + 90)),0,180,0,255)));
  Serial.print("\t");
  Serial.print((byte)(map((180 - (theta4*CTE + 90)),0,180,0,255)));
  Serial.print("\t");
  Serial.println(phi*CTE);
  Serial.print("\t");
  Serial.print("Error: ");
  Serial.println(no_puede);
  Serial.print("\n");
}

void loop() {

  float dx, dy, dz;

  dx = (x*10.0/255.0) + 5;
  dy = (y*20.0/255.0) - 10;
  dz = (z*16.0/255.0);
  //Serial.println(dz);
  inv_k(dx,dy,dz);
  if (no_puede){
    digitalWrite(13, HIGH);
  } else {
    digitalWrite(13,LOW);
  }

  /*
  int t1 = (int)x - 10;
  int t2 = (int)y - 10;
  int t3 = (int)z - 10;
  int t4 = 99;*/
  byte t1 = (byte)(map((180-(theta1*CTE + 90)),0,180,0,255));
  byte t2 = (byte)(map((180 - theta2*CTE),0,180,0,255));
  byte t3 = (byte)(map((180 - (theta3*CTE + 90)),0,180,0,255));
  byte t4 = (byte)(map((180 - (theta4*CTE + 90)),0,180,0,255));
  
  byte buf[] = {t1, t2, t3, t4};
  mySerial.write(buf,sizeof(buf));
  //delay(1);
  
  int ser = mySerial2.available();
  if (ser==3 ){
    byte buf[3];
    mySerial2.readBytes(buf, 3);
    //delay(20);
    x = buf[0];
    y = buf[1];
    z = buf[2];
    /*
    x = mySerial.read();
    y = mySerial.read();
    z = mySerial.read();
    mySerial.read();*/
  }
  else {
    while(mySerial2.available()!=0){
      mySerial2.read();
    }
  }
  
  
  Serial.print("X: ");
  Serial.print(x);
  Serial.print("  Y: ");
  Serial.print(y);
  Serial.print("  Z: ");
  Serial.print(z);
  Serial.print("  int: ");
  Serial.print(ser);
  Serial.print("\n");
  
  
  


}

