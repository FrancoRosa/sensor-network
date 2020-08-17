# create psudo serial ports adn bridge them
# socat setup 
socat -d -d pty,raw,echo=0 pty,raw,echo=0 &
