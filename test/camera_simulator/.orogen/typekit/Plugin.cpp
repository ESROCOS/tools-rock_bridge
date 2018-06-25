/* Generated from orogen/lib/orogen/templates/typekit/Plugin.cpp */

// First load all RTT interfaces so that we get all "extern template"
// declarations in the TypekitImpl files
#include <camera_simulator/typekit/Plugin.hpp>

#include <boost/lexical_cast.hpp>

#include <rtt/types/TypeInfoRepository.hpp>
#include "type_info/Registration.hpp"

using namespace RTT;

orogen_typekits::camera_simulatorTypekitPlugin::camera_simulatorTypekitPlugin()
{}

orogen_typekits::camera_simulatorTypekitPlugin::~camera_simulatorTypekitPlugin()
{}


#define TYPEKIT_PACKAGE_NAME_aux0(target) #target
#define TYPEKIT_PACKAGE_NAME_aux(target) "camera_simulator-typekit-" TYPEKIT_PACKAGE_NAME_aux0(target)
#define TYPEKIT_PACKAGE_NAME TYPEKIT_PACKAGE_NAME_aux(OROCOS_TARGET)
bool orogen_typekits::camera_simulatorTypekitPlugin::loadTypes()
{
    RTT::types::TypeInfoRepository::shared_ptr ti_repository = RTT::types::TypeInfoRepository::Instance();

    

    return true;
}

bool orogen_typekits::camera_simulatorTypekitPlugin::loadOperators()
{ return true; }
bool orogen_typekits::camera_simulatorTypekitPlugin::loadConstructors()
{ return true; }
std::string orogen_typekits::camera_simulatorTypekitPlugin::getName()
{ return "camera_simulator"; }

ORO_TYPEKIT_PLUGIN(orogen_typekits::camera_simulatorTypekitPlugin);

