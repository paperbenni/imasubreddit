FROM python
RUN pip install praw
RUN apt update && apt install rclone && apt clean

RUN wget https://github.com/ncw/rclone/releases/download/v1.46/rclone-v1.46-linux-amd64.deb && \
mv *.deb rclone.deb && \
dpkg -i rclone.deb && \
rm rclone.deb 

RUN useradd -ms /bin/bash user

WORKDIR /home/user

COPY scrape.sh scrape.sh
RUN chmod +x scrape.sh && chown user scrape.sh 
USER user
ENV HOME=/home/user
RUN mkdir -p .config/rclone
COPY rclone.conf .config/rclone/rclone.conf
COPY redditscraper.py redditscraper.py

CMD "./scrape.sh"