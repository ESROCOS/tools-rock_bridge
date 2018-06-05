<%
basicTypes = {'T_Boolean': 'bool', 'T_UInt8': 'uint8_t', 'T_UInt16': 'uint16_t', 'T_UInt32': 'uint32_t', 'T_UInt64': 'uint64_t', 'T_Int8': 'int8_t', 'T_Int16': 'int16_t', 'T_Int32': 'int32_t', 'T_Int64': 'int64_t', 'T_Double': 'double', 'T_Float': 'float', 'T_String': 'std/string'}

def taste2CRockType(type):
	if type in basicTypes.keys():
		return basicTypes[type]
	else:
		type = type[:1].lower() + type[1:]
		return type.replace("_", "::")

def includesType():
	a = ""
	for i in iv.list_ri(tasteFunc):
		if iv.get_in_param_type_idx(tasteFunc, i, 0) not in basicTypes.keys():
			a = "#include <base_support/" + iv.get_in_param_type_idx(tasteFunc, i, 0).replace("_", "-") + "Convert.hpp>\n"
		
	return a
%>
/* Generated from orogen/lib/orogen/templates/tasks/Task.cpp */

//JMSM


#include "${tasteFunc}_task.hpp"



${includesType()}

//#include <${tasteFunc}.h> //include TASTE function header
#include <thread>


camera_rock_bridge::camera_rock_bridge_task * ${tasteFunc}_task_instance;

extern "C" { 
	extern int init_taste(void);
	
	%for i in iv.list_ri(tasteFunc):
	extern void ${tasteFunc}_RI_${i}(const asn1Scc${iv.get_in_param_type_idx(tasteFunc, i, 0)} *);
	%endfor
}

using namespace ${tasteFunc};

void load_taste()
{
	init_taste();
}


${tasteFunc}_task::${tasteFunc}_task(std::string const& name, TaskCore::TaskState initial_state)
    : ${tasteFunc}_taskBase(name, initial_state)
{	
	${tasteFunc}_task_instance = this;

	std::thread (load_taste).detach();
}

${tasteFunc}_task::${tasteFunc}_task(std::string const& name, RTT::ExecutionEngine* engine, TaskCore::TaskState initial_state)
    : ${tasteFunc}_taskBase(name, engine, initial_state)
{
	${tasteFunc}_task_instance = this;

	std::thread (load_taste).detach();
}

${tasteFunc}_task::~${tasteFunc}_task()
{
}



/// The following lines are template definitions for the various state machine
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
		// convert type
		asn1Scc${iv.get_in_param_type_idx(tasteFunc, i, 0)} asn1${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()};
		%if iv.get_in_param_type_idx(tasteFunc, i, 0) in basicTypes.keys():
		asn1${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()} = var${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()};
		%else:
		asn1Scc${iv.get_in_param_type_idx(tasteFunc, i, 0)}_toAsn1(asn1${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()}, var${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()});
		%endif
		// function RI TASTE
		${tasteFunc}_RI_${i}(&asn1${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()});
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
void ${tasteFunc}_task::write${i.capitalize()}(asn1Scc${iv.get_in_param_type_idx(tasteFunc, i, 0)} var)
{
	${taste2CRockType(iv.get_in_param_type_idx(tasteFunc, i, 0))} varRock;

	%if iv.get_in_param_type_idx(tasteFunc, i, 0) in basicTypes.keys():
	varRock = var;
	%else:
	asn1Scc${iv.get_in_param_type_idx(tasteFunc, i, 0)}_fromAsn1(varRock, var);
	%endif

	_${i}.write(varRock);
}
	
%endfor

