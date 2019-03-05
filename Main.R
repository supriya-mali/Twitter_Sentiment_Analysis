install.packages("twitteR")
install.packages("ROAuth")
library(twitteR)
library("ROAuth")
api_key="Mumyef7zXWdtwhJId3CxDmD50"
api_secret="V0FaN68eoZEG8bYlEQ462fe4AEW7fsH1sMA8rHzcW6spDamzrl"
access_token="926033453111316481-Exi2kRR0TKbG7O7DblrjtuheNTetlz4"
access_token_secret="votMPs7XNeDQnN5dRgh8Os12xylEIZsV3eQM97o9Bd0GW"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
skillindia=searchTwitter("modiinuae",n=100)
skillindia
skillindiaDF=twListToDF(skillindia)
head(skillindiaDF)
install.packages("sentiment")
install.packages("plyr")
install.packages("ggplot2")
install.packages("wordcloud")
install.packages("RColorBrewer")
install.packages("dplyr")
install.packages("purrr")
library(purrr)
library(dplyr)
library(sentiment)
library(plyr)
library(ggplot2)
library(wordcloud)
library(RColorBrewer)

tweets = searchTwitter("letHerRestinPeaCe",n=1000, since="2018-02-24", until="2018-03-1")
tweets
tweetsDF=twListToDF(tweets)
head(tweetsDF)
pos=readLines("D:/Supriya/R programmimg/Pos_word.txt")
neg=readLines("D:/Supriya/R programmimg/Neg_word.txt")
neg=c(neg,'please','request','stop')
score.sentiment=function(sentences,pos.words,neg.words,.progress='none')
{
  require('plyr')
  require('stringr')
  scores=laply(sentences,function(sentence, pos.words, neg.words)
  {
    sentence=gsub('[[:punct:]]',"",sentence)
    sentence=gsub('[[:cntrl:]]',"",sentence)
    sentence=gsub('\\d+',"",sentence)
    sentence=tolower(sentence)
    word.list = str_split(sentence, "\\s+")
    words = unlist(word.list)
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    score = sum(pos.matches) - sum(neg.matches)
    return(score)
  }, pos.words, neg.words, .progress=.progress )
  scores.df = data.frame(text=sentences, score=scores)
  return(scores.df)
}
finalscore=score.sentiment(tweets_df$text,pos,neg,.progress='text')
output=table(finalscore$score)
stat=finalscore$score
tweet1=ifelse(stat > 0, 'positive', ifelse(stat < 0, 'negative', 'neutral'))
class=ifelse(tweet1== 'positive', 1 , ifelse(tweet1== 'negative',0, 2))
data=data.frame(class, tweetsDF$text)
dim(data)
corpus <- Corpus(VectorSource(data1$text))
inspect(corpus[1:3])
corpus.clean=tm_map(corpus,tolower)
corpus.clean=tm_map(coprus.clean,removeNumbers)
corpus.clean=tm_map(coprus.clean,removePunctuations)
corpus.clean=tm_map(coprus.clean,removeWords,stopwords(kind="en"))
corpus.clean=tm_map(coprus.clean,stripWhitespace)
dtm <- DocumentTermMatrix(corpus.clean)
# Inspect the dtm
inspect(dtm[40:50, 10:15])
tweetsDF.train <- tweetsDF[1:465,]
tweetsDF.test <- tweetsDF[466:665,]
dtm.train <- dtm[1:465,]
dtm.test <- dtm[466:665,]
corpus.clean.train <- corpus.clean[1:465]
corpus.clean.test <- corpus.clean[466:665]
dim(dtm.train)
ffreq <- findFreqTerms(dtm.train, 2)
length((ffreq))
dtm.train.nb <- DocumentTermMatrix(corpus.clean.train, control=list(dictionary = ffreq))
dim(dtm.train.nb)
dtm.test.nb <- DocumentTermMatrix(corpus.clean.test, control=list(dictionary = ffreq))
dim(dtm.test.nb)
convert_count <- function(x) {
  y <- ifelse(x > 0, 1,0)
  y <- factor(y, levels=c(0,1), labels=c("No", "Yes"))
  y
}
# Apply the convert_count function to get final training and testing DTMs
trainNB <- apply(dtm.train.nb, 2, convert_count)
testNB <- apply(dtm.test.nb, 2, convert_count)
classifier <- naiveBayes(trainNB, df.train$class, laplace = 1)
pred <- predict(classifier, newdata=testNB)
t=table("Predictions"= pred, "Actual" = df.test$class )
acc<-sum(diag(t))/sum(t)
acc
