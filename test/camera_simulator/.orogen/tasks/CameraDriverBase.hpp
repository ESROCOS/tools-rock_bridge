/* Generated from orogen/lib/orogen/templates/tasks/TaskBase.hpp */

#ifndef CAMERA_SIMULATOR_CAMERADRIVER_TASK_BASE_HPP
#define CAMERA_SIMULATOR_CAMERADRIVER_TASK_BASE_HPP

#include <string>
#include <boost/cstdint.hpp>
#include <rtt/TaskContext.hpp>

#include <rtt/Operation.hpp>
#include <rtt/Port.hpp>
#include <camera_simulator/TaskStates.hpp>


#include <orogen_metadata/Metadata.hpp>
extern template class RTT::Attribute< ::metadata::TaskContext >;

#include <boost/cstdint.hpp>
extern template class RTT::InputPort< boost::uint64_t >;
extern template class RTT::base::ChannelElement< boost::uint64_t >;
#include <base/samples/Frame.hpp>
extern template class RTT::OutputPort< ::base::samples::frame::Frame >;
extern template class RTT::base::ChannelElement< ::base::samples::frame::Frame >;
#include <boost/cstdint.hpp>
extern template class RTT::OutputPort< boost::uint64_t >;
extern template class RTT::base::ChannelElement< boost::uint64_t >;
#include <boost/cstdint.hpp>
extern template class RTT::OutputPort< boost::int32_t >;
extern template class RTT::base::ChannelElement< boost::int32_t >;



#include <boost/cstdint.hpp>
#include <boost/cstdint.hpp>
#include <string>





namespace camera_simulator{
    class CameraDriver;
    /** The oroGen-generated part of camera_simulator::CameraDriver
     *
     * It is used by oroGen and its plugins to define the task interfaces and set
     * up the component. Never edit yourself, as its content would be
     * overwritten at the next code generation.
     */
    class CameraDriverBase : public ::RTT::TaskContext
        
    {
    protected:
        // Common implementation of interface setup for both task constructors
        void setupComponentInterface();

        /* base implementation of the __orogen_getTID operation
         */
        virtual boost::int32_t __orogen_getTID();
        /* base implementation of the getModelName operation
         */
        virtual ::std::string getModelName();
        RTT::Attribute< ::metadata::TaskContext > _metadata;
        RTT::InputPort< boost::uint64_t > _command;
        RTT::Operation< boost::int32_t() > ___orogen_getTID;
        RTT::Operation< ::std::string() > _getModelName;
        RTT::OutputPort< ::base::samples::frame::Frame > _image;
        RTT::OutputPort< boost::uint64_t > _observation;
        RTT::OutputPort< boost::int32_t > _state;

    public:
        
        enum States
        {
            
                INIT = CameraDriver_INIT,
            
                PRE_OPERATIONAL = CameraDriver_PRE_OPERATIONAL,
            
                FATAL_ERROR = CameraDriver_FATAL_ERROR,
            
                EXCEPTION = CameraDriver_EXCEPTION,
            
                STOPPED = CameraDriver_STOPPED,
            
                RUNNING = CameraDriver_RUNNING,
            
                RUNTIME_ERROR = CameraDriver_RUNTIME_ERROR
            
        };
        

	CameraDriverBase(std::string const& name, TaskCore::TaskState initial_state);
	CameraDriverBase(std::string const& name, RTT::ExecutionEngine* engine, TaskCore::TaskState initial_state);
        ~CameraDriverBase();

        bool start();

        
        // Reimplement TaskCore base methods to export the states to the outside
        // world
        bool configure();
        bool recover();
        bool stop();
        bool cleanup();
        void error();
        void fatal();
        void exception();
        

        
        void report(States state);
        void state(States state);
        void error(States state);
        void fatal(States state);
        void exception(States state);
        States state() const;
        

        bool startHook();
    };

}


#endif

