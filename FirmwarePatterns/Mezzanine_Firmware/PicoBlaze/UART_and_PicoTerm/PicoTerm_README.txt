
© Copyright 2012-2013, Xilinx, Inc. All rights reserved.
This file contains confidential and proprietary information of Xilinx, Inc. and is
protected under U.S. and international copyright and other intellectual property laws.

Disclaimer:
  This disclaimer is not a license and does not grant any rights to the materials
  distributed herewith. Except as otherwise provided in a valid license issued to you
  by Xilinx, and to the maximum extent permitted by applicable law: (1) THESE MATERIALS
  ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL
  WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED
  TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR
  PURPOSE; and (2) Xilinx shall not be liable (whether in contract or tort, including
  negligence, or under any other theory of liability) for any loss or damage of any
  kind or nature related to, arising under or in connection with these materials,
  including for any direct, or any indirect, special, incidental, or consequential
  loss or damage (including loss of data, profits, goodwill, or any type of loss or
  damage suffered as a result of any action brought by a third party) even if such
  damage or loss was reasonably foreseeable or Xilinx had been advised of the
  possibility of the same.

CRITICAL APPLICATIONS
  Xilinx products are not designed or intended to be fail-safe, or for use in any
  application requiring fail-safe performance, such as life-support or safety devices
  or systems, Class III medical devices, nuclear facilities, applications related to
  the deployment of airbags, or any other applications that could lead to death,
  personal injury, or severe property or environmental damage (individually and
  collectively, "Critical Applications"). Customer assumes the sole risk and
  liability of any use of Xilinx products in Critical Applications, subject only to
  applicable laws and regulations governing limitations on product liability.

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES. 



