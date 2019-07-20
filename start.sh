#!/bin/bash

Connect_type(){
#环境类型
clear
echo "你想使用何种方式运行本脚本？"
echo "1.root模式"
echo "2.免root模式(adb)"
echo "3.运行？段位？"
echo
read -p "好的召唤师，请选择您的英雄:" input_type
case $input_type in
1)
bash open.sh
;;
2)
echo "请先前往magisk仓库搜索并安装模块 'adb'"
echo
read -p "如已安装模块 请按回车键尝试"
mkdir /sdcard/.android #创建存放adb密钥的目录
cd /sdcard/.android #进入存放adb密钥的目录
adb keygen adbkey #生成adb密钥
#cat /sdcard/.android/adbkey.pub > /data/misc/adb/adb_keys
if [ -d /data/misc/adb/adb_keys ]; then
#判断公钥是否在本机中存在
adb shell sh ./open.sh
else
#启用网络adb
setprop service.adb.tcp.port 5555
stop adbd && start adbd #重启adb守护进程
adb kill-server #结束adb进程
cd $HOME/O* #返回工作目录
fi
adb shell sh ./open.sh
;;
3)
  kill -9 `pgrep -f bash`
esac
}

bashisyes(){

clear

echo
echo "欢迎吖！ 版本号：1.2"
echo
echo "Tip：本脚本使用bash作为命令解释器 默认状态下system只包含sh命令解释器 "
echo "接下来将检测bash是否存在"
read -p "请按回车键继续."
if  command -v bash > /dev/null; then
    echo "bash command has found"
    sleep 1 && Connect_type
else
    echo "Error:bash command has not found"
    echo "警告：bash命令解释器不存在！"
    echo 
    echo "提示：脚本会把Tremux自带的bash软链接到/system/bin"
    read "如果继续，请按回车键. 否则请结束该脚本"
    mount -o rw,remount /system
    ln -s /data/data/com.termux/files/usr/bin/bash  /system/bin
    unmount /system || mount -o ro,remount /system
fi
echo

}

isroot() {
if [ `whoami` = "root" ];then
	bashisyes  #判断bash是否存在
else
    echo "请执行 'su -c bash start.sh' 临时赋予脚本管理员权限 "
    echo
    echo "权限用于测试系统环境中是否存在bash命令解释器"
    echo 

    exit
fi
}
isroot #主入口
