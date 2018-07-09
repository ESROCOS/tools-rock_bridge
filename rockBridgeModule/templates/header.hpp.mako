/*
 * H2020 ESROCOS Project
 * Company: GMV Aerospace & Defence S.A.U.
 * Licence: GPLv2
*/


<%
basicTypes = {'T_Boolean': 'bool', 'T_UInt8': 'uint8_t', 'T_UInt16': 'uint16_t', 'T_UInt32': 'uint32_t', 'T_UInt64': 'uint64_t', 'T_Int8': 'int8_t', 'T_Int16': 'int16_t', 'T_Int32': 'int32_t', 'T_Int64': 'int64_t', 'T_Double': 'double', 'T_Float': 'float', 'T_String': 'std/string'}

def taste2CRockType(type):
	if type in basicTypes.keys():
		return basicTypes[type]
	else:
		type = type[:1].lower() + type[1:]
		return type.replace("_", "::")
%>
/* Generated from orogen/lib/orogen/templates/tasks/Task.hpp, modified by tools/rock_bridge */

//JMSM

#ifndef ${tasteFunc.upper()}_${tasteFunc.upper()}_TASK_TASK_HPP
#define ${tasteFunc.upper()}_${tasteFunc.upper()}_TASK_TASK_HPP

#include "${tasteFunc}/${tasteFunc}_taskBase.hpp"

namespace ${tasteFunc}{

    /*! \class ${tasteFunc}_task
     * \brief The task context provides and requires services. It uses an ExecutionEngine to perform its functions.
     * Essential interfaces are operations, data flow ports and properties. These interfaces have been defined using the oroGen specification.
     * In order to modify the interfaces you should (re)use oroGen and rely on the associated workflow.
     * 
     * \details
     * The name of a TaskContext is primarily defined via:
     \verbatim
     deployment 'deployment_name'
         task('custom_task_name','${tasteFunc}::${tasteFunc}_task')
     end
     \endverbatim
     *  It can be dynamically adapted when the deployment is called with a prefix argument.
     */
    class ${tasteFunc}_task : public ${tasteFunc}_taskBase
    {
	friend class ${tasteFunc}_taskBase;
    protected:



    public:
        /** TaskContext constructor for ${tasteFunc}_task
         * \param name Name of the task. This name needs to be unique to make it identifiable via nameservices.
         * \param initial_state The initial TaskState of the TaskContext. Default is Stopped state.
         */
        ${tasteFunc}_task(std::string const& name = "${tasteFunc}::${tasteFunc}_task", TaskCore::TaskState initial_state = Stopped);

        /** TaskContext constructor for ${tasteFunc}_task
         * \param name Name of the task. This name needs to be unique to make it identifiable for nameservices.
         * \param engine The RTT Execution engine to be used for this task, which serialises the execution of all commands, programs, state machines and incoming events for a task.
         * \param initial_state The initial TaskState of the TaskContext. Default is Stopped state.
         */
        ${tasteFunc}_task(std::string const& name, RTT::ExecutionEngine* engine, TaskCore::TaskState initial_state = Stopped);

        /** Default deconstructor of ${tasteFunc}_task
         */
		~${tasteFunc}_task();

        /** This hook is called by Orocos when the state machine transitions
         * from PreOperational to Stopped. If it returns false, then the
         * component will stay in PreOperational. Otherwise, it goes into
         * Stopped.
         *
         * It is meaningful only if the #needs_configuration has been specified
         * in the task context definition with (for example):
         \verbatim
         task_context "TaskName" do
           needs_configuration
           ...
         end
         \endverbatim
         */
        bool configureHook();

        /** This hook is called by Orocos when the state machine transitions
         * from Stopped to Running. If it returns false, then the component will
         * stay in Stopped. Otherwise, it goes into Running and updateHook()
         * will be called.
         */
        bool startHook();

        /** This hook is called by Orocos when the component is in the Running
         * state, at each activity step. Here, the activity gives the "ticks"
         * when the hook should be called.
         *
         * The error(), exception() and fatal() calls, when called in this hook,
         * allow to get into the associated RunTimeError, Exception and
         * FatalError states.
         *
         * In the first case, updateHook() is still called, and recover() allows
         * you to go back into the Running state.  In the second case, the
         * errorHook() will be called instead of updateHook(). In Exception, the
         * component is stopped and recover() needs to be called before starting
         * it again. Finally, FatalError cannot be recovered.
         */
        void updateHook();

        /** This hook is called by Orocos when the component is in the
         * RunTimeError state, at each activity step. See the discussion in
         * updateHook() about triggering options.
         *
         * Call recover() to go back in the Runtime state.
         */
        void errorHook();

        /** This hook is called by Orocos when the state machine transitions
         * from Running to Stopped after stop() has been called.
         */
        void stopHook();

        /** This hook is called by Orocos when the state machine transitions
         * from Stopped to PreOperational, requiring the call to configureHook()
         * before calling start() again.
         */
        void cleanupHook();
        
        %for i in iv.list_pi(tasteFunc):
		void write${i.capitalize()}(${taste2CRockType(iv.get_in_param_type_idx(tasteFunc, i, 0))} var);
				
		%endfor
    };
}

#endif
