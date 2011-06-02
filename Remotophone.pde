/*
 Author: Thomas Graft
 thomasgraft.com
 
 Based on code by:
  
  Alexander Brevig - Keypad Code
  Ken Shirriff - IR

 */

#include <IRremote.h>
#include <Keypad.h>

const byte ROWS = 4; //four rows
const byte COLS = 3; //three columns
char keys[ROWS][COLS] = {
  {'1','2','3'},
  {'4','5','6'},
  {'7','8','9'},
  {'*','0','#'}
};
byte rowPins[ROWS] = {5, 4, 10, 2}; //connect to the row pinouts of the keypad
byte colPins[COLS] = {8, 7, 6}; //connect to the column pinouts of the keypad
Keypad keypad = Keypad( makeKeymap(keys), rowPins, colPins, ROWS, COLS );

// COMMANDS
// NOTE: If you use this code, you'll need to change these
// to work with your specific remote codes
unsigned long POWER = 0x20DF10EF;
unsigned long GENERAL_INPUT= 0x20DFF40B;
unsigned long HDMI = 0x20DF639C;
unsigned long VOL_UP = 0x20DF40BF;
unsigned long VOL_DOWN = 0x20DFC03F;
unsigned long CHANNEL_UP = 0x20DF00FF;
unsigned long CHANNEL_DOWN = 0x20DF807F;

IRsend irsend;

int BITLENGTH = 32;

// Map buttons to commands


void setup()
{
  Serial.begin(9600);
}

void loop() 
{
    char key = keypad.getKey();
  
    if (key != NO_KEY) {
      Serial.println(key);
      switch( key ) {
         case '1':
             irsend.sendNEC(GENERAL_INPUT, BITLENGTH);
             break;
         case '2':
             irsend.sendNEC(HDMI, BITLENGTH);
             break;
         case '4':
             irsend.sendNEC(CHANNEL_UP, BITLENGTH);
             break;
         case '7':
             irsend.sendNEC(CHANNEL_DOWN, BITLENGTH);
             break;
         case '6':
             irsend.sendNEC(VOL_UP, BITLENGTH);
             break;
         case '9':
             irsend.sendNEC(VOL_DOWN, BITLENGTH);
             break;
         case '*':
             irsend.sendNEC(POWER, BITLENGTH);
             break;
      }
    }

}

