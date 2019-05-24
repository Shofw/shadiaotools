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

快速冻结/卸载MIUI广告及系统组件
5.卸载MIUI组件
6.冻结MIUI组件
7.解冻MIUI组件
8.显示即将去世的组件列表
9.退出脚本

"$list"
	
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
pm uninstall --user 0 com.miui.video ; pm uninstall --user 0 com.miui.player ;pm uninstall --user 0 com.mipay.wallet ; pm uninstall --user 0 com.xiaomi.payment ; pm uninstall --user 0 com.xiaomi.gamecenter.sdk.service ; pm uninstall --user 0 com.miui.analytics ; pm uninstall --user 0 com.xiaomi.ab ; pm uninstall --user 0 com.miui.systemAdSolution 
	;;
6)
pm disable-user com.miui.video ;pm disable-user com.miui.player ; pm disable-user com.miui.analytics ; pm disable-user com.xiaomi.ab ; pm disable-user com.xiaomi.payment ; pm diasble-user com.xiaomi.gamecenter.sdk.service ; pm disable-user com.xiaomi.payment ; pm disable-user com.mipay.wallet ; pm disable-user com.miui.systemAdSolution
	;;
7)
pm enable com.miui.video ; pm enable com.miui.player ; pm enable com.xiaomi.payment ; pm enable com.xiaomi.gamecenter.sdk.service ; pm enable com.xiaomi.payment ; pm enable com.miui.analytics ; pm enable com.xiaomi.ab ; pm enable com.mipay.wallet ; pm enable com.miui.systemAdSolution
        ;;
8)
list="小米视频 小米音乐 小米钱包 游戏服务组件 米币支付 analytics mab msa"
;;
9)
	exit
esac
menu
}

menu
