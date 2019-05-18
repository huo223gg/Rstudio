[06] 데이터파악, 데이터수정
1. 데이터 분석을 위한 데이터 파악하기

- 분석할 데이터가 확보되면 데이터 특성을 파악하고 다루기 쉽게 변형작업을 한다.

※ 데이터 파악을 위한 함수들 



(1) head(), tail()

- head() 함수는 데이터의 일부만 출력하여 데이터의 형태를 확인한다.
- head()는 데이터의 앞부분을 출력하며 앞에서 6행까지만 출력한다.
출력을 원하는 행의 갯수를 입력하면 그수의 행만큼 앞에서 부터 출력된다.
- tail() 함수는 데이터의 뒤부분에서 6행을 출력한다.
원하는 행의 갯수를 입력하여 그수의 행만큼 뒤에서 부터 출력된다. 

############ R 실습 ##########################

exam <- read.csv("./data/csv_exam.csv")

head(exam)      # 앞에서부터 6행까지 출력
head(exam, 10)  # 앞에서부터 10행까지 출력

tail(exam)      # 뒤에서부터 6행까지 출력
tail(exam, 10)  # 뒤에서부터 10행까지 출력



(2) View(), dim()
- View()는 엑셀과 유사하게 생긴 '뷰어 창'에 원자료를 직접 보여주는 기능을 한다.
- View(exam)을 실행하면 exam이라는 이름의 뷰어 창이 생성됩니다. 
원자료를 직접확인 해보 싶을때 사용합니다.
- dim()은 데이터 프레임이 몇 행, 몇 열로 되어 있는지 알아볼 때 사용한다.

?############ R 실습 ##########################

View(exam)

dim(exam) #행, 열 출력




(3) str(), summary()
- str()는 데이터의 속성을 보여줍니다.
- str()로 출력되는 데이터 속성의 첫행은 데이터의 정보를 간략하게 
보여준다. 
- summary()는 평균처럼 데이터를 요약한 요약 통계량을 산출하는 함수 이다.

※ summary() 요약 통계량


?############ R 실습 ##########################

str(exam)       # 데이터 속성 확인
summary(exam)   # 요약 통계량 출력


str(exam)       # 데이터 속성 확인
#'data.frame': 22 obs. of  5 variables:
# $ id     : Factor w/ 22 levels "1","10","11",..: 1 12 14 15 16 17 18 19 20 2 ...
# $ class  : int  1 1 1 1 2 2 2 2 3 3 ...
# $ math   : int  50 60 45 30 25 50 80 90 20 50 ...
# $ english: int  98 97 86 98 80 89 90 78 98 98 ...
# $ science: int  50 60 78 58 65 98 45 25 15 45 ...

summary(exam)   # 요약 통계량 출력
#       id         class        math          english        science     
# 1      : 1   Min.   :1   Min.   :20.00   Min.   :56.0   Min.   :12.00  
# 10     : 1   1st Qu.:2   1st Qu.:45.75   1st Qu.:78.0   1st Qu.:45.00  
# 11     : 1   Median :3   Median :54.00   Median :86.5   Median :62.50  
# 12     : 1   Mean   :3   Mean   :57.45   Mean   :84.9   Mean   :59.45  
# 13     : 1   3rd Qu.:4   3rd Qu.:75.75   3rd Qu.:98.0   3rd Qu.:78.00  
#14     : 1   Max.   :5   Max.   :90.00   Max.   :98.0   Max.   :98.00  
# (Other):16   NA's   :2   NA's   :2       NA's   :2      NA's   :2      



- math는 학생들의 수학 시험 점수이며 요약 통계량을 보면
평균 :57.45점
최저점수:20점
최고점수:90점
학생들의 수학점수가 54점을 중심으로 45.75에서 75.75점 사이에 몰려있다.



2. mpg 데이터 특성 확인하기
- ggplot2패키지의 mpg데이터의 특성을 확인한다.
- 더불콜론(::)을 이용하면 특정 패키지에 들어있는 함수나 데이터를 지칭할 수 있다.
- ggplot2::mpg란 ggplot2에 들어있는 mpg데이터를 지칭한다.

############### R 실습 #############################

install.packages('ggplot2')
library(ggplot2)
## -------------------------------------------------------------------- ##
# ggplo2의 mpg 데이터를 데이터 프레임 형태로 불러오기
mpg <- as.data.frame(ggplot2::mpg)

head(mpg)     # Raw 데이터 앞부분 확인
tail(mpg)     # Raw 데이터 뒷부분 확인
View(mpg)     # Raw 데이터 뷰어 창에서 확인
dim(mpg)      # 행, 열 출력
str(mpg)      # 데이터 속성 확인

