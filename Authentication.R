library(twitterR)
library('ROAuth')


api_key="Mumyef7zXWdtwhJId3CxDmD50"
api_secret="V0FaN68eoZEG8bYlEQ462fe4AEW7fsH1sMA8rHzcW6spDamzrl"
access_token="926033453111316481-Exi2kRR0TKbG7O7DblrjtuheNTetlz4"
access_token_secret="votMPs7XNeDQnN5dRgh8Os12xylEIZsV3eQM97o9Bd0GW"


setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

 

cred <- OAuthFactory$new(consumerKey=api_key, consumerSecret=api_secret , requestURL='https://api.twitter.com/oauth/request_token', accessURL='https://api.twitter.com/oauth/access_token',authURL='https://api.twitter.com/oauth/authorize')
cred$handshake()