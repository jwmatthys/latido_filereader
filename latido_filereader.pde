import controlP5.*;
import javax.crypto.Cipher; //<>//
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.io.File;
import java.io.IOException;
import java.awt.datatransfer.*;
import java.awt.Toolkit; 
import static javax.swing.JOptionPane.*;

ControlP5 gui;
Textarea myTextArea;
Println console;
ClipHelper clip;

String secretKey = "eyesears";
String extension = ".latido";
float scrollAmt = 0;
float scrollStep = 1.0/30;

void setup()
{
  frame.setTitle("Latido User Progress File Reader");
  size(1024, 680);
  smooth();
  clip = new ClipHelper();
  gui = new ControlP5(this);
  gui.enableShortcuts();
  PFont font = loadFont("Inconsolata-18.vlw");

  gui.addTextfield("shortname")
    .setLabel("Enter Latido library codename (8 characters)")
      .setPosition(10, 10)
        .setSize(200, 20)
          .setFont(font)
            .setFocus(true)
              .setText("eyesears")
                ;

  gui.addButton("load")
    .setLabel("Load User File")
      .setPosition((width/2)-50, 10)
        .setSize(100, 35)
          .getCaptionLabel()
            .align(ControlP5.CENTER, ControlP5.CENTER)
              ;

  gui.addButton("clippy")
    .setLabel("Copy Text to Clipboard")
      .setPosition(width-160, 10)
        .setSize(150, 35)
          .getCaptionLabel()
            .align(ControlP5.CENTER, ControlP5.CENTER)
              ;

  myTextArea = gui.addTextarea("txt")
    .setPosition(10, 60)
      .setSize(width-20, height-70)
        .setFont(font)
          .setLineHeight(18)
            .setColor(color(0))
              .setColorBackground(color(200))
                //.setColorForeground(color(255, 0, 0))
                ;

  console = gui.addConsole(myTextArea);
  background(0);
  println("\n LATIDO USER PROGRESS FILE READER / DECRYPTER");
  print("\n Make sure your library shortname above is correct,");
  println(" then press the load button to load a .latido file.");
}

void draw()
{
}

void load()
{
  selectInput("Choose a Latido User Progress File to Decrpyt...", "loadCallback");
}

void mouseWheel(MouseEvent event) {
  scrollAmt = constrain(scrollAmt + event.getCount()*scrollStep, 0, 1);
  myTextArea.scroll(scrollAmt);
}

