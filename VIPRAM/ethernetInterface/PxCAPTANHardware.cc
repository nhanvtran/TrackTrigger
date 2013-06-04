#include "PxCAPTANHardware.h"
#include <cstdlib>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
//#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <iostream>
#include <net/if.h>
#include <sys/ioctl.h>
#include <sstream>

using namespace std;

using namespace PxSuite;
//========================================================================================================================
PxCAPTANHardware::PxCAPTANHardware (std::string captanIPAddress, std::string captanIPPort, std::string captanReadSocket, std::string captanWriteSocket) :
        PxNetworkDevice   (captanIPAddress,captanIPPort),
        captanBaseIP_     ("192.168.133"),
        captanIPAddress_  (captanIPAddress),
        captanIPPort_     (captanIPPort),
        string16_         (string(2,' ')),
        string32_         (string(4,' ')),
        string64_         (string(8,' '))
{
    destinationComputer_.ipAddress     = PxNetworkDevice::getFullIPAddress(captanBaseIP_);
    destinationComputer_.interfaceName = PxNetworkDevice::getInterfaceName(destinationComputer_.ipAddress);
    destinationComputer_.macAddress    = PxNetworkDevice::getMacAddress(destinationComputer_.interfaceName);
}

//========================================================================================================================
PxCAPTANHardware::~PxCAPTANHardware(void)
{
    cout << __PRETTY_FUNCTION__ << endl;
    close(captanWriteSocketDescriptor_);
    close(captanReadSocketDescriptor_);
}

//========================================================================================================================
int PxCAPTANHardware::init(void)
{
    //initCaptanAddress();
    captanWriteSocketDescriptor_ = PxNetworkDevice::initSocket();
    captanReadSocketDescriptor_  = PxNetworkDevice::initSocket();
    setupCaptanReadSocket ();
    return 0;
}

//========================================================================================================================
int  PxCAPTANHardware::read(UInt64 address, string& buffer)
{
    return 0;
}

//========================================================================================================================
int  PxCAPTANHardware::read(UInt64 address, vector<UInt64>& value)
{
    return 0;
}

//========================================================================================================================
int PxCAPTANHardware::write(UInt64 address, const string& value)
{
    cout << __PRETTY_FUNCTION__ << __LINE__ <<"\tAddress:" << address << " Val: "<< value << "-" << endl;
    string buffer;
    buffer += 1;
    buffer += value.size()/8;
    buffer += convertToString(address);
    buffer += value;
    cout << __PRETTY_FUNCTION__ << __LINE__ <<"\tMessage:-";

    for(UInt32 i=0; i<buffer.size(); i++)
        cout << hex << (UInt16)buffer[i] << "-";

    cout << dec << endl;

    return PxNetworkDevice::send(captanWriteSocketDescriptor_,buffer);
}

//========================================================================================================================
int PxCAPTANHardware::write(UInt64 address, const vector<UInt64>& buffer)
{
    /*
        if(sendto(captanWriteSocketDescriptor_,buffer.c_str(),buffer.size()-1,0,(struct sockaddr *)&(PxNetworkDevice::deviceAddress_), sizeof (PxNetworkDevice::deviceAddress_)) < (int)(buffer.size()-1))
        {
            cout << __PRETTY_FUNCTION__ << "Error writing buffer" << endl;
            return -1;
        }
    */
    return 0;
}

//========================================================================================================================
int PxCAPTANHardware::setupCaptanReadSocket(void)
{
    string value = convertToString((UInt32)openSockets_[captanReadSocketDescriptor_]).substr(2,2) + destinationComputer_.macAddress;
    write(0x1900, value);
    value = convertToString((UInt64)atoi(destinationComputer_.ipAddress.substr(destinationComputer_.ipAddress.find_last_of('.')+1,destinationComputer_.ipAddress.size()).data()));
    write(0x1A00, value);
    //ping Captan ***********************
    if(PxNetworkDevice::ping(captanReadSocketDescriptor_) == -1)
        cout << __PRETTY_FUNCTION__ << __LINE__ << "]\tUnable to ping CAPTAN" << endl;

    return 0;
}

//========================================================================================================================
void PxCAPTANHardware::helperInsertBits(Char* dout, UInt64 din, UInt32 start_bit, UInt32 num_of_bits)
{
    unsigned int i  = (start_bit%64)/8;
    unsigned int qw = start_bit/64;
    unsigned int b  = start_bit%8;
    unsigned int db = 0;

    while(db < num_of_bits)
    {
        if(b == 8)
        {
            b = 0; ++i;

            if(i == 8)
            {
                i = 0;
                ++qw;
            }
        }

        dout[qw*8+7-i] = (dout[qw*8+7-i]& (~(1 << b))) | (((din >> db) & 1) << b); // add bit to dout

        ++b;
        ++db;
    }
}


//========================================================================================================================
//extracts <num_of_bits> bits starting at <start_bit> from string <src> into integer <dest>
//assumes src and dest are big enough (32 bits is max size extracted)
//start_bit index cooresponds to configware indices.
void PxCAPTANHardware::helperExtractBits(Char* src, UInt64& dest, UInt32 start_bit, UInt32 num_of_bits)
{

    unsigned int i  = (start_bit%64)/8;
    unsigned int qw = start_bit/64;
    unsigned int b  = start_bit%8;
    unsigned int db = 0;

    dest = 0; //init to 0

    while(db < num_of_bits)
    {
        if(b == 8)
        {
            b = 0; ++i;

            if(i == 8)
            {
                i = 0;
                ++qw;
            }
        }

        dest |= ((src[qw*8+7-i] >> b) & 1) << db;

        ++b;
        ++db;
    }
}

//========================================================================================================================
const string& PxCAPTANHardware::convertToString(UInt16 val)
{
    for(UInt32 i=0; i<2; i++)
        string32_[1-i] = (val >> i*8) & 0xff;

    return string16_;
}

//========================================================================================================================
const string& PxCAPTANHardware::convertToString(UInt32 val)
{
    for(UInt32 i=0; i<4; i++)
        string32_[3-i] = (val >> i*8) & 0xff;

    return string32_;
}

//========================================================================================================================
const string& PxCAPTANHardware::convertToString(UInt64 val)
{
    for(UInt32 i=0; i<8; i++)
        string64_[7-i] = (val >> i*8) & 0xff;

    return string64_;
}

