FROM homeassistant/raspberrypi3-homeassistant

#RUN pip3 install paho-mqtt==1.3.0 --no-cache-dir
RUN apk add imagemagick
#RUN apk add --update mosquitto mosquitto-clients