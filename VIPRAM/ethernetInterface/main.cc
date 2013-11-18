#include <iostream>
#include <stdio.h>
#include <pthread.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

#include "PxCAPTANHardware.h"
#include "PxNetworkDevice.h"
#include "PxDataTypes.h"

#define MYPORT "11000"  // the port users will be connecting to
#define segLength 1600

using namespace std;

int main () {

    std::cout << "Welcome to the GEI interface!" << std::endl;
    
//    PxSuite::PxCAPTANHardware theHardware = new PxSuite::PxCAPTANHardware("192.168.133.4","2001","11000","11001");
    std::cout << "Setup the hardware..." << std::endl;
    PxSuite::PxCAPTANHardware theHardware("192.168.133.7",2001,11000,11001);

    std::cout << "Initialize the hardware..." << std::endl;
    theHardware.init();
    string value;
    theHardware.read(0x0,value);
    

//    std::cout << "Ping!" << std::endl;
//    theHardware.ping( 110000 );
    
//    vipramNetworkDevice trial1;
    
    return 0;
}
