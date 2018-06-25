/* Generated from orogen/lib/orogen/templates/typekit/mqueue/TransportPlugin.cpp */

// First load all RTT interfaces so that we get all "extern template"
// declarations in the TypekitImpl files
#include "transports/mqueue/Registration.hpp"
#include "transports/mqueue/TransportPlugin.hpp"
#include <rtt/transports/mqueue/MQLib.hpp>
#include <rtt/types/TypekitPlugin.hpp>
using namespace RTT;

#include "transports/typelib/TransportPlugin.hpp"
#include <typelib/pluginmanager.hh>
#include <typelib/registry.hh>
#include <rtt/Logger.hpp>

orogen_typekits::camera_simulatorMQueueTransportPlugin::camera_simulatorMQueueTransportPlugin()
    : m_registry(0)
{
    std::string path = camera_simulatorTypelibTransportPlugin::getTypelibRegistryPath();
    try
    {
        m_registry = Typelib::PluginManager::load("tlb", path);
    }
    catch(std::exception const& e) {
        log(Error) << "cannot load the typekit's Typelib registry from" << endlog();
        log(Error) << "  " << path << endlog();
#ifndef HAS_ROSLIB
        log(Error) << "remember to do 'make install' before you use the oroGen-generated libraries ?" << endlog();
#endif
        log(Error) << endlog();
        log(Error) << "the MQueue transport will not be available for types defined in this typekit" << endlog();
    }
}

orogen_typekits::camera_simulatorMQueueTransportPlugin::~camera_simulatorMQueueTransportPlugin()
{
    delete m_registry;
}

bool orogen_typekits::camera_simulatorMQueueTransportPlugin::registerTransport(std::string type_name, RTT::types::TypeInfo* ti)
{
    if (!m_registry)
        return false;

    
    return false;
}
std::string orogen_typekits::camera_simulatorMQueueTransportPlugin::getTransportName() const
{ return "MQueue"; }
std::string orogen_typekits::camera_simulatorMQueueTransportPlugin::getTypekitName() const
{ return "/orogen/camera_simulator"; }
std::string orogen_typekits::camera_simulatorMQueueTransportPlugin::getName() const
{ return "/orogen/camera_simulator/MQueue"; }

ORO_TYPEKIT_PLUGIN(orogen_typekits::camera_simulatorMQueueTransportPlugin);

