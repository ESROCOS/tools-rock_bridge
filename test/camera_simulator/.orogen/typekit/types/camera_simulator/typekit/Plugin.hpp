/* Generated from orogen/lib/orogen/templates/typekit/Plugin.hpp */

#ifndef __OROGEN_GENERATED_CAMERA_SIMULATOR_TYPEKIT_HPP
#define __OROGEN_GENERATED_CAMERA_SIMULATOR_TYPEKIT_HPP

#include <rtt/types/TypekitPlugin.hpp>

namespace Typelib {
    class Registry;
}

namespace orogen_typekits {
    class camera_simulatorTypekitPlugin
        : public RTT::types::TypekitPlugin
    {
        Typelib::Registry* m_registry;

    public:
        camera_simulatorTypekitPlugin();
        ~camera_simulatorTypekitPlugin();
        bool loadTypes();
        bool loadOperators();
        bool loadConstructors();
        std::string getName();
    };

    extern camera_simulatorTypekitPlugin camera_simulatorTypekit;
}

#endif


