cmd_/scratch/jbrown/2013.05-arm-linux-release/obj/linux-2013.05-24-arm-none-linux-gnueabi-i686-pc-linux-gnu/tmp-install/include/linux/usb/.install := perl scripts/headers_install.pl /scratch/jbrown/2013.05-arm-linux-release/obj/linux-2013.05-24-arm-none-linux-gnueabi-i686-pc-linux-gnu/tmp-install/include/linux/usb arm  /scratch/jbrown/2013.05-arm-linux-release/obj/linux-2013.05-24-arm-none-linux-gnueabi-i686-pc-linux-gnu/include/uapi/linux/usb/audio.h  /scratch/jbrown/2013.05-arm-linux-release/obj/linux-2013.05-24-arm-none-linux-gnueabi-i686-pc-linux-gnu/include/uapi/linux/usb/cdc.h  /scratch/jbrown/2013.05-arm-linux-release/obj/linux-2013.05-24-arm-none-linux-gnueabi-i686-pc-linux-gnu/include/uapi/linux/usb/ch11.h  /scratch/jbrown/2013.05-arm-linux-release/obj/linux-2013.05-24-arm-none-linux-gnueabi-i686-pc-linux-gnu/include/uapi/linux/usb/ch9.h  /scratch/jbrown/2013.05-arm-linux-release/obj/linux-2013.05-24-arm-none-linux-gnueabi-i686-pc-linux-gnu/include/uapi/linux/usb/functionfs.h  /scratch/jbrown/2013.05-arm-linux-release/obj/linux-2013.05-24-arm-none-linux-gnueabi-i686-pc-linux-gnu/include/uapi/linux/usb/g_printer.h  /scratch/jbrown/2013.05-arm-linux-release/obj/linux-2013.05-24-arm-none-linux-gnueabi-i686-pc-linux-gnu/include/uapi/linux/usb/gadgetfs.h  /scratch/jbrown/2013.05-arm-linux-release/obj/linux-2013.05-24-arm-none-linux-gnueabi-i686-pc-linux-gnu/include/uapi/linux/usb/midi.h  /scratch/jbrown/2013.05-arm-linux-release/obj/linux-2013.05-24-arm-none-linux-gnueabi-i686-pc-linux-gnu/include/uapi/linux/usb/tmc.h  /scratch/jbrown/2013.05-arm-linux-release/obj/linux-2013.05-24-arm-none-linux-gnueabi-i686-pc-linux-gnu/include/uapi/linux/usb/video.h ; for F in ; do echo "\#include <asm-generic/$$F>" > /scratch/jbrown/2013.05-arm-linux-release/obj/linux-2013.05-24-arm-none-linux-gnueabi-i686-pc-linux-gnu/tmp-install/include/linux/usb/$$F; done; touch /scratch/jbrown/2013.05-arm-linux-release/obj/linux-2013.05-24-arm-none-linux-gnueabi-i686-pc-linux-gnu/tmp-install/include/linux/usb/.install