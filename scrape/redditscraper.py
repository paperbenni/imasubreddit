# _*_ coding:utf-8 _*_
# this scrapes
from praw.models import MoreComments
import praw

import os
from os import environ

# import environment variables into python
def getenv(var, default):
    if var in os.environ:
        return os.environ[var]
    else:
        return default

#reddit authentification
clientid = getenv('CLIENTID', 'U3OVuCLPbRY64A')
clientsecret = getenv('CLIENTSECRET', 'b9dPOM1KO9PlhjTgYcOOyGAt6qQ')
reddittopic = getenv('REDDIT', 'the_Donald')
commentlimit = int(getenv('LIMIT', 7000))
commentcounter = 0
reddit = praw.Reddit(client_id=clientid,
                     client_secret=clientsecret,
                     user_agent='imasubreddit')

#get the top
#subreddit = reddit.subreddit(reddittopic)

submfile = open("submissions.txt", "r")

for subid in submfile:
    if commentcounter >= commentlimit:
        break
    submid=subid.replace('\n', '')
    submission = reddit.submission(submid)
    if submission.stickied:
        continue
    submission.comments.replace_more(limit=20)
    for comment in submission.comments:
        # Check for top-level comment
        if comment.parent_id == comment.link_id:
            if comment.replies:
                for reply in comment.replies:
                    commentstring = comment.body.replace('\n', '') + "pb:;:pb" + reply.body.replace('\n', ' ')
                    print(commentstring.encode('utf-8'))
                    commentcounter += 1
                    break

submfile.close()
# print("done")
