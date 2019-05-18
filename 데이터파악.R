exam <- read.csv("./data/csv_exam.csv")

head(exam)      # 앞에서부터 6행까지 출력
head(exam, 10)  # 앞에서부터 10행까지 출력

tail(exam)      # 뒤에서부터 6행까지 출력
tail(exam, 10)  # 뒤에서부터 10행까지 출력
View(exam)

dim(exam) #행, 열 출력
str(exam)       # 데이터 속성 확인
summary(exam)   # 요약 통계량 출력


install.packages('ggplot2')
library(ggplot2)
mpg = as.data.frame(ggplot2::mpg)
head(mpg)     # Raw 데이터 앞부분 확인
tail(mpg)     # Raw 데이터 뒷부분 확인
View(mpg)     # Raw 데이터 뷰어 창에서 확인
dim(mpg)      # 행, 열 출력
str(mpg)      # 데이터 속성 확인

summary(mpg)  # 요약 통계량 출력
############## R 실습 ##############################

df_raw <- data.frame(var1 = c(1, 2, 1),   #두개의 변수로 구성된 데이터 프레임 생성
                     var2 = c(2, 3, 2))
df_raw

install.packages('dplyr')
library(dplyr)

# ※ 혼자 해보기 ※
# Q1 ggplot2 패키지 mpg데이터 불러와서 복사본 만들기

mpg2 = as.data.frame(ggplot2::mpg)
 
# Q2 복사본 데이터를 이용해서 cty를 city로, hwy를 highway로 수정하기
mpg2 <- rename(mpg2, city = cty,highway=hwy) 
# Q3 데이터 일부를 출력해 변수명이 바뀌었는지 확인해 본다.
head(mpg2)

df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))
df

df$var_sum <- df$var1 + df$var2       # var_sum 파생변수 생성
df

df$var_mean <- (df$var1 + df$var2)/2  # var_mean 파생변수 생성
df

mpg$total <- (mpg$cty + mpg$hwy)/2  # 통합 연비 변수 생성
head(mpg)
mean(mpg$total)  # 통합 연비 변수 평균

summary(mpg$total)

hist(mpg$total)     # 히스토그램 생성

mpg$test = ifelse(mpg$total >= 20,'pass','fail')

head(mpg$test,20)

table(mpg$test)

qplot(mpg$test)
qplot(mpg$test)
library(ggplot2)

mpg$grade = ifelse(mpg$total >= 30, 'A',
                   ifelse(mpg$total>=20,'B','C'))

head(mpg,20)
table(mpg$grade)
qplot(mpg$grade)

# ※ 혼자 해보기 ※ 
# Q1. 아래 주석에 맞는 내용을 작성해보자


#1. 데이터 준비, 패키지 준비
#ggplot2로드
library(ggplot2)
#dplyr로드
library(dplyr)
#ggplot2패키지의 mpg가져오기
mpg_new = as.data.frame(ggplot2::mpg)

#2.데이터파악하기
#데이터 앞부분
head(mpg_new)
#데이터 뒷부분
tail(mpg_new)
#데이터 뷰어창에서 확인
View(mpg_new)
#차원보기
dim(mpg_new)
#속성보기
str(mpg_new)
#요약통계량 보기
summary(mpg_new)
#3.변수명 변경
#manufacturerf를 company로 변경
mpg_new = rename(mpg_new,company=manufacturer)

#4.파생변수 생성
#통합연비 total
mpg_new$total = (mpg_new$cty + mpg_new$hwy)/2
head(mpg_new)
#total의 값이 20보다 크면 pass, 아니면 fail저장하는 test 만들기
mpg_new$test = ifelse(mpg_new$total >= 20,'pass','fail')
head(mpg_new)
#5.test의 빈도확인 table, qplot
table(mpg_new$test)
qplot(mpg_new$test)








