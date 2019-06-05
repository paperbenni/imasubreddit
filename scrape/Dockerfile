FROM paperbenni/python
RUN pip3 install praw pushshift.py

RUN curl rclone.surge.sh/rclone > /bin/rclone && chmod +x /bin/rclone
COPY scrape.sh scrape.sh
RUN chmod +x scrape.sh
COPY redditscraper.py redditscraper.py

CMD "./scrape.sh"
