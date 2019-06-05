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
limitreached = False
reddit = praw.Reddit(client_id=clientid,
                     client_secret=clientsecret,
                     user_agent='imasubreddit')

#get the top
subreddit = reddit.subreddit(reddittopic)
for submission in subreddit.top(limit=1500):

    if limitreached:
        break
    if submission.stickied:
        continue
    # print(submission.title + "  count " + str(commentcounter))
    submission.comments.replace_more(limit=50)
    for comment in submission.comments:
        print
        # Check for top-level comment
        if comment.parent_id == comment.link_id:
            if comment.replies:

                if commentcounter <= commentlimit:
                    commentcounter += 1
                else:
                    commentcounter = 0
                    limitreached = True
                    break

                for reply in comment.replies:
                    commentstring = comment.body.replace('\n', '') + ":;:" + reply.body.replace('\n', '')
                    print(commentstring)
                    break
# print("done")
