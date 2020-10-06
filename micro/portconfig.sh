# create two serial ports at the specified location
sudo socat -d -d pty,raw,echo=0,link=/dev/ttyS20 pty,raw,echo=0,link=/dev/ttyS21
# connect to gateway terminal
# sudo picocom /dev/ttyS20
# connect to device terminal
# sudo picocom /dev/ttyS21
