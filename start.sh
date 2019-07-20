#!/bin/sh

#kill -9 `pgrep -f bash`
bashisyes(){
clear
echo
echo "Welcome to my tools"
echo
echo "Tip：本脚本使用bash作为命令解释器 默认状态下system只包含sh命令解释器 "
echo "接下来将检测bash是否存在..."
if  command -v bash > /dev/null; then
    echo "bash command has found"
    sleep 5 && bash open.sh
else
    echo "Error:bash command has not found"
    echo "警告：bash命令解释器不存在！"
    echo 
    echo "提示：脚本会把Tremux自带的bash软链接到/system/bin"
    sleep 5 "如果继续，请按回车键. 否则请结束该脚本 [5秒钟考虑] 默认继续"
    mount -o rw,remount /system #挂载系统读写
    ln -s /data/data/com.termux/files/usr/bin/bash  /system/bin #创建链接
    unmount /system || mount -o ro,remount /system #卸载或者挂载只读
fi
echo
}

checkroot() {
if [ `whoami` = "root" ];then
	bashisyes  #判断bash是否存在
else
    echo "请执行 'su -c bash start.sh' 使用管理员权限运行 "
    echo
    echo "权限用于测试系统环境中是否存在bash命令解释器"
    echo 
    exit
fi
}
checkroot #主入口