######### mpg 변수 #########################
# $ model     : 자동차 모델명
# $ displ       : 배기량(displacement)
# $ year        : 생산년도
# $ cyl          : 실린더 개수(cylinders)
# $ trans       : 변속기 종류(transmission)
# $ drv         : 구동 방식(drive wheel)
# $ cty         : 도시 연비(city)
# $ hwy        : 고속도로 연비(highway)
# $ fl           : 연료 종류
# $ class       : 자동차 종류
# $ manufacturer : 제조회사
##########################################


summary(mpg)  # 요약 통계량 출력


>>> summary(mpg) 요약 통계량 출력 내용 분석
- 자동차들이 도시에서 평균적으로 갤런당 16.86마일을 주행한다(Mean)
- 연비가 가장 낮은 모델은 갤런당 9마일(Min), 가장 높은 모델은 35마일(Max)을 주행한다.
- 자동차들의 연비가 갤런당 17마일(Median)을 중심으로 14마일에서 19마일 사이(1st Quantile,3rd Quantile)에
몰려있다.

※ 갤런(Gallon)이란 미국에서 휘발유 등의 액체의 양을 표현할 때 많이 사용되는 부피의 단위이다.
1 gallon (gal) 은 정확히 3.785411784 리터입니다.

?mpg    #mpg 설명글 출력




3. 변수명 변경, 파생변수 만들기

(1) 변수명 변경

- 변수명을 이해하기 쉬운 단어로 바꾸면 데이터를 수월하게 다룰 수 있다.
- 변수명이 기억하기 어려운 문자로 되어 있으면 쉬운 단어로 변경하는 것이 좋다.
h0901_4 -> 응답자의 성별 : gender
h09_din -> 소득 : income

- dplyr 패키지의 rename()을 이용해서 변수명을 변경합니다.

############## R 실습 ##############################

df_raw <- data.frame(var1 = c(1, 2, 1),   #두개의 변수로 구성된 데이터 프레임 생성
                     var2 = c(2, 3, 2))
df_raw

install.packages("dplyr")  # dplyr 설치
library(dplyr)                # dplyr 로드

df_new <- df_raw         # 복사본 생성
df_new                       # 출력

df_new <- rename(df_new, v2 = var2)  # var2를 v2로 수정
df_new                  #var2를 v2로 수정된 데이터 출력
df_raw                  #변경전 원본데이터 출력



-----------------------------------------------------------------------------------
  ※ 혼자 해보기 ※

Q1 ggplot2 패키지 mpg데이터 불러와서 복사본 만들기


Q2 복사본 데이터를 이용해서 cty를 city로, hwy를 highway로 수정하기


Q3 데이터 일부를 출력해 변수명이 바뀌었는지 확인해 본다.


다음과 같이 출력이 되어야 한다.





----------------------------------------------------------------------------------------------
  
  
  
  
  
  (2) 파생변수 만들기

- 변수를 조합하거나 함수를 적용해 새 변수를 만들어 분석할 수 있다.
- 여러과목의 시험 점수를 조합해 전과목 평균 변수를 만들수 있다.
이처럼 기존의 변수를 변형해  만든 변수를 파생변수(Derived Variable)라 한다.

1) 데이터 프레임의 변수를 조합해 파생변수를 만든다.

################### R 실습 ########################

df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))
df

df$var_sum <- df$var1 + df$var2       # var_sum 파생변수 생성
df

df$var_mean <- (df$var1 + df$var2)/2  # var_mean 파생변수 생성
df



2) mpg데이터를 이용해서 파생변수 만들기
- mpg의 연비는 도시연비(cty)와 고속도로 연비(hwy)이다. 
도로 유형을 통틀어 어떤 자동차 모델의 연비가 가장 높은지 분석할 수 없다.
하나로 통합된 연비변수가 필요.
- cty와 hwy를 더해 2로 나누어 도로 유형을 통합한 연비 변수를 만듭니다.

head(mpg)


#  manufacturer model displ year cyl      trans drv cty hwy fl   class
#1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact
#2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact
#3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact
#4         audi    a4   2.0 2008   4   auto(av)   f  21  30  p compact
#5         audi    a4   2.8 1999   6   auto(l5)   f  16  26  p compact
#6         audi    a4   2.8 1999   6 manual(m5)   f  18  26  p compact

mpg$total <- (mpg$cty + mpg$hwy)/2  # 통합 연비 변수 생성
head(mpg)
mean(mpg$total)  # 통합 연비 변수 평균


