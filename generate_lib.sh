TASTE_PATH="/home/esrocos/esrocos_workspace/tools/rock_bridge.toDelete/taste-example/camera-taste"


cd $TASTE_PATH/binary.c/auto-src_PLATFORM_NATIVE/; gcc -I. -I"$TASTE_PATH/binary.c/GlueAndBuild/deploymentview_final/x86_partition/../polyorb-hi-c/include" "-I$TASTE_PATH/binary.c/GlueAndBuild"  -DTARGET=native -DPOSIX -D_POSIX_SOURCE -D_GNU_SOURCE  -g -D__PO_HI_USE_VCD=1 -fPIC -I . -DSTATIC=""  -g -Wall -Wextra -fdiagnostics-show-option -Wcast-align -Wswitch-enum -D__PO_HI_USE_TRANSPORT -c -o $TASTE_PATH/binary.c/camera_rock_bridge/camera_rock_bridge/C_ASN1_Types.o $TASTE_PATH/binary.c/GlueAndBuild/gluecamera_rock_bridge/C_ASN1_Types.c

cd $TASTE_PATH/binary.c/GlueAndBuild/deploymentview_final/x86_partition/; objcopy --redefine-sym main=init_taste main.o

cd $TASTE_PATH/binary.c/GlueAndBuild/deploymentview_final/x86_partition/; gcc -fPIC -pie -shared -o libx86_partition.so -lrt $TASTE_PATH/binary.c/auto-src_PLATFORM_NATIVE/*.o /$TASTE_PATH/binary.c/camera_rock_bridge/camera_rock_bridge/*.o $TASTE_PATH/binary.c/pus/pus/*.o $TASTE_PATH/binary.c/x86_partition_taste_api/*.o $TASTE_PATH/binary.c/vt_pus_setcameraobservations/*.o $TASTE_PATH/binary.c/vt_pus_run/*.o  po_hi_task.o po_hi_time.o po_hi_protected.o po_hi_main.o po_hi_messages.o po_hi_marshallers.o po_hi_giop.o po_hi_utils.o po_hi_types.o po_hi_monitor.o po_hi_storage.o po_hi_gqueue.o drivers/po_hi_driver_exarm.o drivers/po_hi_driver_keyboard.o drivers/po_hi_driver_exarm_ni_6071e_analog.o drivers/po_hi_driver_exarm_ni_6071e_digital.o drivers/po_hi_driver_usbbrick_spacewire.o drivers/po_hi_driver_linux_serial.o drivers/po_hi_driver_leon_serial.o drivers/po_hi_driver_leon_eth.o drivers/po_hi_driver_serial_common.o drivers/po_hi_driver_sockets.o drivers/po_hi_driver_rtems_ne2000.o drivers/po_hi_driver_rasta_serial.o drivers/po_hi_driver_rasta_common.o drivers/po_hi_driver_rasta_1553.o drivers/po_hi_driver_xc4v_fpga.o drivers/po_hi_driver_rasta_1553_brmlib.o drivers/po_hi_driver_rasta_spacewire.o  po_hi_transport.o   activity.o subprograms.o types.o request.o marshallers.o deployment.o naming.o main.o  -lpthread -lrt -lm  -g -lm -lpthread -lrt -lstdc++ 

cp $TASTE_PATH/binary.c/GlueAndBuild/deploymentview_final/x86_partition/libx86_partition.so $AUTOPROJ_CURRENT_ROOT/install/lib/libx86_partition.so

