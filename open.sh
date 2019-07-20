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
menu

