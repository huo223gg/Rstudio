data <- readLines("news.txt")
Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_181')
library(rJava)
library(wordcloud)
library(RColorBrewer)

##μ°Έκ³ 
##KAIST ??¬ ?κ·Έμ ??©
##?¨?΄? ??¬λ₯? μΆκ???¬ κ΅¬λΆκ°?₯
mergeUserDic(data.frame(c('?€λ₯΄λ₯΅'),c('mag'))) 

##9κ°? ??¬ κ΅¬λΆ
SimplePos09("?λ²μ?κ° λ°©μ ?€?΄κ°? ?€.")
##22κ°? ??¬ κ΅¬λ?
SimplePos22(data)

data_unlist <- unlist(data)
wordcount <- table(data_unlist)
##100??? ?¨?΄ ? ? 
wordcount_top <-head(sort(wordcount,decreasing = T),100)
wordcount_top

data_unlist 
##???΄?Ό?°? ?€?
wordcloud(names(wordcount_top),wordcount_top) 

##λΆν?? ?¨?΄ ?­? 
##μ²«λ²μ§? ??? κ±?
wordcount_top <- wordcount_top[-14]


data_unlist = gsub('[~!@#$%^&*()_+=?<>""]','',data_unlist)
data_unlist = gsub("\\d+","",data_unlist)
data_unlist = gsub("? ?Έκ°?\\s*", "? ?Έκ°?", data_unlist) 
data_unlist = gsub('"',"",data_unlist)



##???κΈ?
display.brewer.all()
color<-brewer.pal(7,"Dark2")
windowsFonts(font=windowsFont("a?κΈ?¬?L"))
wordcloud(names(wordcount_top), wordcount_top, scale=c(5,0.4), min.freq = 4,
          max.words = "? ?Έ", random.order = FALSE, random.color= TRUE, colors=color, family = "a?κΈ?¬?L")
##λ§λ?κ·Έλ?λ‘? ??
barplot(wordcount_top,main="?¨?΄ λΆν¬?", las=1,ylim=c(0,50))
