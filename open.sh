#!/bin/sh

#菜单
menu (){
clear
echo  "
快速打开一些隐藏活动

0.电池优化
1.Android Pie电池管理器
2.开启极致神隐
3.应用和通知
4.通知日志

快速冻结/卸载MIUI广告组件
5.卸载MIUI广告组件
6.冻结MIUI广告组件

Please enter the number:"
read  open
case  $open in
	
0)
i='com.android.settings/com.android.settings.Settings$HighPowerApplicationsActivity'
am start -n $i
	;;

1)
u='com.android.settings/com.android.settings.Settings$PowerUsageSummaryActivity'
p=`getprop ro.product.brand` ; [ $p = xiaomi ] && u='com.android.settings/com.android.settings.fuelgauge.PowerUsageSummary'
am start -n $u
	;;

2)
i='com.miui.powerkeeper/com.miui.powerkeeper.ui.ExtremePowerEntryActivity'
am start -n $i
	;;
3)
i='com.android.settings/com.android.settings.Settings$AppAndNotificationDashboardActivity'
am start -n $i
	;;

4)
i='com.android.settings/com.android.settings.Settings$NotificationStationActivity'
am start -n $i
	;;
5)
pm uninstall com.miui.video com.xiaomi.gamecenter.sdk.service com.miui.player com.miui.analytics com.xiaomi.ab com.mipay.wallet com.miui.systemAdSolution ; sleep 2
	;;
6)
pm disable-user com.miui.video ; sleep 2
	;;
esac
menu
}

menu
