from praw.models import MoreComments
import praw
import os
from os import environ

clientid = 'U3OVuCLPbRY64A'
clientsecret = 'b9dPOM1KO9PlhjTgYcOOyGAt6qQ'

if "CLIENTID" in os.environ:
    clientid = os.environ["CLIENTID"]

if "CLIENTSECRET" in os.environ:
    clientid = os.environ["CLIENTSECRET"]

reddit = praw.Reddit(client_id=clientid,
                     client_secret=clientsecret,
                     user_agent='imasubreddit')

subreddit = reddit.subreddit('space')
for submission in subreddit.top(limit=1000):
    print(submission.title)
    submission.comments.replace_more(limit=10)
    for comment in submission.comments:
        if comment.parent_id == comment.link_id:
            if comment.replies:
                with open("data/train.from", "a") as myfile:
                    myfile.write(comment.body.replace('\n', '') + '\n')

                for reply in comment.replies:
                    with open("data/train.to", "a") as myfile:
                        myfile.write(reply.body.replace('\n', '') + '\n')
                        print("comment")
                    break
