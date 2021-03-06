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