ifconfig eth0 up 

cd /dav
cp davinci /home

#����gamma_hdr gamma_table_zl EE_Table.txt �����ļ�,�����gamma_table.tar.gz��
tar -zxf gamma_table.tar.gz -C /home
echo "gamma_table uncompressed."

tar -zxf certs.tar.gz -C /home

tar -zxf sound.tar.gz -C/home

tar -zxf wifi_driver.tar.gz -C /home

#����usb������
insmod /home/musb_hdrc.ko

rm -f /home/pidfile

chmod 777 load_kernel_modules.sh

cd /bin

/dav/load_kernel_modules.sh irqk
/dav/load_kernel_modules.sh edmak
/dav/load_kernel_modules.sh dm365mmap

#echo 2 > /proc/cpu/alignment

#Ӧ����ʹ�õĽӵ�����Ϊrtc,���ں�ʵ�ʴ���Ϊrtc0
ln -s /dev/rtc0 /dev/rtc

echo 2 > /proc/sys/vm/overcommit_memory
echo 90 > /proc/sys/vm/overcommit_ratio

echo 1 > /proc/sys/vm/dirty_ratio
echo 1 > /proc/sys/vm/dirty_background_ratio
#������פ���ڴ�ʱ��, ��λ:1/100��
echo 100 > /proc/sys/vm/dirty_expire_centisecs
#pdflush�������м��ʱ��, ��λ:1/100��
echo 50 > /proc/sys/vm/dirty_writeback_centisecs
echo 2048 > /proc/sys/vm/min_free_kbytes

#davinci���̵ĵ�ǰ����·������dav,��֤davinci�˳�ʱж��flash�ɹ�
cd /home

/bin/pppoed &
/bin/execSystemCmd &

check_rs232

if [ -f "/home/usage232" ]; then
  tar -zx -f /dav/IEfile.tar.gz -C /home
  echo "IEfile uncompressed."
	/home/davinci
else
	/home/davinci&
fi

tar -zx -f /dav/IEfile.tar.gz -C /home
echo "IEfile uncompressed."

tar -zxf /dav/openvpn.tar.gz
echo "openvpn CFG File uncompressed."

sleep 10
rm -rf /home/davinci