-------------------------------------------------------------------------------------------------
PicoTerm v1.72 
-------------------------------------------------------------------------------------------------


           ____  _         _____
          |  _ \(_) ___ __|_   _|__ _ __ _ __ ____
          | |_) | |/ __/ _ \| |/ _ \ '__| '_ ` _  \ 
          |  __/| | (_| (_) | |  __/ |  | | | | | | 
          |_|   |_|\___\___/|_|\___|_|  |_| |_| |_| 




12th March 2013

Ken Chapman - Xilinx Ltd - email:chapman@xilinx.com


PicoTerm is primarily a simple PC based terminal ideally suited for communication with PicoBlaze 
based designs that utilise the UART macros connected to a USB/UART port on a development 
board or evaluation kit. However, given that PicoTerm is a simple terminal that can be used to
communicate with any 'COM' port it could be used with virtually any hardware and design.

The primary motivation for the development of PicoTerm was to provide a quick and reliable way 
to establish a working connection with a PicoBlaze based UART design. Whilst this should be 
easy to achieve with any terminal application, correctly setting all the communication and 
ASCII options often makes this a challenge. PicoTerm has been pre-configured to match with the 
parameters required for a PicoBlaze/UART designs and has a default BAUD rate of 115200. This 
means that in most cases only the COM port needs to be specified and it even helps to make 
that easier to do.

PicoTerm also has some features that you would not expect to find with a normal terminal. These 
special features are described later in this document and will hopefully appeal to users of 
PicoBlaze for fun, education or serious applications. The 'PicoTerm_routines.psm' file 
provided with PicoTerm contains a set of KCPSM6 routines with descriptions ready to be used with
PicoTerm. What will you use the virtual 7-Segment Display for? 

   
Summary of PicoTerm Features
----------------------------

   - Easy setup
   - 1.6:1 aspect ratio (47 lines of 144 characters)
   - 8 text colours
   - Virtual 7-Segment Display (4-Digits)
   - Virtual LED Display (8 Red + 8 Amber + 8 Green)
   - Virtual Switches Window (16-Switches)
   - 256 x 256 graphic display 
   - Date and Time information


-------------------------------------------------------------------------------------------------
Requirements 
-------------------------------------------------------------------------------------------------

Windows-XP or Windows-7 Operating System.

A 'COM' port to communicate with - This appears to be obvious but do remember that when using a 
                                   USB/UART connection a driver may need to be installed to 
                                   provide you with a 'virtual COM port'. You also need to have 
                                   the hardware connected to your PC and power turned on.

You need to know the number of the COM port and the required BAUD rate (see 'Usage' section).



-------------------------------------------------------------------------------------------------
Usage
-------------------------------------------------------------------------------------------------


Quick Start Method
------------------

PicoTerm has the communication fixed to 8-bit, 1 Stop Bit, No Parity and No Handshake which is 
immediately compatible with the UART macros provided with PicoBlaze. This means that the only 
two variables are the number of the COM port and the BAUD rate. However, even the BAUD rate
defaults to 115200 so if you use this in your design (e.g. as set in the reference designs 
provided with the KCPSM6 version of PicoBlaze) then you don't have to worry about that either.

So if the required BAUD rate is indeed 115200 then simply execute PicoTerm and it will prompt
you to enter a COM Port number. All you need to do is enter the right number. Unfortunately 
this vital piece of information may not be so obvious especially when using a USB/UART where 
the virtual COM port number has been automatically allocated by the driver. But don't worry, 
we can look that information up and PicoTerm is a quick and easy way to make connection attempts.

To find the possible COM port number on your PC then make sure your hardware is connected and 
has the power turned on....

  Right click on 'My Computer' and select 'System Properties'
    Select the 'Hardware' tab.
      Click on 'Device Manager'
        Scan down the list to find 'Ports (COM & LPT)
          Click on '+' to open this section and review COM port numbers.

   For example, a Xilinx Evaluation Kit such as the VC707 board will show something like...
    
      Silicon Labs (CP210x USB to UART Bridge (COM13)   

   Hint - Temporarily disconnecting the USB cable connected to a USB/UART port will typically
          cause the COM port list in the 'Device Manager' to update so you can see which COM 
          port disappears and reappears as you unplug and reconnect it.    


Having entered a COM port number into PicoTerm, it will attempt to open that port. If it is 
unable to open that port then it will tell you. It may be that you specified an invalid port 
number but you should also remember to check that you have no other applications open that are 
already accessing the same port before trying again. 

When a COM port is opened successfully then a message similar to the following will be displayed.

   COM13 is open for communication at 115200 baud.

Then as soon as anything is received from that port or any key is pressed on the keyboard the
screen will automatically clear and start displaying any receive characters. So don't expect 
to see the message above if your hardware is transmitting information as you connect (it will
be obvious that it is working anyway!).


To close PicoTerm press the 'Esc' key or close the window. Although no issues have been 
encountered when simply closing the PicoTerm window, using the 'Esc' key is preferred as it 
does result in a definitive closing of the COM port at the end of the session.



Opening PicoTerm with pre-defined COM port number and/or BAUD rate
------------------------------------------------------------------

If you need to specify a BAUD rate different to 115200 and/or you already know the COM port
number to specify in advance (i.e. you always want to open the same port) then PicoTerm has two
command line options that you can use.

          PicoTerm -c<port> and -b<baud>

  Examples

     PicoTerm -c 13                   Open COM13 with default baud rate of 115200  

     PicoTerm -c13 -b9600             Open COM13 with baud rate of 9600  

     PicoTerm -b9600                  Set baud rate to 9600 but still prompt for port number.   

   
PicoTerm supports BAUD rates of 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200, 230400, 460800
and 921600. Note that not all COM ports (real or virtual) support all of these rates.


  Hint - Higher BAUD rate does NOT always mean faster communication!

         The BAUD rate defines the number of bits per second transmitted or received when a 
         'character' (or byte) is transferred between PicoTerm and a device (e.g. PicoBlaze).
         Each 'character' consists of a start bit, 8 data bits and a stop bit. So for example, 
         at the default BAUD rate of 115200 bits/s it will take 10/115200 = 86.8us to transmit 
         or receive a 'character'.

         It you use the UART transmitter provided with PicoBlaze then it is possible to write 
         multiple characters into its FIFO buffer such that the serial transmission is continuous.
         In other words, the stop bit of one character is immediately followed by the start bit 
         of the next character. Such continuous transmission means that the overall data rate is 
         8/10 of the BAUD rate with the 'loss' attributed to the start and stop bits only. 

         In most cases, you will use PicoTerm to communicate with a virtual COM port associated 
         with a USB/UART bridge device. It has been observed that these virtual COM ports (drivers) 
         often leave relatively long gaps between the transmission of characters. Whilst this is
         is irrelevant when typing on a keyboard, it can significantly increase the time taken to 
         transmit multiple character strings or blocks of data from PicoTerm to a device. This is 
         not generally an issue but don't be surprised if your overall data rate from PC to target 
         device does not improve if you use a higher BAUD rate. Note that a traditional RS232 serial 
         port typically resulted in a data rate of 8/10 of BAUD rate so this is a virtual COM port
         driver issue.  



You can invoke PicoTerm from a DOS window command line or a Batch file. However, it is probably 
easier to create a PicoTerm shortcut and edit its properties. 

How to create a short cut and edit its properties...
   Locate 'PicoTerm.exe' in Explorer.
     Right click on the 'PicoTerm.exe' and select 'Create Shortcut' 
       This should make file called 'Shortcut to PicoTerm.exe' in the same directory
       (note that the icon has a small arrow in a white box on it)
          If you wish, modify the name of the short cut (e.g. 'PicoTerm for COM13').
            Right click on the shortcut and select 'Properties'.
               Append the required options to the 'Target'.
               e.g.   Target:    C:\utilities\PicoTerm\PicoTerm.exe -c13 -b9600  
                  If you want the shortcut on your desktop then simply drag and drop it.




-------------------------------------------------------------------------------------------------
PicoTerm Features
-------------------------------------------------------------------------------------------------

PicoTerm is a deliberately simple terminal but it does incorporate some features that make it 
more compatible with typical PicoBlaze applications as well as for general use.

Wide display with 1.6:1 aspect ratio - Fits well on most landscape monitors and supports 47 lines 
of 144 characters. As with most applications, the physical window size can be adjusted by 
dragging the borders with your mouse but the active terminal size remains 144 x 47 characters.
No characters are displayed once the end of a line has been reached (i.e. line wrapping has been
deliberately prevented from occurring) but will automatically scroll. 

The following control codes (characters) are supported...

'CR'                    - Carriage return with automatic Line Feed with. Note that this avoids
(0D hex = 13)             the requirement for Line Feed characters (0A hex = 10) to be 
Carriage Return           transmitted (except for special circumstances) which helps to keep
                          PicoBlaze programs smaller and easier to develop. Whilst other 
                          terminals can support this automatic line feed functionality it can 
                          often be difficult to find an ASCII setup option to enable it and your
                          display can be a real mess until you do!

'LF' Line Feed          - Feeds a new line but the cursor remains at the same position
(0A hex = 10)             along the new line as it was on the previous line.
Line Feed

'VT'                    - Moves cursor up one line. Note that the cursor cannot move up if
(0B hex = 10)             it is already located on the top line of the visible screen. 
Vertical Tab              (i.e. the cursor has to have space to move up into, it will not 
                          cause the display to scroll downwards within the visible screen).

'BS' or 'DEL'           - Moves the cursor one position to the left and deletes any character 
(08 hex = 8)              previously in that position. If the cursor is already at the start 
(7F hex = 127)            of a line then any character at the start of the line will be 
Back Space or Delete      deleted and the cursor will not move (i.e. start of the current line).
                          
'HT'                    - Advances the cursor to the start of the next column automatically 
(09 hex = 9)              clearing any previously displayed characters between the current 
Horizontal Tab            cursor position and its new position. Each column is 8 characters 
                          wide so the display width of 144 characters is exactly 18 columns.

'BEL' (07 hex = 7)      - Will make a short sound (providing your speaker is turned on!).

'NUL' (00 hex = 0)      - This does nothing at all!


  Hint - CR, LF, VT, BS, DEL, HT, BEL and NUL are predefined constants in the KCPSM6 assembler.

All other control codes (i.e. other codes in the range 01 to 1F hex) are automatically replaced 
with a '*' character. The display of this visible character makes it easier to observe and 
debug applications during development. (See also 'Invalid Characters and Control Sequences'
later in the document).


Escape Sequences
----------------

PicoTerm supports the following 'Escape Sequences'....

  Move cursor to HOME position (upper-left of screen) and set text colour to black.

    'ESC' (1B hex = 27)
    '['   (5B hex = 91)
    'H'   (48 hex = 72)

  Clear screen, move cursor to HOME position and set text colour to black.

    'ESC' (1B hex = 27)
    '['   (5B hex = 91)
    '2'   (32 hex = 50)
    'J'   (4A hex = 74)
 
  
  Set the colour for the display of characters that follow.
 
    'ESC'    (1B hex = 27)
    '['      (5B hex = 91)
    colour   (Where 'colour' is one of the following values)
             (  1E hex = 30'd   Black                      )      
             (  1F hex = 31'd   Red                        )  
             (  20 hex = 32'd   Green                      ) 
             (  21 hex = 33'd   Yellow                     ) 
             (  22 hex = 34'd   Blue                       ) 
             (  23 hex = 35'd   Magenta                    ) 
             (  24 hex = 36'd   Cyan                       ) 
             (  25 hex = 37'd   Grey                       )
             (  26 hex = 38'd   White                      )


  Hint - ESC is predefined constant in the KCPSM6 assembler.

  Hint - 'White' is the background colour so it cannot be seen! It may be used to clear 
         previously displayed text but spaces (20 hex) in any colour would do this as well.


Device Control Strings
----------------------

PicoTerm also implements some 'Device Control Strings' (DCS) that can be useful in PicoBlaze
applications. When PicoTerm receives one of the DCS sequences then it will perform a special 
operation. Some DCS commands will result in PicoTerm responding with another Device Control 
String containing appropriate information such as the time on the PC whilst others are used 
to open and control separate windows representing virtual LED's and 7-Segment digits.

When a DCS is used to facilitate the transfer of information between PicoBlaze (or similar) 
and the PC (e.g. a request for time) then a 'PicoTerm DCS Transactions' window will automatically
open and display a message confirming the request and information exchanged. This ensures 
that all communications with PicoTerm results in something visible on the PC screen which is 
often reassuring as well as useful during PicoBlaze code development. 

The contents of a Device Control String may contain bytes of any value (i.e. data in the range 
00 to FF hex). The following characters that begin and end all 'Device Control Strings' have 
codes that are also beyond the normal 7-bit ASCII range. 
  'DCS' = 'Device Control String' character (90 hex = 144).
   'ST' = 'String Terminator' character (9C hex = 156).

Hint - DCS and ST are predefined constants in the KCPSM6 assembler.

Hint - When PicoTerm responds with a Device Control String it always starts with the same 
       character that was used to make the request. Although PicoBlaze would have made the 
       request and therefore should know what response to expect it is often convenient to 
       implement a DCS handing routine that can operate fairly independently. Therefore, having
       the first character of the response string to identify the meaning of the information 
       can be very useful for such a handling routine. Note that the 'ping' sequence is a 
       special case (see description below). 

Hint - Even if PicoTerm makes a DCS request for some information, the PicoTerm DCS response  
       may not be the very next thing waiting to be read from the UART receiver. Other keyboard
       characters may still be waiting in the receiver FIFO buffer and need to be processed 
       first. 

Note that PicoTerm will always transmit a complete DCS response. Keyboard entries can be made 
during the time that a DCS request and response is taking place but keyboard characters will 
always be transmitted either before or after the DCS response (i.e. will never become part 
of the response string).


Summary of 'Device Control Strings' (DCS) available in this version (full details below).

D - Date string
d - Date value
G - Plot point in graphic display
g - Plot character in graphic display
h - Hide transaction window
L - LED display
p - 'Ping'
q - Force PicoTerm to restart
Q - Force PicoTerm application to quit
S - Read switches
s - Set switches
T - Time string
t - Time value
V - Fill a box in the graphic display
v - Draw a line in the graphic display
7 - Seven segment display




  'Ping' Sequence
  ---------------

    The 'Ping' sequence provides a simple way for PicoBlaze (or similar) to determine if it 
    is communicating with PicoTerm rather than a different terminal. Whilst a DCS sequence 
    such as requesting the time string (described below) could also be used to achieve the
    same thing the 'Ping' sequence is deliberately simple and the response is easy to handle.

    Request to PicoTerm

    'DCS'      
    'p'     
    'ST'        

    When PicoTerm receives this sequence it will display 'Ping!' in the 'PicoTerm DCS 
    Transaction' window and respond with the following sequence.

 
    Response from PicoTerm

    'DCS'      
    'P'     
    'ST'        
 
    Note that the initial request should contain a lower case 'p' (70 hex = 112) but the 
    response is an upper case 'P' (50 Hex = 80). This is the only time that the DCS response 
    from PicoTerm begins with a different (albeit similar) character. This is to ensure that 
    that a simple echo or loop-back connection cannot be confused with a connection to 
    PicoTerm.


  Time String Sequence
  --------------------

    Request to PicoTerm

    'DCS'      
    'T'     
    'ST'        

    PicoTerm response is a string of 8 ASCII characters describing the current time
    on the PC. The time is 24-hour with an hour value range of '00' to '23'.
    For example...   14:27:58 

    'DCS'  
    'T'  
    '1'
    '4'
    ':'
    '2'
    '7'
    ':'
    '5'
    '8'
    'ST' 


  Time Value Sequence
  -------------------

    Request to PicoTerm

    'DCS'      
    't'     
    'ST'        

    PicoTerm response is a series of 3 byte values representing the current time on the 
    PC in hours, minutes and seconds. 

    'DCS'  
    't'  
    hours     (byte value 00 to 17 hex = 0 to 23)
    minutes   (byte value 00 to 3B hex = 0 to 59)
    seconds   (byte value 00 to 3B hex = 0 to 59)
    'ST' 


  Date String Sequence
  --------------------

    Request to PicoTerm

    'DCS'      
    'D'    
    'ST'       

    PicoTerm response is a string of 11 ASCII characters describing the current date 
    on the PC. The day is always represented by 2 characters, the month by 3 characters
    and the year by 4 characters. For example...   02 May 2012

    'DCS'    
    'D'
    '0'
    '2'
    ' '
    'M'
    'a'
    'y'
    ' '
    '2'
    '0'
    '1'
    '2'
    'ST' 


  Date Value Sequence
  -------------------

    Request to PicoTerm

    'DCS'      
    'd'     
    'ST'        

    PicoTerm response is a series of 3 byte values representing the current date on the 
    PC as year, month and day.  

    'DCS'  
    'd'  
    year      (byte value 00 to 63 hex = 0 to 99)   e.g. '12' for the year 2012.
    month     (byte value 01 to 0C hex = 1 to 12)
    day       (byte value 01 to 1F hex = 1 to 31)
    'ST' 



  Hide DCS Transactions Window
  ----------------------------

    The messages displayed in the 'DCS Transactions Window' can be very useful during the 
    development of an application. They show you the values being sent back to you in 
    response to your requests and will also help you to see when mistakes have been made.
    However, this window can be distracting once an application is fully developed and stable
    so this sequence can be used to close the 'DCS Transactions Window' or to prevent it from 
    opening in the first place. PicoTerm will not issue a DCS response to this request.

    'DCS'      
    'h'     
    'ST'        


  PicoTerm Application Control
  ----------------------------

    The DCS shown below can be used to force the PicoTerm application on the PC to close (Quit).
    One situation in which this may be used is when a design uses PicoTerm to display various 
    information during initialisation and then automatically closes PicoTerm if everything
    works correctly or stays open to display an initialisation error.

    'DCS'      
    'Q'      (upper case)
    'ST'        

    The following DCS effectively forces the PicoTerm application to restart (a soft quit). The 
    main window will remain open but the screen will be cleared and the cursor set in the HOME
    position (equivalent to the '[2J' escape sequence). Any PicoTerm feature windows that are 
    open will be closed (e.g. virtual LED window). It can be useful to use this DCS during 
    code development.

    'DCS'      
    'q'      (lower case)
    'ST'        



Virtual LED Display
-------------------

The PicoTerm Virtual LED Display is a pop-up window containing 24 virtual LEDs. There are 8 red,
8 yellow (amber) and 8 green LEDs arranged in 3 rows as shown below.

         
                      7   6   5   4   3   2   1   0
         
             Red      O   O   O   O   O   O   O   O
             Amber    O   O   O   O   O   O   O   O
             Green    O   O   O   O   O   O   O   O
         

The virtual display is opened and updated using a 'Device Control String' (DCS) sequence. When 
PicoTerm receives the first virtual LED display DCS sequence it will open the virtual LED window
with the specified LEDs 'turned on'. Subsequent virtual LED display DCS sequences will modify 
the LEDs to reflect the new control values provided. Note that PicoTerm does not transmit 
a DCS sequence back to the COM port.

The DCS sequence for the virtual LED display is as follows (please read the 'Device Control 
Strings' section above if you are unfamiliar with this concept)...

    'DCS'      
    'L'
    RED_control_byte    
    YELLOW_control_byte    
    GREEN_control_byte    
    'ST'       

The virtual LEDs of each colour are controlled by the corresponding bits contained in each of 
control bytes. For example the least significant bit of 'GREEN_control_byte' will control the 
virtual LED in the lower right hand corner of the display.




Virtual 7-Segment Display
-------------------------

The PicoTerm Virtual 7-Segment Display is a pop-up window containing a virtual 4-digit, 
7-segment display. The digits and their segments are identified below.


              Digit 3             Digit 2             Digit 1             Digit 0

                 a                   a                   a                   a
                ___                 ___                 ___                 ___
              |     |
            f |     | b         f |     | b         f |     | b         f |     | b 
              |  g  |             |  g  |             |  g  |             |  g  |
                ___                 ___                 ___                 ___
    
              |     |             |     |             |     |             |     |
            e |     | c         e |     | c         e |     | c         e |     | c
              |  d  |             |  d  |             |  d  |             |  d  |
                ___   p            ___    p             ___   p             ___   p


The virtual display is opened and updated using a 'Device Control String' (DCS) sequence. When 
PicoTerm receives the first virtual display DCS sequence it will open the window and display 
the digits with the specified segments 'turned on'. Subsequent virtual display DCS sequences 
will modify the display to reflect the new control values provided. Note that PicoTerm does 
not transmit a DCS sequence back to the COM port.

The DCS sequence for the virtual 7-Segment display is as follows (please read the 'Device Control 
Strings' section above if you are unfamiliar with this concept)...

    'DCS'      
    '7'
    digit0_segment_control_byte    
    digit1_segment_control_byte    
    digit2_segment_control_byte    
    digit3_segment_control_byte    
    'ST'       

The segments of each digit are controlled by the bits contained in the control bytes. Each 
digit has 7 segments and a decimal point and a segment will be 'turned on' when the corresponding
bit of the control byte is High (1).

           Segment  Bit
        
              a      0
              b      1                  
              c      2
              d      3
              e      4
              f      5
              g      6
              p      7   decimal point


Hint - See the 'nibble_to_7seg' routine provided in the 'PicoTerm_routines.psm' file.




Virtual Switches
----------------

PicoTerm Virtual Switches is a pop-up window containing 16 virtual switches. Each switch has  
the appearance of a square black button with an embedded green LED. Clicking on a virtual 
button will toggle the state of the switch and the virtual LED will indicate the current
state, i.e. LED on means switch is turned on ('1').

        
      15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
      
       O   O   O   O   O   O   O   O   O   O   O   O   O   O   O   O

There are two 'Device Control String' (DCS) sequences that can be used in conjunction with the 
virtual switches. The first time either sequence is received by PicoTerm the Virtual Switches 
display will be opened.

The first and most useful DCS sequence is used to read the current states of switches. If this
is also used to open the window then all 16 switches will initially be off ('0').

    Request to PicoTerm to read virtual switches

    'DCS'      
    'S'             (upper case 'S')
    'ST'       

In response to each use of the above DCS sequence, PicoTerm will respond with the following 
DCS sequence reporting the current states of all 16 switches.

    PicoTerm response

    'DCS'  
    'S'  
    switches(0)     (current states of switches[7:0])
    switches(1)     (current states of switches[15:8])
    'ST' 

Note that whilst the effect of clicking on a switch is immediately reflected by its indicator
LED, PicoTerm will only generate a DCS sequence in response to a DCS request. Hence, PicoBlaze
must issue a DCS request in order to determine the current states of the switches (this is
similar to the way in which PicoBlaze would need to read an input port to determine the current 
states of physical switches). 

In the top right of the virtual switches window is an small dot. When this dot is green it 
indicates that the current switch settings have not changed since the last DCS request and 
response occurred and implies that PicoBlaze has up to date information (of course the 
PicoBlaze program is responsible for processing and using the information correctly). When 
a virtual switch is changed the dot will become red until the time of the next DCS request. 
Hence a red dot indicates that PicoBlaze has not read the latest states of the switches.

The second DCS sequence shown below can be used to set the 16 virtual switches either when 
opening the window or during operation. PicoTerm will set the indicator LEDs on each switch as 
defined by the two byte values provided. 
    Request to PicoTerm to set virtual switches

    'DCS'      
    's'             (lower case 's')
    switches(0)     (new states for switches[7:0])
    switches(1)     (new states for switches[15:8])
    'ST'       

PicoTerm does not generate a DCS response to this sequence because the state of the switches 
is known.



Graphic Display
---------------

This display contains a grid of 256 x 256 points allowing simple graphs, shapes and patterns 
to be plotted using 9 colours. Characters can also be displayed enabling graphs to be annotated 
with scales and labels etc.

There are four 'Device Control String' (DCS) sequences available for use with the graphic 
display. The 'PicoTerm Graphic Display' pop-up window will automatically open the first time 
any one of these sequences is used.

  G - Plot a single point.
  v - Draw a line between two points.
  V - Fill the box defined by two points. 
  g - Display a character at a specified position.


Each sequence is described in greater detail below. However, all sequences require one or two 
points to be specified as X-Y coordinates. Although a 256 x 256 display does not provide the 
kind of high resolution we have become used to these days, the primary objective of PicoTerm 
is to be easy to use. With that in mind, the X-Y coordinates are simple byte values (00 to FF 
hex (0'd to 255'd) which are a natural fit with both UART communication and PicoBlaze.   

          Y |(0,255)    (255,255)          
            |                              As illustrated, the lower-left corner is the  
            |       (X,Y)                  display origin (0,0) is the lower-left corner     
            |                              which feels natural and easy to work with. 
            |(0,0)        (255,0)
             -------------------- 
                                X


Likewise, all sequences require you to specify the colour of the object to be displayed. 
The following values define each of the 9 colours available. 

     1E hex = 30'd   Black (also used if colour value provided is outside normal range) 
     1F hex = 31'd   Red        
     20 hex = 32'd   Green      
     21 hex = 33'd   Yellow     
     22 hex = 34'd   Blue       
     23 hex = 35'd   Magenta    
     24 hex = 36'd   Cyan       
     25 hex = 37'd   Grey 
     26 hex = 38'd   White 

  Hint - This is the same colour palette available for text in the main PicoTerm window.
         In this case, 'white' can really be useful because it will be visible when plotting
         in an area previously set to a different colour. Alternatively, you can think in 
         terms of White allowing you to 'clear' points. Regardless, 'white' soon becomes a 
         useful colour in the display window.


 
  Sequence to set a single point
  ------------------------------

    'DCS'      
    'G'             (upper case 'G')
     x              
     y      
     colour
    'ST' 
     
  This sequence can be used to set any of the 65,536 points to one of the 9 colours. It is 
  typically used when plotting simple graphs but its simplicity actually provides you with 
  the flexibility to do anything.

  It is worth noting that when operating with a default baud rate of 115200, it will take 
  ~521us to transmit this 6-character DCS sequence. This implies a plotting rate of 1,920 
  points per second. Hence a simple line graph consisting of 256 points can be plotted in 
  133ms which is reasonable. However, attempting to set all 65,536 point (e.g. to display 
  a 256x256 image) would take over 34 seconds and generally a technique to avoid!



  Sequence to draw a line between two points.
  -------------------------------------------

    'DCS'      
    'v'             (lower case 'v')
     x1             Start of line (x1,y1) 
     y1
     x2             End of line (x2,y2) 
     y2
     colour
    'ST' 

  This sequence defines the points at the start (x1,y1) and end (x2,y2) of a line. PicoTerm 
  works out the vector and sets all the points required to form a continuous line of the 
  colour specified. Although this 8-character DCS sequence will take slightly longer to 
  transmit (~694us at 115200 baud) it could set up to 256 points in one transaction and is 
  a faster way to draw lines than plotting individual points. Note that there are no 
  restrictions concerning the relative positions of the start and end points; PicoTerm will 
  draw a connecting line of whatever length and in whatever direction is needed to connect them.

  Hint - Even though vertical and horizontal lines (e.g. graph axes) are easy to plot as 
         a series of individual points, using this sequence makes plotting faster and much 
         easier to define. When plotting a graph, you may find the overall appearance is 
         improved when using short connecting lines rather than isolated points.



  Sequence to fill a box defined by two points.
  ---------------------------------------------

    'DCS'      
    'V'             (upper case 'V')
     x1             First Corner (x1,y1) 
     y1
     x2             Second Corner (x2,y2) 
     y2
     colour
    'ST' 

  This sequence defines the points at two diagonally opposite corners of a rectangular (or 
  square) box which PicoTerm will completely fill with the specified colour. As with drawing 
  lines, there are no restrictions concerning the relative positions of the two points but it 
  is generally easier to think in terms of the first point (x1,y1) being in the lower-left 
  corner and the second point (x2,y2) being in the upper-right corner.

  This sequence can dramatically improve the speed at which large areas can have all points 
  set to the same colour. For example, specifying points (0,0) and (255,255) and the colour 
  white will effectively 'clear' the entire display in one transaction (~694us at 115200 baud).

  Hint - A grey rectangle can be a good background for a graph. When presenting more than one 
         graph at a time (e.g. one at the top and another at the bottom) the grey rectangles 
         can really help define the plotting area of each.



  Sequence to display a character.
  --------------------------------
 
    'DCS'      
    'g'             (lower case 'g')
     x              
     y      
     colour
     character
    'ST' 

  This sequence allows a character to be displayed at any position using any colour. There are 
  two font sizes available (small and large). The X-Y coordinates specifies the lower-left 
  corner of a small 'virtual box' which the character will occupy. 

                                                                     * * * * .
  The 'virtual box' of a large font character is 5-points            * . . . *
  wide and 7-points tall. The specified X-Y coordinate always        * . . . *    5 x 7
  defines the lower-left corner even if that point is not            * * * * .   character
  used by the character. The image on to the right illustrates       * . . . .    'box'
  the 15 points out of a possible 35 points that PicoTerm will       * . . . .
  set to the specified colour in order to display a capital 'P'.    y* . . . .
                                                                     x
           
  Small font size characters are exactly half the size of the large font size characters with 
  a 'virtual box' that is 2.5 points wide and 3.5-points tall. In practice, PicoTerm uses the 
  same 5 x 7 bit map for each character but then divides each regular point into four smaller 
  points. 

  Hint - When displaying text or a label, space small characters at 3-point intervals and large
         characters at 6-point intervals.

  Note that when each character is displayed, only the points required to form the character are
  set and all other points within the 'virtual box' will remain the same. When using the small 
  font size then only the required quarters of each regular point will be set so even the 
  remainder of a regular point will remain the same. This is equivalent to writing on a piece 
  of paper with a pen and means that labels can be added to a graph (or refreshed) without 
  obliterating all the information that has been previously plotted. 

  Hint - The above may sound natural and obvious but it is completely different to the way in
         which characters are displayed in the main PicoTerm window. Displaying a space (20 hex)
         in the main window will completely clear a previous character at the same location 
         whereas displaying a space in the graphic window has no effect at all. If you do 
         really need to clear the whole 'virtual box' of a character in the graphic window 
         then use the solid 5x7 'box' character (see later) with colour set to white.

  The 'character' value is based on standard ASCII codes and indeed values in the range 20 to 
  7E hex (32'd to 126'd) will all result in the display of the expected ASCII character. 
  However, codes in the range 00 to 1F hex (0'd to 31'd) and 7F (127'd) are traditionally 
  associated with control which is not relevant to the graphic window so some other useful 
  characters, symbols and shapes have been assigned to these codes as shown in the table below.

  A small font size character will be displayed when the code in the range 00 to 7F hex (0'd to 
  127'd). Simply add 80 hex (128'd) to the normal codes to display the character using the 
  large font size (i.e. codes in the range 80 to FF hex (128'd to 255'd) are large font). 


       Non-standard 'character' codes
      
        Hex   Dec   character
      
        00      0    edged 5x7 'virtual box'
        01      1    up arrow
        02      2    right arrow
        03      3    down arrow
        04      4    left arrow
        05      5    degrees
        06      6    micro
        07      7    pi
        08      8    ohm
        09      9    British Pound
        0A     10    Euro
        0B     11    Sigma (upper case)
        0C     12    Sigma (lower case)
        0D     13    divide
        0E     14    Hourglass
        0F     15    Bus cross
        10     16    Bus lines
        11     17    reserved (solid box)
        12     18    reserved (solid box)
        13     19    reserved (solid box)
        14     20    reserved (solid box)
        15     21    reserved (solid box)
        16     22    reserved (solid box)
        17     23    reserved (solid box)
        18     24    single point (0,0)
        19     25    single point (1,0)
        1A     26    single point (0,1)
        1B     27    single point (1,1)
        1C     28    solid 5x5 triangle (upper-left)
        1D     29    solid 5x5 triangle (lower-left)
        1E     30    solid 5x5 triangle (upper-right)
        1F     31    solid 5x5 triangle (lower-right)
        7F    127    solid 5x7 'virtual box'


  Hint - The four 'single point' characters used with a small font size enable each
         quadrant of the regular point specified in the X-Y coordinate to be set. 
         This opens the potential to implement a scheme that increases the plotting
         resolution to 512 x 512 points (262,144 virtual points).



Invalid Characters and Control Sequences
----------------------------------------

In an ideal world your application will only transmit valid characters and valid escape and DCS
sequences to PicoTerm and everything will work precisely as intended. However, mistakes do 
happen especially during code development so it is useful to know how PicoTerm has been designed
to react when it receives unexpected characters and sequences.

Any control codes (i.e. codes in the range 01 to 1F hex) and all 8-bit codes  (80 to FF hex)
not supported by PicoTerm are automatically replaced with a '*' character. The display of
this visible character makes it easier to observe and debug applications during development.

The most common mistakes when developing an application are the incorrect preparation of a 
character code (e.g. when converting a binary value into its ASCII representation) or the 
incorrect implementation of a Device Control String (DCS) resulting in raw 8-bit values then 
being interpreted by PicoTerm as ASCII characters (see below).

When an escape sequence does not match with any of those supported then PicoTerm will abandon
the processing of the sequence at the earliest opportunity with any subsequent characters being 
displayed in the main terminal window. For example, if a mistake is made when attempting to 
issue a clear screen sequence...
         
   invalid sequence  'ESC'  '['  '3'  'J'  is transmitted to PicoTerm 
   correct sequence  'ESC'  '['  '2'  'J'  (contains '2' rather than '3')

... PicoTerm will abandon the sequence as soon as '3' is received and then both '3' and 'J' will
be displayed in the main terminal window. Not what you expected, but being observable helps.  

In a similar way, when a DCS sequence does not match with any of those supported then PicoTerm
will abandon the processing of the sequence at the earliest opportunity. 'Invalid string! will 
be displayed in the 'PicoTerm DCS Transactions' window and any subsequent characters will be 
displayed in the main terminal window. Since some DCS sequences are associated with byte data, 
the subsequent characters displayed could be anything and quite often '*' would be observed 
because byte values can easily be in the range 128 to 255 (80 to FF hex). 


-------------------------------------------------------------------------------------------------
End of 'PicoTerm_README.txt'
-------------------------------------------------------------------------------------------------

