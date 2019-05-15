FROM paperbenni/python
RUN pip install praw

COPY scrape.sh scrape.sh
RUN chmod +x scrape.sh && chown user scrape.sh
RUN mkdir -p .config/rclone
COPY rclone.conf .config/rclone/rclone.conf
COPY redditscraper.py redditscraper.py

CMD "./scrape.sh"
