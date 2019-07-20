#!$PREFIX/bin/bash /system/xbin/bash
#菜单
menu (){
clear
echo  "

[快速打开一些隐藏活动]
0.电池优化
1.Android Pie电池管理器
2.开启极致神隐
3.应用和通知

[冻结/卸载MIUI组件]
4.卸载MIUI组件
5.冻结MIUI组件

6.adb激活快捷工具

[类原生工具]

7.去除x号
8.跳过Google验证 (twrp下请先手动挂载system读写) 

按回车键退出脚本.
"
read -p "Please enter the number:" open
case  $open in
	
0)

i='com.android.settings/com.android.settings.Settings$HighPowerApplicationsActivity'
am start -n $i
sleep 1 &&  menu
	;;

1)
u='com.android.settings/com.android.settings.Settings$PowerUsageSummaryActivity'
p=`getprop ro.product.brand` ; [ $p = xiaomi ] && u='com.android.settings/com.android.settings.fuelgauge.PowerUsageSummary'
am start -n $u
sleep 1 &&  menu
	;;

2)
i='com.miui.powerkeeper/com.miui.powerkeeper.ui.ExtremePowerEntryActivity'
am start -n $i
sleep 1 &&  menu
	;;
3)
i='com.android.settings/com.android.settings.Settings$AppAndNotificationDashboardActivity'
am start -n $i
sleep 1 &&  menu
	;;
4)
pm uninstall --user 0 com.miui.video
pm uninstall --user 0 com.miui.player
pm uninstall --user 0 com.mipay.wallet
pm uninstall --user 0 com.xiaomi.payment
pm uninstall --user 0 com.xiaomi.gamecenter.sdk.service
pm uninstall --user 0 com.miui.analytics
pm uninstall --user 0 com.xiaomi.ab
pm uninstall --user 0 com.miui.systemAdSolution
sleep 1 &&  menu
	;;
5)
pm disable-user com.miui.video
pm disable-user com.miui.player
pm disable-user com.miui.analytics
pm disable-user com.xiaomi.ab
pm disable-user com.xiaomi.payment
pm diasble-user com.xiaomi.gamecenter.sdk.service
pm disable-user com.xiaomi.payment
pm disable-user com.mipay.wallet
pm disable-user com.miui.systemAdSolution
sleep 1 &&  menu
	;;
6)
adbtools #adb快捷启动
sleep 1 &&  menu
	;;
7)
#删除验证服务器
settings delete global captive_portal_https_url
settings delete global captive_portal_http_url
#重新设置验证服务器
settings put global captive_portal_http_url http://captive.v2ex.co/generate_204
settings put global captive_portal_https_url https://captive.v2ex.co/generate_204

sleep 1 &&  menu
	;;
8)
#跳过Google验证
mount -o rw,remount /system
echo ro.setupwizard.mode=DISABLED >> /system/build.prop
dd if=/dev/zero of=/dev/block/bootdevice/by-name/splash
sleep 1 &&  menu
	;;
*)
	exit
esac

}

adbtools (){
clear
echo "
1.激活冰箱
2.激活shizuku
3.激活黑域
4.激活空调狗
5.adb授权appops所需权限(托管设备管理员模式)

按回车键返回上一级
"
read -p "你想激活什么？(键入数字)： " adb_output
case $adb_output in
1)
what_type
       ;;
2)
sh /sdcard/Android/data/moe.shizuku.privileged.api/files/start.sh
	;;
3)
sh /data/data/me.piebridge.brevent/brevent.sh
	;;
4)
dpm set-device-owner me.yourbay.airfrozen/.main.core.mgmt.MDeviceAdminReceiver
	;;
5)
pm grant --user 0 rikka.appops android.permission.GET_APP_OPS_STATS
	;;
*)
menu

esac
}

what_type (){
clear
echo "
1.普通adb模式
2.设备管理员模式

按回车键返回上一级
"
read -p "请选择激活方式:" what_type
case $what_type in
1)
sh /sdcard/Android/data/com.catchingnow.icebox/files/start.sh
	;;
2)
echo "哈哈想不到吧！我特么没有写这个东西"
echo 
echo "因为冰箱的开发者已经自己写了一个Linux端的脚本，"
;;
*)
adbtools
esac

}

install_apk(){
clear
echo "
1.安装钛备份
2.安装网易云音乐
3.安装酷安
4.安装迅雷

回车键返回主菜单
"
read -p "你想安装什么？(键入数字)：" output
case $output in

1)
input_package="TitaniumBackup.apk"
	;;
2)
input_package="netease.apk"
	;;
3)
input_package="coolapk.apk"
	;;
4)
input_package="xunlei.apk"
	;;
*)
rm -rf /data/local/tmp/*
sleep 1 && menu
esac
pm install -r $input_package

install_apk
}
<<<<<<< HEAD
menu
=======

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
`su && bash open.sh`
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
`adb shell sh ./open.sh `
;;
3)
kill -9 `pgrep -f bash`
esac
}

bashisyes(){

clear
echo 
echo "欢迎吖！"
echo
echo "因本脚本使用bash作为命令解释器，请先前往magisk仓库搜索并安装模块 'GNU' "
echo
read -p "若已安装该模块，请按回车键重试."
if [ -x /system/xbin/bash  ]; then
Connect_type
else
echo
echo "警告：bash命令解释器不存在！ 请前往magisk仓库安装相关模块"
fi

}

bashisyes #判断bash是否存在
>>>>>>> 075f367536a052b8ade6ad319cfe3a5413538cfa
