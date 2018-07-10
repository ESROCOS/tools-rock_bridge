## H2020 ESROCOS Project
## Company: GMV Aerospace & Defence S.A.U.
## Licence: GPLv2
##
## Mako template to generate the TASTE function implementation for a ROCK bridge component.
##
<% import os %>\
/* Generated from ${os.path.basename(context._with_template.uri)} */
/* User code: This file will not be overwritten by TASTE. */

#include "${tasteFunc}.h"
#include <stdio.h>

#include "${tasteFunc}/${tasteFunc}_task.hpp"

extern ${tasteFunc}::${tasteFunc}_task * ${tasteFunc}_task_instance;


void ${tasteFunc}_startup()
{
    /* Write your initialization code here,
       but do not make any call to a required interface. */
    printf("Hello from ${tasteFunc}_startup\n");
}

%for i in iv.list_pi(tasteFunc):
void ${tasteFunc}_PI_${i}(const asn1Scc${iv.get_in_param_type_idx(tasteFunc, i, 0)}  *IN_${iv.get_in_param_idx(tasteFunc, i, 0)})
{
    if(${tasteFunc}_task_instance != NULL)
    {
        ${tasteFunc}_task_instance->write${i.capitalize()}(*IN_${iv.get_in_param_idx(tasteFunc, i, 0)});
    }
}
%endfor


