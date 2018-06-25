/* User code: This file will not be overwritten by TASTE. */

#include "camera_rock_bridge.h"

#include <stdio.h>

void camera_rock_bridge_startup()
{
    /* Write your initialization code here,
       but do not make any call to a required interface. */
    printf("camera_rock_bridge_startup\n");
}

void camera_rock_bridge_PI_setFrameRequest(const asn1SccT_UInt64 * IN_A)
{
    /* Write your code here! */
    printf("camera_rock_bridge_PI_setFrameRequest\n");
}

