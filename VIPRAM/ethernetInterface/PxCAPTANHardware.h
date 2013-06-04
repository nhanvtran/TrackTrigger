#ifndef _PxSuite_PxCAPTANHardware_h
#define _PxSuite_PxCAPTANHardware_h

#include "PxNetworkDevice.h"
#include "PxDataTypes.h"

#include <string>
#include <vector>

namespace PxSuite
{

class PxCAPTANHardware : public PxNetworkDevice
{

public:
    PxCAPTANHardware (std::string captanIPAddress, std::string captanIPPort, std::string captanReadSocket, std::string captanWriteSocket);
    virtual ~PxCAPTANHardware(void);
    int init(void);
    int read (UInt64 address,       std::string&         buffer);
    int read (UInt64 address,       std::vector<UInt64>& buffer);
    int write(UInt64 address, const std::string&         buffer);
    int write(UInt64 address, const std::vector<UInt64>& buffer);
    int setupCaptanReadSocket(void);
    
private:
    typedef struct destinationComputerInfo
    {
    	std::string ipAddress;
    	std::string macAddress;
    	std::string interfaceName;
    };
    destinationComputerInfo destinationComputer_;
    void helperInsertBits (Char* dout, UInt64 din,   UInt32 start_bit, UInt32 num_of_bits);
    void helperExtractBits(Char* src , UInt64 &dest, UInt32 start_bit, UInt32 num_of_bits);
    
    const std::string& convertToString(UInt16 val);
    const std::string& convertToString(UInt32 val);
    const std::string& convertToString(UInt64 val);
    
    const std::string captanBaseIP_;
          std::string captanIPAddress_;
          std::string captanIPPort_;

    int captanReadSocketDescriptor_;
    int captanWriteSocketDescriptor_;
    
    std::string string16_;
    std::string string32_;
    std::string string64_;
};

}

#endif
