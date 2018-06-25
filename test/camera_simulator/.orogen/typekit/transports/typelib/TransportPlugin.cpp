/* Generated from orogen/lib/orogen/templates/typekit/typelib/TransportPlugin.cpp */

#include "Registration.hpp"
#include "TransportPlugin.hpp"
#include <rtt/typelib/TypelibMarshallerBase.hpp>
#include <rtt/Logger.hpp>
#include <rtt/types/TypekitPlugin.hpp>
using namespace RTT;
#ifdef HAS_ROSLIB
#include <ros/package.h>
#endif

#define TYPEKIT_PACKAGE_NAME_aux0(target) #target
#define TYPEKIT_PACKAGE_NAME_aux(target) "camera_simulator-typekit-" TYPEKIT_PACKAGE_NAME_aux0(target)
#define TYPEKIT_PACKAGE_NAME TYPEKIT_PACKAGE_NAME_aux(OROCOS_TARGET)

std::string orogen_typekits::camera_simulatorTypelibTransportPlugin::getTypelibRegistryPath()
{
#ifdef HAS_ROSLIB
    /** If ROSLIB is available, we'll use ros::package to find the path to a package with the
      same name as our typekit. This may only be enabled if IS_ROS_PACKAGE is true at build time ! **/
    using namespace ros::package;
    try {
        bool all_good = true, found = false;
        std::string ppath = getPath( "camera_simulator" );
        if ( !ppath.empty() ) {
            return ppath + "/typekit" + "/camera_simulator.tlb";
        } else
            log(Debug) << "Not a ros package: " << "camera_simulator" << endlog();
    } catch(...) {
        log(Debug) << "Not a ros package: " << "camera_simulator" << endlog();
    }
#endif
    return TYPEKIT_REGISTRY;
}

std::string orogen_typekits::camera_simulatorTypelibTransportPlugin::getTlbPath() const
{
    return camera_simulatorTypelibTransportPlugin::getTypelibRegistryPath();
}

orogen_typekits::camera_simulatorTypelibTransportPlugin::camera_simulatorTypelibTransportPlugin()
    : TypelibTransportPlugin("camera_simulator") {}

bool orogen_typekits::camera_simulatorTypelibTransportPlugin::registerTransport(std::string type_name, RTT::types::TypeInfo* ti)
{
    if (!m_registry)
    {
        if (!loadRegistry())
            return false;
    }
    
    if(ti->hasProtocol(orogen_transports::TYPELIB_MARSHALLER_ID))
	return false;

    
    return false;
}

ORO_TYPEKIT_PLUGIN(orogen_typekits::camera_simulatorTypelibTransportPlugin);

