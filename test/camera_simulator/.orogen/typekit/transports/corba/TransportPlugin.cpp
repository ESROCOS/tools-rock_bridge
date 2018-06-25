/* Generated from orogen/lib/orogen/templates/typekit/corba/TransportPlugin.cpp */

// First load all RTT interfaces so that we get all "extern template"
// declarations in the TypekitImpl files
#include "transports/corba/Registration.hpp"
#include "transports/corba/TransportPlugin.hpp"
#include <rtt/transports/corba/CorbaLib.hpp>
#include <rtt/types/TypekitPlugin.hpp>
using namespace RTT;

bool orogen_typekits::camera_simulatorCorbaTransportPlugin::registerTransport(std::string type_name, RTT::types::TypeInfo* ti)
{
    if(ti->hasProtocol(ORO_CORBA_PROTOCOL_ID))
	return false;

    
    return false;
}
std::string orogen_typekits::camera_simulatorCorbaTransportPlugin::getTransportName() const
{ return "CORBA"; }
std::string orogen_typekits::camera_simulatorCorbaTransportPlugin::getTypekitName() const
{ return "/orogen/camera_simulator"; }
std::string orogen_typekits::camera_simulatorCorbaTransportPlugin::getName() const
{ return "/orogen/camera_simulator/CORBA"; }

ORO_TYPEKIT_PLUGIN(orogen_typekits::camera_simulatorCorbaTransportPlugin);

