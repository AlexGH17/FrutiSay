# FrutiSay
import processing.serial.*;
import controlP5.*;
import java.awt.AWTException;
import java.awt.Robot;
import ddf.minim.*;

Serial      myPort;
ControlP5   Cp5;
Minim       minim;
Robot       robot;
AudioPlayer player1;
AudioPlayer player2;
AudioPlayer player3;
AudioPlayer player4;
AudioPlayer Sound_Back;

int Valor_1 = 0;
int Valor_2 = 0;
long lastTime = 0;
int Nivel = 5;
int[] Valores = new int[20];
int[] Simon = new int[20];
int Puntaje = 0;

PImage Fondo;
PImage Naranja;
PImage Manzana;
PImage Platano;
PImage Limon;

PFont myFont;



void setup()
{
  size(800, 600);
  background(255);
  minim  = new Minim(this);
  myPort = new Serial(this, Serial.list()[0], 9600);
  try {
    robot = new Robot();
  }
  catch(AWTException e) {
    println(e);
  }
  
  myFont  = createFont("Algerian-80", 20);
  textFont(myFont);
  textAlign(CENTER, CENTER);
  
  Sound_Back = minim.loadFile("Groove.mp3");
  player1 = minim.loadFile("Naranja.mp3");
  player2 = minim.loadFile("Platano.mp3");
  player3 = minim.loadFile("Limon.mp3");
  player4 = minim.loadFile("Manzana.mp3");
  
  imageMode(CENTER);
  Fondo  = loadImage("HackBajio.jpg");
  Naranja = loadImage("Naranja.jpg");
  Manzana = loadImage("Platano.jpg");
  Platano = loadImage("Limon.jpg");
  Limon = loadImage("Manzana.jpg");
  
   //Sound_Back.loop();

  
}

void draw()
{
  background(255);
  image(Naranja, width/2, height/2 - height/3, width/3, height/3);
  image(Manzana, width/2 + width/3, height/2, width/3, height/3);
  image(Platano, width/2, height/2 + height/3, width/3, height/3);
  image(Limon, width/2 - width/3, height/2, width/3, height/3);
   for ( int i = 0; i < 3; i++ )
  {
    Simon[i] = int( random( 1, 4 ));
    Reproducir(Simon[i]);
    robot.delay(1000);
  }
  
  for ( int i = 0; i < 3; )
  {
    if (myPort.available() > 0) 
    {
      Valor_2 = myPort.read();
      Reproducir(Valor_2);
      Valores[i] = Valor_2;
      i++;
    }
    robot.delay(300);
  }
  
  for(int i= 0; i<3; i++)
  {
    if (Valores[i] == Simon[i]) Puntaje++;
  }
  fill(125);
  if (Puntaje != 3) text("Vuelve a intentarlo", width/2, height/2);
  else text("Felicidades", width/2, height/2);
   robot.delay(3000);
   //noText();
   //
}


void Reproducir(int Valor)
{
  switch(Valor) 
  {    
  case 1:
    player1.rewind();
    player1.play();
    break;
  case 2: 
    player2.rewind();
    player2.play();
    break;
  case 3:
    player3.rewind();
    player3.play();
    break;
  case 4:
    player4.rewind();
    player4.play();
    break;
  }
