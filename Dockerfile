FROM ubuntu:latest
MAINTAINER Zetanova <office@zetanova.eu>
 
#USE bash
SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -yy upgrade && \
	apt-get install -y --no-install-recommends \
	apt-utils \
	xvfb libxrender1 libxtst6 libxi6 \
	pulseaudio xfonts-base \
	eterm fluxbox xterm \
	supervisor nano net-tools tzdata \
	lxde x11vnc xvfb \
	gtk2-engines-murrine \
	chromium-browser \
	xrdp \
	uuid-runtime && \
	`# clean` && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -m -s /bin/bash -G pulse-access chrome
	
COPY rootfs/ /

RUN chown -R chrome:chrome /home/chrome/.fluxbox	
	
RUN echo "startfluxbox" > /home/chrome/.xsession && \
	chown chrome:chrome /home/chrome/.xsession

RUN chmod +x /app-entrypoint.sh && \
	chmod +x /run.sh
	
#WORKDIR /app
	
EXPOSE 3391

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["/run.sh"]
