from praw.models import MoreComments
import praw
import os

clientid = os.environ["CLIENTID"]
if clientid is None:
    clientid = 'U3OVuCLPbRY64A'


clientsecret = os.environ["CLIENTSECRET"]
if clientsecret is None:
    clientsecret = 'b9dPOM1KO9PlhjTgYcOOyGAt6qQ'


reddit = praw.Reddit(client_id=clientid,
                     client_secret=clientsecret,
                     user_agent='imasubreddit')

subreddit = reddit.subreddit('python')
for submission in subreddit.top(limit=1):
    print(submission.title)
    submission.comments.replace_more(limit=10000)
    for comment in submission.comments:
        if comment.parent_id == comment.link_id:
            if comment.replies:
                with open("data/train.from", "a") as myfile:
                    myfile.write(comment.body.replace('\n', '') + '\n')

                for reply in comment.replies:
                    with open("data/train.to", "a") as myfile:
                        myfile.write(reply.body.replace('\n', '') + '\n')
                    break
