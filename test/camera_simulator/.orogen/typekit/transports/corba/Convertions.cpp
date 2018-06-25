/* Generated from orogen/lib/orogen/templates/typekit/corba/Convertions.cpp */

#include "camera_simulator/transports/corba/camera_simulatorTypesC.h"
#include <memory>
// for error-messages in enum-converters "toCORBA()" and "fromCORBA()"
#include <rtt/Logger.hpp>




#include <camera_simulator/TaskStates.hpp>

namespace orogen_typekits {
    bool toCORBA( orogen::camera_simulator::Corba::CameraDriver_STATES& corba, ::camera_simulator::CameraDriver_STATES const& value );
    bool fromCORBA( ::camera_simulator::CameraDriver_STATES& value, orogen::camera_simulator::Corba::CameraDriver_STATES const& corba );
    bool toCORBA( orogen::camera_simulator::Corba::CameraDriver_STATES& corba, ::camera_simulator::CameraDriver_STATES const& value );
    bool fromCORBA( ::camera_simulator::CameraDriver_STATES& value, orogen::camera_simulator::Corba::CameraDriver_STATES const& corba );
}

bool orogen_typekits::toCORBA( orogen::camera_simulator::Corba::CameraDriver_STATES& corba, ::camera_simulator::CameraDriver_STATES const& value ){
    switch(value) {
      case ::camera_simulator::CameraDriver_EXCEPTION:
        corba = orogen::camera_simulator::Corba::CameraDriver_EXCEPTION;
        break;
      case ::camera_simulator::CameraDriver_FATAL_ERROR:
        corba = orogen::camera_simulator::Corba::CameraDriver_FATAL_ERROR;
        break;
      case ::camera_simulator::CameraDriver_INIT:
        corba = orogen::camera_simulator::Corba::CameraDriver_INIT;
        break;
      case ::camera_simulator::CameraDriver_PRE_OPERATIONAL:
        corba = orogen::camera_simulator::Corba::CameraDriver_PRE_OPERATIONAL;
        break;
      case ::camera_simulator::CameraDriver_RUNNING:
        corba = orogen::camera_simulator::Corba::CameraDriver_RUNNING;
        break;
      case ::camera_simulator::CameraDriver_RUNTIME_ERROR:
        corba = orogen::camera_simulator::Corba::CameraDriver_RUNTIME_ERROR;
        break;
      case ::camera_simulator::CameraDriver_STOPPED:
        corba = orogen::camera_simulator::Corba::CameraDriver_STOPPED;
        break;
      default:
        RTT::log(RTT::Error) << "orogen_typekits::toCORBA() invalid value '" << (int)value << "' for enum '::camera_simulator::CameraDriver_STATES'" << RTT::endlog();
        return false;
    }

    return true;
}

bool orogen_typekits::fromCORBA( ::camera_simulator::CameraDriver_STATES& value, orogen::camera_simulator::Corba::CameraDriver_STATES const& corba ){
    switch(corba) {
      case orogen::camera_simulator::Corba::CameraDriver_EXCEPTION:
        value = ::camera_simulator::CameraDriver_EXCEPTION;
        break;
      case orogen::camera_simulator::Corba::CameraDriver_FATAL_ERROR:
        value = ::camera_simulator::CameraDriver_FATAL_ERROR;
        break;
      case orogen::camera_simulator::Corba::CameraDriver_INIT:
        value = ::camera_simulator::CameraDriver_INIT;
        break;
      case orogen::camera_simulator::Corba::CameraDriver_PRE_OPERATIONAL:
        value = ::camera_simulator::CameraDriver_PRE_OPERATIONAL;
        break;
      case orogen::camera_simulator::Corba::CameraDriver_RUNNING:
        value = ::camera_simulator::CameraDriver_RUNNING;
        break;
      case orogen::camera_simulator::Corba::CameraDriver_RUNTIME_ERROR:
        value = ::camera_simulator::CameraDriver_RUNTIME_ERROR;
        break;
      case orogen::camera_simulator::Corba::CameraDriver_STOPPED:
        value = ::camera_simulator::CameraDriver_STOPPED;
        break;
      default:
        RTT::log(RTT::Error) << "orogen_typekits::fromCORBA() invalid value '" << (int)corba << "' for enum '::camera_simulator::CameraDriver_STATES'" << RTT::endlog();
        return false;
    }

    return true;
}


