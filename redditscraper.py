from praw.models import MoreComments
import praw
import os
from os import environ

# import environment variables into python
def getenv(var, default):
    if var in os.environ:
        return os.environ["REDDIT"]
    else:
        return default

#reddit authentification
clientid = getenv('CLIENTID', 'U3OVuCLPbRY64A')
clientsecret = getenv('CLIENTSECRET', 'b9dPOM1KO9PlhjTgYcOOyGAt6qQ')
reddittopic = getenv('REDDIT', 'python')
commentlimit = 100#getenv('LIMIT', 10000)
commentcounter = 0
limitreached = False
reddit = praw.Reddit(client_id=clientid,
                     client_secret=clientsecret,
                     user_agent='imasubreddit')

#get the top 
subreddit = reddit.subreddit(reddittopic)
for submission in subreddit.top(limit=10000):
    if limitreached:
        break
    if submission.stickied:
        continue
    print(submission.title)
    submission.comments.replace_more(limit=10)
    for comment in submission.comments:

        # Check for top-level comment
        if comment.parent_id == comment.link_id:
            if comment.replies:

                if 'https://' in comment.body or 'www.' in comment.body:
                    continue
                if len(comment.body) < 2:
                    continue

                if commentcounter <= commentlimit:
                    commentcounter += 1
                else:
                    commentcounter = 0
                    limitreached = True
                    break     

                with open(reddittopic + "data/train.from", "a") as myfile:
                    myfile.write(comment.body.replace('\n', '') + '\n')
                for reply in comment.replies:
                    with open(reddittopic + "data/train.to", "a") as myfile:
                        commentstring = reply.body.replace('\n', '') + '\n'
                        myfile.write(commentstring)
                        print(commentstring)
                    break

print("done")