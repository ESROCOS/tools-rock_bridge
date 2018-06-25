/* Generated from orogen/lib/orogen/templates/tasks/TAskBase.cpp */

#include "tasks//CameraDriverBase.hpp"

using namespace camera_simulator;



#ifdef HAS_GETTID
#include <sys/syscall.h>
#endif
 

CameraDriverBase::CameraDriverBase(std::string const& name, TaskCore::TaskState state)
    : ::RTT::TaskContext(name, state)
, _metadata("metadata")
    , _command("command")
    , ___orogen_getTID("__orogen_getTID", &CameraDriverBase::__orogen_getTID, this, RTT::OwnThread)
    , _getModelName("getModelName", &CameraDriverBase::getModelName, this, RTT::ClientThread)
    , _image("image")
    , _observation("observation")
    , _state("state"){
    setupComponentInterface();
}

CameraDriverBase::CameraDriverBase(std::string const& name, RTT::ExecutionEngine* engine, TaskCore::TaskState state)
    : ::RTT::TaskContext(name, engine, state)
, _metadata("metadata")
    , _command("command")
    , ___orogen_getTID("__orogen_getTID", &CameraDriverBase::__orogen_getTID, this, RTT::OwnThread)
    , _getModelName("getModelName", &CameraDriverBase::getModelName, this, RTT::ClientThread)
    , _image("image")
    , _observation("observation")
    , _state("state"){
    setupComponentInterface();
}

CameraDriverBase::~CameraDriverBase()
{

}

void CameraDriverBase::setupComponentInterface()
{
    attributes()->addAttribute( _metadata );
    ports()->addEventPort(_command);
    provides()->addOperation( ___orogen_getTID)
        .doc("returns the PID for this task");
    provides()->addOperation( _getModelName)
        .doc("returns the oroGen model name for this task");
    _image.keepLastWrittenValue(false);
    _image.keepNextWrittenValue(true);
    _observation.keepLastWrittenValue(false);
    _observation.keepNextWrittenValue(true);
    _state.keepLastWrittenValue(false);
    _state.keepNextWrittenValue(true);
    ports()->addPort(_image);
    ports()->addPort(_observation);
    ports()->addPort(_state);
    metadata::TaskContext md;
    _metadata.set(md);

    
    _state.keepLastWrittenValue(true);
    _state.write(getTaskState());
    
}

boost::int32_t CameraDriverBase::__orogen_getTID()
{
    #ifdef HAS_GETTID
return syscall(SYS_gettid);
#else
return 0;
#endif
}
::std::string CameraDriverBase::getModelName()
{
    return "camera_simulator::CameraDriver";
}

void CameraDriverBase::report(States state)
{
    _state.write(state);
}
void CameraDriverBase::state(States state)
{
    _state.write(state);
}
void CameraDriverBase::error(States state)
{
    _state.write(state);
    TaskContext::error();
}
void CameraDriverBase::exception(States state)
{
    _state.write(state);
    TaskContext::exception();
}
void CameraDriverBase::fatal(States state)
{
    _state.write(state);
    TaskContext::fatal();
}
CameraDriverBase::States CameraDriverBase::state() const
{
    return static_cast<CameraDriverBase::States>(_state.getLastWrittenValue());
}

struct StateExporter
{
    RTT::TaskContext const& task;
    RTT::OutputPort<boost::int32_t>&   port;

    StateExporter(RTT::TaskContext const& task, RTT::OutputPort<int>& port)
        : task(task), port(port) {}
    ~StateExporter()
    {
        port.write(task.getTaskState());
    }
};

bool CameraDriverBase::start()
{
    StateExporter exporter(*this, _state);
    bool started = RTT::TaskContext::start();
    if (!started)
        return false;

    
    _command.clear();
    
    return true;
}

bool CameraDriverBase::configure()
{
    StateExporter exporter(*this, _state);
    return RTT::TaskContext::configure();
}
bool CameraDriverBase::recover()
{
    StateExporter exporter(*this, _state);
    return RTT::TaskContext::recover();
}
bool CameraDriverBase::stop()
{
    StateExporter exporter(*this, _state);
    return RTT::TaskContext::stop();
}
bool CameraDriverBase::cleanup()
{
    StateExporter exporter(*this, _state);
    return RTT::TaskContext::cleanup();
}
void CameraDriverBase::fatal()
{ return fatal(FATAL_ERROR); }
void CameraDriverBase::error()
{ return error(RUNTIME_ERROR); }
void CameraDriverBase::exception()
{ return exception(EXCEPTION); }

bool CameraDriverBase::startHook()
{
    
    if (! ::RTT::TaskContext::startHook())
        return false;
    

    
        
_command.clear();        
    

    
    return true;
    
}


