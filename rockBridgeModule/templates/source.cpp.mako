## H2020 ESROCOS Project
## Company: GMV Aerospace & Defence S.A.U.
## Licence: GPLv2
##
## Mako template to generate the Orocos task source file for a ROCK bridge component.
##
<% import os %>\
/* Generated from ${os.path.basename(context._with_template.uri)} */
/* Derived from orogen/lib/orogen/templates/tasks/Task.cpp */
<%
basicTypes = {'T_Boolean': 'bool', 'T_UInt8': 'uint8_t', 'T_UInt16': 'uint16_t', 'T_UInt32': 'uint32_t', 'T_UInt64': 'uint64_t', 'T_Int8': 'int8_t', 'T_Int16': 'int16_t', 'T_Int32': 'int32_t', 'T_Int64': 'int64_t', 'T_Double': 'double', 'T_Float': 'float', 'T_String': 'std/string'}

def taste2CRockType(type):
    if type in basicTypes.keys():
        return basicTypes[type]
    else:
        type = type[:1].lower() + type[1:]
        return type.replace("_", "::")
%>

#include "${tasteFunc}_task.hpp"


#include <thread>

camera_rock_bridge::camera_rock_bridge_task * ${tasteFunc}_task_instance = NULL;
    
%for i in iv.list_ri(tasteFunc):
void (*ptr_RI_aux_${i})(${taste2CRockType(iv.get_in_param_type_idx(tasteFunc, i, 0))} *);
%endfor

extern "C" { 
    extern int aadl_start(void);
}

using namespace ${tasteFunc};

void load_taste()
{
    aadl_start();
}


${tasteFunc}_task::${tasteFunc}_task(std::string const& name, TaskCore::TaskState initial_state)
    : ${tasteFunc}_taskBase(name, initial_state)
{    
    if(${tasteFunc}_task_instance == NULL)
    {
        ${tasteFunc}_task_instance = this;
    }
    
    std::thread (load_taste).detach();
}

${tasteFunc}_task::${tasteFunc}_task(std::string const& name, RTT::ExecutionEngine* engine, TaskCore::TaskState initial_state)
    : ${tasteFunc}_taskBase(name, engine, initial_state)
{
    if(${tasteFunc}_task_instance == NULL)
    {
        ${tasteFunc}_task_instance = this;
    }

    std::thread (load_taste).detach();
}

${tasteFunc}_task::~${tasteFunc}_task()
{
}



// The following lines are template definitions for the various state machine
// hooks defined by Orocos::RTT. See ${tasteFunc}_task.hpp for more detailed
// documentation about them.

bool ${tasteFunc}_task::configureHook()
{
    if (! ${tasteFunc}_taskBase::configureHook())
        return false;
    return true;
}
bool ${tasteFunc}_task::startHook()
{
    if (! ${tasteFunc}_taskBase::startHook())
        return false;
    return true;
}
void ${tasteFunc}_task::updateHook()
{
    ${tasteFunc}_taskBase::updateHook();
    
    %for i in iv.list_ri(tasteFunc):
    ${taste2CRockType(iv.get_in_param_type_idx(tasteFunc, i, 0))} var${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()};
    if( RTT::NewData ==  _${i}.read(var${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()}))
    {
        if(ptr_RI_aux_${i} != NULL)
        {
            ptr_RI_aux_${i}(&var${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()});
        }
    }
    
    %endfor
}
void ${tasteFunc}_task::errorHook()
{
    ${tasteFunc}_taskBase::errorHook();
}
void ${tasteFunc}_task::stopHook()
{
    ${tasteFunc}_taskBase::stopHook();
}
void ${tasteFunc}_task::cleanupHook()
{
    ${tasteFunc}_taskBase::cleanupHook();
}

%for i in iv.list_pi(tasteFunc):
void ${tasteFunc}_task::write${i.capitalize()}(${taste2CRockType(iv.get_in_param_type_idx(tasteFunc, i, 0))} var)
{
    _${i}.write(var);
}
%endfor

