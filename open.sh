#!/bin/bash

echo "
0.电池优化
1.Android Pie电池管理器
2.
3.
4.
"
read -p  "Please enter the number:"  open
case  $open in
	
0)
i='com.android.settings/com.android.settings.Settings$HighPowerApplicationsActivity'
	;;

1)
i='com.android.settings/com.android.settings.Settings$PowerUsageSummaryActivity'
	;;

2)

	;;
3)

	;;

4)

	;;

esac

am start -n  $i
