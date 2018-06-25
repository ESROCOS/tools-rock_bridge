/* Generated from orogen/lib/orogen/templates/tasks/Task.cpp */

#include "CameraDriver.hpp"

using namespace camera_simulator;

CameraDriver::CameraDriver(std::string const& name, TaskCore::TaskState initial_state)
    : CameraDriverBase(name, initial_state)
{
}

CameraDriver::CameraDriver(std::string const& name, RTT::ExecutionEngine* engine, TaskCore::TaskState initial_state)
    : CameraDriverBase(name, engine, initial_state)
{
}

CameraDriver::~CameraDriver()
{
}



/// The following lines are template definitions for the various state machine
// hooks defined by Orocos::RTT. See CameraDriver.hpp for more detailed
// documentation about them.

bool CameraDriver::configureHook()
{
    if (! CameraDriverBase::configureHook())
        return false;
    return true;
}
bool CameraDriver::startHook()
{
    if (! CameraDriverBase::startHook())
        return false;
    return true;
}
void CameraDriver::updateHook()
{
    CameraDriverBase::updateHook();
}
void CameraDriver::errorHook()
{
    CameraDriverBase::errorHook();
}
void CameraDriver::stopHook()
{
    CameraDriverBase::stopHook();
}
void CameraDriver::cleanupHook()
{
    CameraDriverBase::cleanupHook();
}