head(mpg)
#manufacturer model displ year cyl      trans drv cty hwy fl   class total
#1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact  23.5
#2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact  25.0
#3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact  25.5
#4         audi    a4   2.0 2008   4   auto(av)   f  21  30  p compact  25.5
#5         audi    a4   2.8 1999   6   auto(l5)   f  16  26  p compact  21.0
#6         audi    a4   2.8 1999   6 manual(m5)   f  18  26  p compact  22.0

mean(mpg$total)  # 통합 연비 변수 평균
#[1] 20.14957



3) 조건문함수를 활용해 파생변수 만들기

- 전체 자동차 중에서 연비 기준을 충족해 '고연비 합격 판정'을 받은 자동차가 몇대나
되는지 알아보는 상황을 가정한다.
- 연비가 기준치를 넘기면 합격 넘기지 못하면 불합격을 판단한다.

- 몇을 기준으로 합격여부를 파단할지 결정 하기위해  summary()를 이용하여  total의 평균값과 중간값을
확인합니다.

summary(mpg$total)  # 요약 통계량 산출

#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#  10.50   15.50   20.50   20.15   23.50   39.50 

- 히스토그램을 생성해 자동차들의 연비 분포를 알아본다. 히스토그램은 값의 빈도를 막대 길이로 표현한 
그래프이다.

hist(mpg$total)     # 히스토그램 생성



※ 요약 통계량과 히스토그램을 통해서 아래와 같은 사실을 알 수 있다
- total연비의 평균과 중앙값이 약 20이다.
- total연비가 20~25 사이에 해당하는 자동차 모델이 가장 많다.
- 대부분이 25이하이고, 25를 넘기는 자동차는 많지 않다.


- 조건에 따라 다른 값을 반환하는 조건문 함수를 이용하여 합격 판정 변수 만든다.
ifelse()는 가장 많이 사용하는 조건문 함수 이다.



# 20이상이면 pass, 그렇지 않으면 fail 부여
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")

head(mpg, 20) 

#   manufacturer              model displ year cyl      trans drv cty hwy fl   class total test
#1          audi                 a4   1.8 1999   4   auto(l5)   f  18  29  p compact  23.5 pass
#2          audi                 a4   1.8 1999   4 manual(m5)   f  21  29  p compact  25.0 pass
#3          audi                 a4   2.0 2008   4 manual(m6)   f  20  31  p compact  25.5 pass
#4          audi                 a4   2.0 2008   4   auto(av)   f  21  30  p compact  25.5 pass
#5          audi                 a4   2.8 1999   6   auto(l5)   f  16  26  p compact  21.0 pass
#6          audi                 a4   2.8 1999   6 manual(m5)   f  18  26  p compact  22.0 pass
#7          audi                 a4   3.1 2008   6   auto(av)   f  18  27  p compact  22.5 pass
#8          audi         a4 quattro   1.8 1999   4 manual(m5)   4  18  26  p compact  22.0 pass
#9          audi         a4 quattro   1.8 1999   4   auto(l5)   4  16  25  p compact  20.5 pass
#10         audi         a4 quattro   2.0 2008   4 manual(m6)   4  20  28  p compact  24.0 pass
:
  
  생략 


table(mpg$test)   # 연비 합격 빈도표 생성

# fail   pass 
# 106  128 

- 합격 판정의 결과로 막대 그래프 만들기

qplot(mpg$test)   # 연비 합격 빈도 막대 그래프 생성





- 중첩조건문 활용하여 기준을 세종류로 변경
ifelse()안에 ifelse()함수를 넣어서 작성한다.

A : 30이상, B : 20~29, C : 20미만

################# R 실습 ####################

# total을 기준으로 A, B, C 등급 부여
mpg$grade <- ifelse(mpg$total >= 30, "A",
                    ifelse(mpg$total >= 20, "B", "C"))

head(mpg, 20)     # 데이터 확인

table(mpg$grade)  # 등급 빈도표 생성

#  A   B   C 
# 10 118 106 

qplot(mpg$grade)  # 등급 빈도 막대 그래프 생성



--------------------------------------------------------------------------------
  ※ 혼자 해보기 ※ 
Q1. 아래 주석에 맞는 내용을 작성해보자


#1. 데이터 준비, 패키지 준비
#ggplot2로드

#dplyr로드

#ggplot2패키지의 mpg가져오기


#2.데이터파악하기
#데이터 앞부분

#데이터 뒷부분

#데이터 뷰어창에서 확인

#차원보기

#속성보기

#요약통계량 보기

#3.변수명 변경
#manufacturerf를 company로 변경

#4.파생변수 생성
#통합연비 total


#total의 값이 20보다 크면 pass, 아니면 fail저장하는 test 만들기

#5.test의 빈도확인 table, qplot

-----------------------------------------------------------------------------
  
  