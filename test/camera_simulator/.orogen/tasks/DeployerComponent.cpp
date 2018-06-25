#include <rtt/Component.hpp>

#include <camera_simulator/CameraDriver.hpp>

ORO_CREATE_COMPONENT_TYPE();
ORO_LIST_COMPONENT_TYPE( camera_simulator::CameraDriver );

namespace orogen
{
    RTT::TaskContext* create_camera_simulator__CameraDriver(std::string const& instance_name)
    {
        return new camera_simulator::CameraDriver(instance_name);
    }
}
