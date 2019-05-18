data <- readLines("news.txt")
Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_181')
library(rJava)
library(wordcloud)
library(RColorBrewer)

##ì°¸ê³ 
##KAIST ?’ˆ?‚¬ ?ƒœê·¸ì…‹ ?™œ?š©
##?‹¨?–´?— ?’ˆ?‚¬ë¥? ì¶”ê?€?•˜?—¬ êµ¬ë¶„ê°€?Š¥
mergeUserDic(data.frame(c('?Š¤ë¥´ë¥µ'),c('mag'))) 

##9ê°? ?’ˆ?‚¬ êµ¬ë¶„
SimplePos09("?•„ë²„ì?€ê°€ ë°©ì— ?“¤?–´ê°€?‹ ?‹¤.")
##22ê°? ?’ˆ?‚¬ êµ¬ë?€
SimplePos22(data)

data_unlist <- unlist(data)
wordcount <- table(data_unlist)
##100?ˆœ?œ„?˜ ?‹¨?–´ ?„ ? •
wordcount_top <-head(sort(wordcount,decreasing = T),100)
wordcount_top

data_unlist 
##?›Œ?“œ?´?¼?š°?“œ ?‹¤?–‰
wordcloud(names(wordcount_top),wordcount_top) 

##ë¶ˆí•„?š”?•œ ?‹¨?–´ ?‚­? œ
##ì²«ë²ˆì§? ?š”?†Œ? œê±?
wordcount_top <- wordcount_top[-14]


data_unlist = gsub('[~!@#$%^&*()_+=?<>""]','',data_unlist)
data_unlist = gsub("\\d+","",data_unlist)
data_unlist = gsub("? „?„¸ê°?\\s*", "? „?„¸ê°?", data_unlist) 
data_unlist = gsub('"',"",data_unlist)



##?ƒ‰?…?ˆê¸?
display.brewer.all()
color<-brewer.pal(7,"Dark2")
windowsFonts(font=windowsFont("a?•œê¸€?‚¬?‘L"))
wordcloud(names(wordcount_top), wordcount_top, scale=c(5,0.4), min.freq = 4,
          max.words = "? „?„¸", random.order = FALSE, random.color= TRUE, colors=color, family = "a?•œê¸€?‚¬?‘L")
##ë§‰ë?€ê·¸ë˜?”„ë¡? ?‘œ?˜„
barplot(wordcount_top,main="?‹¨?–´ ë¶„í¬?ˆ˜", las=1,ylim=c(0,50))
