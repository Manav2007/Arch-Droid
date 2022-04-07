#!/system/bin/sh

STOP_IO_QUEUE_EXTENSION_SCRIPT="/data/data/com.lcis.seeder/revert_io_queue_extension.sh"
FIND="/data/data/com.lcis.seeder/busybox find"

if [ "$1" == "start" ]; then
	if [ ! -e $STOP_IO_QUEUE_EXTENSION_SCRIPT ]; then
		echo "#!/system/bin/sh" > $STOP_IO_QUEUE_EXTENSION_SCRIPT
		echo "" >> $STOP_IO_QUEUE_EXTENSION_SCRIPT
		
		for node in `$FIND /sys/devices/platform -name nr_requests`; do
			numberRequests=`cat $node`
	
			echo "echo $numberRequests > $node" >> $STOP_IO_QUEUE_EXTENSION_SCRIPT
		done
		
		echo "echo `cat /proc/sys/vm/dirty_expire_centisecs` > /proc/sys/vm/dirty_expire_centisecs" >> $STOP_IO_QUEUE_EXTENSION_SCRIPT
		echo "echo `cat /proc/sys/vm/dirty_writeback_centisecs` > /proc/sys/vm/dirty_writeback_centisecs" >> $STOP_IO_QUEUE_EXTENSION_SCRIPT
	fi
	
	echo "Enabling I/O queue extension..."
	
	echo 1000 > /proc/sys/vm/dirty_expire_centisecs
	echo 500 > /proc/sys/vm/dirty_writeback_centisecs
	for node in `$FIND /sys -name nr_requests | grep mmcblk`; do echo 1024 > $node; done
elif [ "$1" == "stop" ]; then
	if [ -e $STOP_IO_QUEUE_EXTENSION_SCRIPT ]; then
		echo "Executing $STOP_IO_QUEUE_EXTENSION_SCRIPT..."
		sh $STOP_IO_QUEUE_EXTENSION_SCRIPT
		rm $STOP_IO_QUEUE_EXTENSION_SCRIPT
	else
		echo "$0: I/O queue extension has not been enabled."
	fi
else
	echo "Usage: $0 (start|stop)"
fi
