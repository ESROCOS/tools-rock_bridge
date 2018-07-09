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

def includesType():
	a = ""
	for i in iv.list_ri(tasteFunc):
		if iv.get_in_param_type_idx(tasteFunc, i, 0) not in basicTypes.keys():
			a = a + "#include <base_support/" + iv.get_in_param_type_idx(tasteFunc, i, 0).replace("_", "-") + "Convert.hpp>\n"
		
	return a
%>

/* User code: This file will not be overwritten by TASTE. */

#include "${tasteFunc}.h"
#include <stdio.h>

${includesType()}

#include "${tasteFunc}/${tasteFunc}_task.hpp"

extern ${tasteFunc}::${tasteFunc}_task * ${tasteFunc}_task_instance;


%for i in iv.list_pi(tasteFunc):
void ${tasteFunc}_PI_${i}(const asn1Scc${iv.get_in_param_type_idx(tasteFunc, i, 0)}  *IN_${iv.get_in_param_idx(tasteFunc, i, 0)})
{
	if(${tasteFunc}_task_instance != NULL)
	{
		${taste2CRockType(iv.get_in_param_type_idx(tasteFunc, i, 0))} varRock;

		%if iv.get_in_param_type_idx(tasteFunc, i, 0) in basicTypes.keys():
		varRock = *IN_${iv.get_in_param_idx(tasteFunc, i, 0)};
		%else:
		asn1Scc${iv.get_in_param_type_idx(tasteFunc, i, 0)}_fromAsn1(varRock, *IN_${iv.get_in_param_idx(tasteFunc, i, 0)});
		%endif

		${tasteFunc}_task_instance->write${i.capitalize()}(varRock);
	}
}
%endfor

%for i in iv.list_ri(tasteFunc):
extern void (*ptr_RI_aux_${i})(${taste2CRockType(iv.get_in_param_type_idx(tasteFunc, i, 0))} *);
void ${tasteFunc}_RI_aux_${i}(${taste2CRockType(iv.get_in_param_type_idx(tasteFunc, i, 0))} * var${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()})
{
		// convert type
		asn1Scc${iv.get_in_param_type_idx(tasteFunc, i, 0)} asn1${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()};
		%if iv.get_in_param_type_idx(tasteFunc, i, 0) in basicTypes.keys():
		asn1${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()} = *var${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()};
		%else:
		asn1Scc${iv.get_in_param_type_idx(tasteFunc, i, 0)}_toAsn1(asn1${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()}, *var${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()});
		%endif
		// function RI TASTE
		${tasteFunc}_RI_${i}(&asn1${iv.get_in_param_idx(tasteFunc, i, 0).capitalize()});
}
%endfor

void ${tasteFunc}_startup()
{
    /* Write your initialization code here,
       but do not make any call to a required interface. */
    printf("Hello from ${tasteFunc}_startup\n");
	%for i in iv.list_ri(tasteFunc):
	ptr_RI_aux_${i} = ${tasteFunc}_RI_aux_${i};
	%endfor
}
