# H2020 ESROCOS Project
# Company: GMV Aerospace & Defence S.A.U.
# Licence: GPLv2


<%
basicTypes = {'T_Boolean': 'bool', 'T_UInt8': 'uint8_t', 'T_UInt16': 'uint16_t', 'T_UInt32': 'uint32_t', 'T_UInt64': 'uint64_t', 'T_Int8': 'int8_t', 'T_Int16': 'int16_t', 'T_Int32': 'int32_t', 'T_Int64': 'int64_t', 'T_Double': 'double', 'T_Float': 'float', 'T_String': 'std/string'}

def taste2RockType(type):
	if type in basicTypes.keys():
		return basicTypes[type]
	else:
		type = type[:1].lower() + type[1:]
		return type.replace("_", "/")
%>
name "${tasteFunc}"

import_types_from "base"
import_types_from "std"

task_context "${tasteFunc}_task" do

%for i in iv.list_ri(tasteFunc):
	input_port "${i}", "${taste2RockType(iv.get_in_param_type_idx(tasteFunc, i, 0))}"
%endfor
	
%for i in iv.list_pi(tasteFunc):
	output_port "${i}", "${taste2RockType(iv.get_in_param_type_idx(tasteFunc, i, 0))}"
%endfor
	
%for i in iv.list_ri(tasteFunc):
	port_driven "${i}"
%endfor

end


