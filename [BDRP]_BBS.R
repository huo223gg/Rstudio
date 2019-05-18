# 작업디렉토리 설정 
getwd()
setwd("~/[004]_BBS")
getwd()






# 한글 자연어 처리
# 워드클라우드
# 패키지 설치 및 로딩
install.packages("KoNLP") 
install.packages("wordcloud") 
library(KoNLP) 
library(wordcloud)



# 한글처리 ####
# 한글 사전 다운로드
# 최초 1회 실행     


# 여러 종류 사전
# useSejongDic()
useNIADic()

# 사용자 단어 추가-1
mergeUserDic(data.frame("하늘공원", "ncn"))
?buildDictionary
# 사용자 단어 추가-2
buildDictionary(ext_dic = c("sejong", "woorimalsam", "insighter"),
                user_dic = data.frame(term="버스킹", tag="ncn"),
                category_dic_nms=c("music"))




# 파일 읽어오기 ####
mapo1 <- readLines("mapo.txt") 

mapo1 


# sapply() 함수를 사용하여
# extractNoun() 함수 실행  ####
mapo2 <- sapply(mapo1, 
                extractNoun, 
                USE.NAMES = FALSE)
mapo2


head(unlist(mapo2), 30) 
mapo3 <- unlist(mapo2) 

mapo3




# 정규표현식을 적용하여
# 불필요한 단어 처리
mapo3 <- gsub("\\d+","", mapo3)
mapo3 <- gsub("\'","", mapo3)
mapo3 <- gsub("[\"]","", mapo3)
mapo3 <- gsub("○○","", mapo3)
mapo3 <- gsub("secret","", mapo3) 
mapo3


# 중간 결과 파일로 저장
write(unlist(mapo3), "data2/mapo_bak1.txt") 
mapo4 <- read.table("data2/mapo_bak1.txt")
mapo4
nrow(mapo4)





# table() 함수를 사용하여
# 빈도분석 수행 ####
wordcount <- table(mapo3)
head(sort(wordcount, decreasing = T), 20)


mapo3 <- gsub("행정과","", mapo3)
mapo3 <- gsub("완료","", mapo3)
mapo3 <- gsub("관련","", mapo3)
mapo3 <- gsub("요청","", mapo3)
mapo3 <- gsub("김","", mapo3)
mapo3 <- gsub("이","", mapo3)
mapo3 <- gsub("박","", mapo3)
mapo3 <- gsub("것","", mapo3)
mapo3 <- gsub("최","", mapo3)
mapo3 <- gsub("축","", mapo3)
mapo3 <- gsub("한","", mapo3)
mapo3 <- gsub("정","", mapo3)
mapo3 <- gsub("동","", mapo3)
mapo3 <- gsub("홍","", mapo3)


write(unlist(mapo3), "data2/mapo_bak2.txt")
mapo4 <- read.table("data2/mapo_bak2.txt")


wordcount <- table(mapo4)
head(sort(wordcount, decreasing = T), 20)


# 색상지정 패키지
# install.packages("RcolorBrewer")
library(RColorBrewer)

# 색상표 확인
display.brewer.all(type = "all")
display.brewer.all(type = "div")
display.brewer.all(type = "qual")
display.brewer.all(type = "seq")

# 색지정 ####
palete <- brewer.pal(8, "Dark2") 



# 워드클라우드 출력 ####
wordcloud(names(wordcount),
          freq = wordcount,
          scale = c(5, 1),
          rot.per = 0.25,
          min.freq = 6,
          random.order = F,
          random.color = T,
          colors = palete)






# 범례출력 ####
legend(0.38, 
       0.85, 
       "마포구민원게시판",
       cex = 0.8, 
       fill = NA, 
       border = NA,
       bg = "white", 
       text.col = "red",
       text.font = 2, 
       box.col = "red")









# 작업디렉토리 해제
getwd()
setwd("~")
getwd()
