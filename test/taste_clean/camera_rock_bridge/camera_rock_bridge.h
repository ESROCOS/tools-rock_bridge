/* This file was generated automatically: DO NOT MODIFY IT ! */

/* Declaration of the functions that have to be provided by the user */

#ifndef __USER_CODE_H_camera_rock_bridge__
#define __USER_CODE_H_camera_rock_bridge__

#include "C_ASN1_Types.h"

#ifdef __cplusplus
extern "C" {
#endif

void camera_rock_bridge_startup();

void camera_rock_bridge_PI_setFrameRequest(const asn1SccT_UInt64 *);

extern void camera_rock_bridge_RI_setImage(const asn1SccBase_samples_frame_Frame *);

extern void camera_rock_bridge_RI_setCameraReport(const asn1SccT_UInt64 *);

#ifdef __cplusplus
}
#endif


#endif
