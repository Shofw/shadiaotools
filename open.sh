#!/bin/bash 
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
pm uninstall --user 0 $package1
pm uninstall --user 0 $package2
pm uninstall --user 0 $package3
pm uninstall --user 0 $package4
pm uninstall --user 0 $package5
pm uninstall --user 0 $package6
pm uninstall --user 0 $package7
sleep 1 &&  menu
	;;
5)
package_disable
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
sleep 1 && adbtools
       ;;
2)
sh /sdcard/Android/data/moe.shizuku.privileged.api/files/start.sh 
sleep 1 && adbtools
	;;
3)
sh /data/data/me.piebridge.brevent/brevent.sh
sleep 1 && adbtools
	;;
4)
dpm set-device-owner me.yourbay.airfrozen/.main.core.mgmt.MDeviceAdminReceiver
sleep 1 && adbtools
	;;
5)
pm grant --user 0 rikka.appops android.permission.GET_APP_OPS_STATS
sleep 1 && adbtools
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
sleep 2 && what_type
	;;
2)
echo "哈哈想不到吧！我特么没有写这个东西"
echo 
echo "因为冰箱的开发者已经自己写了一个Linux端的脚本，"
sleep 2 && what_type
;;
*)
adbtools
esac

}

package1=com.miui.video #小米视频
package2=com.miui.analytics #隐私搜集服务
package3=com.miui.player #小米音乐
package4=com.xiaomi.payment #米币支付
package5=com.xiaomi.ab #小米推广
package6=com.xiaomi.gamecenter.sdk.service #小米游戏服务
package7=com.mipay.wallet #小米钱包
package8=com.miui.systemAdSolution #广告组件

package_disable (){
echo
echo "1.小米视频 2.隐私搜集服务 3.小米音乐 4.米币支付"
echo "5.小米推广 6.小米游戏服务 7.小米钱包 8.广告组件"
echo
echo "all.全部停用"
echo "按回车键返回主菜单."
echo

read -p "你想停用什么？：" output
case $output in

1) pm disable-user $package1 && package_disable
	;;
2) pm disable-user $package2 && package_disable
	;;
3) pm disable-user $package3 && package_disable
	;;
4) pm disable-user $package4 && package_disable
	;;
5) pm disable-user $package5 && package_disable
	;;
6) pm disable-user $package6 && package_disable
	;;
7) pm disable-user $package7 &&  package_disable
	;;
all) 
pm disable-user $package1
pm disable-user $package2
pm disable-user $package3
pm disable-user $package4
pm disable-user $package5 
pm disable-user $package6
pm disable-user $package7

sleep 1 && package_disable
        ;;
*) menu
esac
}
menu

