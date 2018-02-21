#!/bin/sh
cd /usr/share/17ce || cd /root/17ce
rm -f update.tgz
./17ce_v3 -v || wget -O /usr/lib/libpolarssl.so.7 http://www.17ce.com/soft/route/files/14.07/libpolarssl.so.1.3.9
PID=`pidof 17ce_v3`
echo "pid: $PID"
if [ "x$PID" = 'x' ]; then
	echo "process die"
	/etc/init.d/17ce* start
else
	echo "process ok"
	MEM=`ps|grep 17ce_v3|grep -v grep|awk '{print $3}'`
	if [ "$MEM" -gt 35000 ]; then
		echo "mem out: $MEM"
		/etc/init.d/17ce* restart
	else
		echo "mem ok"
		LOGSIZE=`ls 17ce_v3.log  -l| awk '{print $5}'`
		if [ "$LOGSIZE" -gt 1000000 ]; then
			echo "log size out: $MEM"
			/etc/init.d/17ce* restart
		else
			echo "log size ok"
		fi
	fi
fi


VERSION=`./17ce_v3 -v`
echo "current version: $VERSION"

STR="this is a string"
TEMPSTR=`curl -k -m 10 http://www.17ce.com/api/17ce_route_client_new.php 2>/dev/null  || ( wget http://www.17ce.com/api/17ce_route_client_new.php -O /tmp/17.tmp 2>/dev/null && cat /tmp/17.tmp )`
TVER=`echo $TEMPSTR|awk '{print $1}'`
TURL=`echo $TEMPSTR|awk '{print $2}'`
if echo "$TURL" |grep -q "http"
then
	echo "get version:$TVER, get update url:$TURL"
	if [ "x$VERSION" != "x$TVER" ]; then
		echo "updating..."
		cd /tmp/
		if curl -o /tmp/update.tgz -k -m 60 $TURL || wget -O /tmp/update.tgz $TURL
		then
			echo "download ok"
			/etc/init.d/17ce* stop
			killall -9 17ce_v3
			cd /usr/share/17ce || cd /root/17ce
			rm -f 17ce_v3 monitor.sh 17ce_v3.log
			tar zxf /tmp/update.tgz
			/etc/init.d/17ce* start
			echo "update ok"
		else
			echo "download failed"
		fi
	else
		echo "17ce is already the newest version"
	fi
fi

