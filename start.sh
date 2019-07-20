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
su -c bash open.sh
;;
2)
echo "请先前往magisk仓库搜索并安装模块 'adb'"
echo
read -p "如已安装模块 请按回车键尝试"
mkdir /sdcard/.android #创建存放adb密钥的目录
cd /sdcard/.android #进入存放adb密钥的目录
adb keygen adbkey #生成adb密钥
adb kill-server #结束adb进程
cd $HOME/O* #返回工作目录
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
echo "因本脚本使用bash作为命令解释器，请先前往magisk仓库搜索并安装模块 'GNU' "
echo
read -p "若已安装该模块，请按回车键重试."
if [  -x /system/xbin/bash  ]; then
Connect_type
else
echo
echo "警告：bash命令解释器不存在！ 请前往magisk仓库安装相关模块"
fi

}

bashisyes #判断bash是否存在
