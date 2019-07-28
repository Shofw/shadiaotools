#!/bin/bash

#kill -9 `pgrep -f bash`
#菜单
menu(){
clear
echo  "
[快速打开一些隐藏活动]
0.电池优化
1.Android Pie电池管理器
2.开启极致神隐
3.应用和通知
4.打开自带文档APP
5.Google设置

6.
7.MIUI组件管理
8.adb激活工具

[类原生工具]
9.去除x号
10.跳过Google验证 (twrp下请先手动挂载system读写)

按回车键退出脚本.
"
read -p "Please enter the number:" open
case  $open in
	
0)

i='com.android.settings/com.android.settings.Settings$HighPowerApplicationsActivity'
	;;

1)
i='com.android.settings/com.android.settings.Settings$PowerUsageSummaryActivity'
p=`getprop ro.product.brand` ; [ $p = xiaomi ] && i='com.android.settings/com.android.settings.fuelgauge.PowerUsageSummary'

	;;

2)
i='com.miui.powerkeeper/com.miui.powerkeeper.ui.ExtremePowerEntryActivity'
	;;
3)
i='com.android.settings/com.android.settings.Settings$AppAndNotificationDashboardActivity'
	;;
4)
i='com.android.documentsui/com.android.documentsui.LauncherActivity'
	;;
5)
i='com.google.android.gms/com.google.android.gms.app.settings.GoogleSettingsIALink'
	;;
6) echo "想不到吧！这个是空的！ 欧拉欧拉欧拉欧拉欧拉欧拉欧拉欧拉欧拉欧拉欧拉欧拉欧拉欧拉"
	;;
7)
package_miui #MIUI软件包管理
	;;
8)
adbtools #adb快捷启动
	;;
9)
captive_portal=connect.rom.miui.com/generate_204
#删除验证服务器
settings delete global captive_portal_https_url
settings delete global captive_portal_http_url
#重新设置验证服务器
settings put global captive_portal_http_url http://$captive_portal
settings put global captive_portal_https_url https://$captive_portal

	;;
10)
#跳过Google验证
mount -o rw,remount /system
echo ro.setupwizard.mode=DISABLED >> /system/build.prop
dd if=/dev/zero of=/dev/block/bootdevice/by-name/splash
	;;
*)
	exit
esac
am start -n $i
sleep 1 &&  menu
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

package_miui (){
echo "以下为去世列表(您只能输入a或b)"
echo
echo "1.小米视频 2.analytics     3.小米音乐 4.米币支付"
echo "5.mab      6.小米游戏服务  7.小米钱包 8.msa"
echo
echo "a.全部停用 b.全部卸载"
echo
echo "按回车键返回主菜单."
echo

read -p "请输入a 或者 b：" output
case $output in
a) 
pm disable-user $package1
pm disable-user $package2
pm disable-user $package3
pm disable-user $package4
pm disable-user $package5 
pm disable-user $package6
pm disable-user $package7
;;
b) 
pm uninstall --user 0 $package1
pm uninstall --user 0 $package2
pm uninstall --user 0 $package3
pm uninstall --user 0 $package4
pm uninstall --user 0 $package5
pm uninstall --user 0 $package6
pm uninstall --user 0 $package7
;;

*) menu
esac
sleep 1 && package_miui
}

checkbash(){
	clear
	echo "Welcome to shahai Tools"
	echo
	echo "本脚本使用bash作为命令解释器"
	echo "默认状态下system只包含sh命令解释器"
	echo "接下来将检测bash是否存在..."
if  command -v bash > /dev/null; then
	echo
	echo "bash command has found"
	echo "即将进入主界面..." && sleep 3 
	menu #主菜单
else
	echo "Error:bash command has not found"
	echo "警告：bash命令解释器不存在"
	echo "提示：脚本将会把Tremux自带的bash软链接到/system/bin"
	echo "如果继续，请等待5秒. 否则请结束该脚本 [Ctrl +C] 默认>继续"
	sleep 5
	mount -o rw,remount /system
	ln -s /data/data/com.termux/files/usr/bin/bash  /bin #创建链接
	#mount -o ro,remount /system 2>1 >/dev/null #挂载system只读
    echo
    echo "bash已链接到/bin/bash"
    echo
    echo "即将进入主界面..."
    sleep 2  && menu
fi
}

checkroot() {
if [ `whoami` = "root" ];then
        checkbash  #判断bash是否存在
else
    clear
    echo
    echo "如果系统中有bash命令解释器"
    echo "请执行 'su -c ./start.sh' 以管理员权限运行"
    echo "如果您不知道系统中是否存在bash命令解释器"
    echo "尝试运行 'su -c sh ./start.sh' 检测并安装bash"
    echo "注意,最终将会报错,这不是bug. 因为sh不兼容read 命令."
    echo "尝试执行'su -c ./start.sh'命令即可"
    echo "权限用于测试系统环境中是否存在bash命令解释器"
    exit
fi
}
checkroot #主入口

