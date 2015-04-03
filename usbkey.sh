# sudo mkdir /media/usbkey
# sudo chown pi:pi /media/usbkey
#
sudo mount -t vfat -o uid=pi,gid=pi /dev/sda1 /media/usbkey

