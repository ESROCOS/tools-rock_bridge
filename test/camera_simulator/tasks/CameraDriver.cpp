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

    printf(" - CameraDriver::updateHook\n");

    uint64_t var;
	if( RTT::NoData !=  _command.read(var))
	{
		printf(" - CameraDriver: frame resquest received\n");
		
        base::samples::frame::Frame aux(4, 4);
        std::vector< uint8_t > vec;
        
        for(int i = 0; i < (aux.getWidth() * aux.getHeight()); i++)
            vec.push_back(25);
                
        aux.setImage(vec);
   

		printf(" - CameraDriver: generating image: -");
		std::vector<uint8_t> vec2 = aux.getImage();
		for (int i = 0; i < 10; i++)
			printf("%u ", vec2[i]);
		printf("- size: %lu, sizeof %lu\n", vec2.size(), sizeof(aux));
  
        printf(" - CameraDriver: sending \n");
		_image.write(aux);
    }
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
