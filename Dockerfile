FROM ubuntu:latest
MAINTAINER Zetanova <office@zetanova.eu>
 
#USE bash
SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -yy upgrade && \
	apt-get install -y apt-utils && \
	apt-get install -y --no-install-recommends \
	xvfb libxrender1 libxtst6 libxi6 \
	pulseaudio xfonts-base \
	fluxbox xterm \
	supervisor nano net-tools tzdata \
	x11vnc \
	chromium-browser \
	xrdp \
	uuid-runtime && \
	`# clean` && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd --create-home -m -s /bin/bash -G pulse-access chrome
	
COPY rootfs/ /
	
RUN echo "startfluxbox" > /home/chrome/.xsession

RUN mkdir /home/chrome/.x11vnc
RUN x11vnc -storepasswd chrome /home/chrome/.x11vnc/passwd

RUN chown -R chrome:chrome /home/chrome
	
RUN chmod +x /app-entrypoint.sh && \
	chmod +x /run.sh
	
RUN rm -f /etc/xrdp/rsakeys.ini
	
#WORKDIR /app
	
EXPOSE 3391

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["/run.sh"]
