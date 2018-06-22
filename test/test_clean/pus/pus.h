/* This file was generated automatically: DO NOT MODIFY IT ! */

/* Declaration of the functions that have to be provided by the user */

#ifndef __USER_CODE_H_pus__
#define __USER_CODE_H_pus__

#include "C_ASN1_Types.h"

#ifdef __cplusplus
extern "C" {
#endif

void pus_startup();

void pus_PI_setImage(const asn1SccBase_samples_frame_Frame *);

void pus_PI_setCameraReport(const asn1SccT_UInt64 *);

void pus_PI_run();

extern void pus_RI_setFrameRequest(const asn1SccT_UInt64 *);

#ifdef __cplusplus
}
#endif


#endif
