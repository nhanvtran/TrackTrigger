#ifndef _PxSuite_PxNetworkDevice_h
#define _PxSuite_PxNetworkDevice_h

#include <string>
#include <map>
#include <netinet/in.h>

struct ifaddrs;

namespace PxSuite
{

class PxNetworkDevice
{
public:
    PxNetworkDevice(std::string IPAddress, unsigned int port);
    ~PxNetworkDevice();

    int         initSocket      (std::string socketPort="");
    int         initSocket      (unsigned int socketPort);
    //int closeSocket(std::string socketPort="");
    int         ping            (int socketDescriptor);
    int         send            (int socketDescriptor, const std::string& msg);
    int         receive         (int socketDescriptor,       std::string& msg);
    std::string getFullIPAddress(std::string partialIpAddress);
    std::string getInterfaceName(std::string ipAddress);
    std::string getMacAddress   (std::string interfaceName);

protected:
    enum {maxSocketSize=65536};

    struct sockaddr_in deviceAddress_;
    //    socket,socket port
    std::map<int,int>  openSockets_;

private:
    enum{FirstSocketPort=10000,LastSocketPort=15000};

    int getInterface(std::string partialIpAddress);

    struct ifaddrs* communicationInterface_;//Interface communicating with device aka computer interface
    char            readBuffer_[maxSocketSize];
};

}

#endif
