data <- readLines("news.txt")
Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_181')
library(rJava)
library(wordcloud)
library(RColorBrewer)

##참고
##KAIST ?��?�� ?��그셋 ?��?��
##?��?��?�� ?��?���? 추�?�?��?�� 구분가?��
mergeUserDic(data.frame(c('?��르륵'),c('mag'))) 

##9�? ?��?�� 구분
SimplePos09("?��버�?�가 방에 ?��?��가?��?��.")
##22�? ?��?�� 구�?�
SimplePos22(data)

data_unlist <- unlist(data)
wordcount <- table(data_unlist)
##100?��?��?�� ?��?�� ?��?��
wordcount_top <-head(sort(wordcount,decreasing = T),100)
wordcount_top

data_unlist 
##?��?��?��?��?��?�� ?��?��
wordcloud(names(wordcount_top),wordcount_top) 

##불필?��?�� ?��?�� ?��?��
##첫번�? ?��?��?���?
wordcount_top <- wordcount_top[-14]


data_unlist = gsub('[~!@#$%^&*()_+=?<>""]','',data_unlist)
data_unlist = gsub("\\d+","",data_unlist)
data_unlist = gsub("?��?���?\\s*", "?��?���?", data_unlist) 
data_unlist = gsub('"',"",data_unlist)



##?��?��?���?
display.brewer.all()
color<-brewer.pal(7,"Dark2")
windowsFonts(font=windowsFont("a?��글?��?��L"))
wordcloud(names(wordcount_top), wordcount_top, scale=c(5,0.4), min.freq = 4,
          max.words = "?��?��", random.order = FALSE, random.color= TRUE, colors=color, family = "a?��글?��?��L")
##막�?�그래?���? ?��?��
barplot(wordcount_top,main="?��?�� 분포?��", las=1,ylim=c(0,50))