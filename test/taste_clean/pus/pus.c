/* User code: This file will not be overwritten by TASTE. */

#include "pus.h"
#include <stdio.h>

void pus_startup()
{
    /* Write your initialization code here,
       but do not make any call to a required interface. */
    printf("- TASTE: pus_startup\n");
}

void pus_PI_setImage(const asn1SccBase_samples_frame_Frame *IN_image)
{
    /* Write your code here! */
    printf(" - TASTE: pus_PI_setImage, image received\n");
}

void pus_PI_setCameraReport(const asn1SccT_UInt64 *IN_errorCode)
{
    /* Write your code here! */
    printf(" - TASTE: pus_PI_setCameraReport, report received\n");
}

void pus_PI_run()
{
    /* Write your code here! */
    printf(" - TASTE: pus_PI_run, requesting a frame\n");
    asn1SccT_UInt64 a = 1;
    pus_RI_setFrameRequest(&a);
}

