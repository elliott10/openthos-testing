#!/bin/bash -x

ip_linux="192.168.2.82"
ip_android="192.168.2.58"
android_iso_for_test="/root/android_x86.iso_xly_5.1"
diskpart_for_android="/dev/sda40"


####this line can  be annotation 
##read -p "please input the ip_linux:" ip_linux
echo ${ip_linux}

###copy  the android iso you want to test , to this dir

cp  ${android_iso_for_test}  ./android_x86.iso


####a small bug has fixed
ssh root@${ip_linux} "rm -rf /root/android_auto/"
####a small bug has fixed

./android_tool.sh ${ip_linux}  partition_disk.sh ${diskpart_for_android}

###after partion_disk.sh need not reboot to mkfs.ext4
##./android_tool.sh ${ip_linux}  fastboot.sh  ${diskpart_for_android}  reboot_bootloader


./android_tool.sh ${ip_linux}  android_x86_iso_install.sh ${diskpart_for_android} 

./android_tool.sh ${ip_linux}  android_x86_grub_install.py ${diskpart_for_android} 

./android_tool.sh ${ip_linux}  fastboot.sh  ${diskpart_for_android}  bios_reboot 



###when  the android  boot success?
##test ip  reacheable
###
#while  1
#ping  ip_android
#if ok 
#then break 

sleep 180

#read -p "please input the ip_android:" ip_android
####pause press anykey to continue
echo ${ip_android}


./adb connect ${ip_android}

sleep 3


#./adb install ./fndxn2_yoyou.com.apk
./adb install ./net.jishigou.t2.8.0.apk

sleep 3

./adb shell am start -n net.jishigou.t/net.jishigou.t.StartActivity

#./adb push  ./xxx/x   /x/x/x/
#./adb shell /x/x/x/x
#mkdir ./test_result
#./adb pull  ./xxx/*  ./test_result

#tar zcvf ./test_result ./test_result.tar.gz  #通过web下载测试用例。
#rm -rf ./test_result
sleep 10


###reboot to  linux
./android_fastboot.sh  ${ip_android}  reboot_bootloader


###reboot to android
#./android_fastboot.sh  ${ip_android}  bios_reboot
