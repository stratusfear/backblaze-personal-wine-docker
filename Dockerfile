FROM i386/alpine

RUN apk --update --no-cache add xvfb x11vnc openbox samba-winbind-clients
RUN echo "https://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk --no-cache add wine

ENV DISPLAY :0
ENV WINEPREFIX /wine/

# Disable WINE Debug messages
ENV WINEDEBUG -all

EXPOSE 5900

RUN echo " \
		Xvfb :0 -screen 0 1024x768x24 & \
    openbox & \
    x11vnc -nopw -q -forever -loop & \
    wine "$WINEPREFIX"/drive_c/Program\ Files/Backblaze/bzbui.exe -noqiet \
		"> /start.sh && chmod 755 /start.sh
CMD /start.sh
