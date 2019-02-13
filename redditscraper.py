from praw.models import MoreComments
import praw
import os
from os import environ

def getenv(var, default):
    if var in os.environ:
        return os.environ["REDDIT"]
    else:
        return default

clientid = getenv('CLIENTID', 'U3OVuCLPbRY64A')
clientsecret = getenv('CLIENTSECRET', 'b9dPOM1KO9PlhjTgYcOOyGAt6qQ')
reddittopic = getenv('REDDIT', 'python')
commentlimit = getenv('COMMENTLIMIT', 1000)

reddit = praw.Reddit(client_id=clientid,
                     client_secret=clientsecret,
                     user_agent='imasubreddit')

subreddit = reddit.subreddit(reddittopic)
for submission in subreddit.top(limit=1000):
    if submission.stickied:
        continue
    print(submission.title)
    submission.comments.replace_more(limit=10)
    for comment in submission.comments:
        if comment.parent_id == comment.link_id:
            if comment.replies:

                if 'https://' in comment.body or 'www.' in comment.body:
                    continue
                if len(comment.body) < 2:
                    continue

                with open("data/train.from", "a") as myfile:
                    myfile.write(comment.body.replace('\n', '') + '\n')

                for reply in comment.replies:
                    with open("data/train.to", "a") as myfile:
                        myfile.write(reply.body.replace('\n', '') + '\n')
                        print("comment")
                    break
