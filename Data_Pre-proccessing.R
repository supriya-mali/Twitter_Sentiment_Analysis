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