[10] 데이터분석 실습 - 한국복지패널 데이터 1
1. 데이터 분석 - 한국인의 삶을 파악하기1
- 앞에서 배운 분석기술을 실습한다.
- 한국 복지패널데이터를 이용해서 분석한다.



※ 한국복지패널데이터:
  한국보건사회연구원에서 가구의 경제 활동을 연구해 정책지원에 반영할 목적으로 발간하는 조사 자료이다.
2006~2015년까지 전국 7000여 가구를 선정해 매년 추적 조사한 자료로, 경제활동, 생활실태, 복지 요구등
수천 개 변수에 대한 정보를 담고 있다.

(1) 데이터 준비
- 제공된 Koweps_hpc10_2015_beta1.sav 파일을 testR/data/10/폴더에 넣는다.
- 위 파일은 2016년에 발간된 한국복지패널데이터로, 6,914가구의 16,664명에 대한
정보를 담고 있다.
- 한국복지패널 사이트 회원가입하면 데이터를 무료로 다운 가능하며, 상용 통계분석
소프트웨어(SPSS, SAS, STATA) 전용파일로 제공된다.

(2) 데이터 R로 불러오기

1) 패키지 설치 및 로드
- 실습에 사용할 복지패널데이터는 통계분석 소프트웨어 SPSS 전용파일이다.
- foreign 패키지의 함수를 이용하여 SPSS, SAS, STATA등 통계분석 소프트웨어 파일을 불러올수 있다.

install.packages("foreign")  # foreign 패키지 설치

library(foreign)             # SPSS 파일 로드
library(dplyr)               # 전처리
library(ggplot2)             # 시각화
library(readxl)              # 엑셀 파일 불러오기


2) R의 데이터프레임으로 데이터 가져오기

# 데이터 불러오기
raw_welfare <- read.spss(file = "./data/10/Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)


# 복사본 만들기
welfare <- raw_welfare


3) 데이터 검토하기

head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)


4) 알기쉬운 변수명으로 변경하기
- 규모가 큰 자료는 보통 데이터의 특성을 설명해 놓은 코드북(Codebook)과 함께 제공됩니다.
- Koweps_Codebook.xlsx는 제공하는 코드북입니다.
- 코드북을 보면 데이터의 특성을 알수 있으므로 어떤 변수를 활용할지 분석방향에 도움을
받을 수 있다.

- 분석에 사용할 7개의 변수의 이름을 쉬운 단어로 변경한다.


welfare <- rename(welfare,
                  gender= h10_g3,             # 성별
                  birth = h10_g4,               # 태어난 연도
                  marriage = h10_g10,        # 혼인 상태
                  religion = h10_g11,          # 종교
                  income = p1002_8aq1,     # 월급
                  code_job = h10_eco9,      # 직종 코드
                  code_region = h10_reg7)  # 지역 코드



(3) 데이터 분석 절차

1 단계 : 변수 검토 및 전처리
- 분석에 사용할 변수들을 전처리한다.
- 변수의 특성을 파악하고 이상치를 정제한 다음 파생변수 생성한다.
- 전처리는 분석에 활용할 변수 각각에 대해 실시한다.
- 성별에 따른 월급차이를 분석한다면 성별 및 월급 두변수 각각 전처리한다.

2 단계 : 변수 간 관계 분석
- 전처리가 완료되면 본격적으로 변수 간 관계를 파악하는 분석을 한다.
- 데이터 요약표를 만든 후 분석 결과를 쉽게 이해할 수 있는 그래프를 생성한다.





2. 성별에 따른 월급 차이 

(1) 1단계 - 변수 검토 및 전처리

1)성별 변수 검토 및 전처리

- class()로 성별의 변수 타입을 파악한다.
- table()로 각범주(남,여)에 몇명인지 확인한다.
- numeric 타입, 1,2로 구성 

################### R 실습 ########################
class(welfare$gender)
table(welfare$gender)

#  - 코드북 확인하기( Koweps_Codebook.xlsx)
#  - 성별의 구분이 1은남자, 2는 여자, 9는 모름/무응답 이다.
#  - 9의 값은 성별이 확인이 안되므로 결측값(NA)처리한다.


# 이상치 확인 -> 현재의 데이터는 9는 없다.
table(welfare$gender)

# 이상치 결측 처리-> 만약 존재한다면 ifelse()로 9를 NA로 결측처리한다.
welfare$gender <- ifelse(welfare$gender == 9, NA, welfare$gender)

# 결측치 확인
table(is.na(welfare$gender))


#- 성별 변수의 값이 1,2대신 이해하기 쉽게 male,female로 변경한다.

# 성별 항목 이름 부여
welfare$gender <- ifelse(welfare$gender == 1, "male", "female")

#- 변경된 값을 table(), qplot()로 확인하다.

table(welfare$gender)
qplot(welfare$gender)






2) 월급 변수 검토 및 전처리

- 코드북의 월급은 1만원단위이며, income(월급)을 검토하고 분포를 확인하다.
- 연속 변수는 table()(범주가 많을시 데이터항목이 많아진다)보다 summary()로
요약 통계량을 확인해서 특징을 파악한다.
- qplot()를 이용해서 분포를 그래프로 확인한다.


################### R 실습 ########################

class(welfare$income)

#[1] "numeric"

summary(welfare$income)

#   Min. 1st Qu.  Median   Mean   3rd Qu.    Max.    NA's 
#  0.0   122.0   192.5      241.6   316.6     2400.0   12030 

#  - 0~2400만원 사이값을 지니며, 중값값이 평균값보다 작으므로 낮은쪽에 치우쳐 있다.
#  -122~316만원 사이값에 가장 많이 분포되어있다.

#  - qplot()는 최대값까지 출력되는데 대다수 차지하는 0~1000까지의 값이 잘 안나옴으로 
#   x축값을 0~1000값으로 조정을 한다.


class(welfare$income)
summary(welfare$income)
qplot(welfare$income)  #대다수 차지하는 0~1000까지의 값이 잘 안나옴
qplot(welfare$income) + xlim(0, 1000)




# - 코드북의 월급은 1~9998사이값을 가지며, 모름/무응답은 9999 이다.
# - summary()로 이상치를 확인해 보면 최소값이 0이므로 0과 9999에 대해서 결측값 처리를 한다.

summary(welfare$income)

#   Min. 1st Qu.  Median   Mean   3rd Qu.    Max.    NA's 
#    0.0   122.0   192.5      241.6   316.6      2400.0   12030 

welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)

table(is.na(welfare$income))

#FALSE  TRUE 
# 4620 12044 



(2) 2단계 - 변수 간 관계 분석

1) 성별 월급 평균표 생성

- 두변수의 전처리 작업이후 변수 간 관계를 분석한다.

################### R 실습 ########################

gender_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(gender) %>%
  summarise(mean_income = mean(income))

gender_income
# A tibble: 2 x 2
#  gender mean_income
#   <chr>       <dbl>
#1 female    163.2471
#2   male    312.2932


2) 그래프 생성
- 분석결과를 그래프로 만들어 쉽게 이해할 수 있도록 한다.
- 막대그래프는 + geom_col() 추가로 만들수 있다.

ggplot(data = gender_income, aes(x = gender, y = mean_income)) + geom_col()






3. 나이와 월급의 관계 

(1) 1단계 - 변수 검토 및 전처리 

1) 월급은 전처리가 완료되었으므로 나이의 전처리만 한다.
- 나이변수는 태어난연도를 이용해서 만들어야 한다.
- 태어난 연도 검토한다.


################### R 실습 ########################

class(welfare$birth)

#[1] "numeric"

summary(welfare$birth)

#   Min. 1st Qu.  Median   Mean  3rd Qu.    Max. 
#   1907    1946    1966    1968    1988      2014 

qplot(welfare$birth)


#- 코드북을 보면 1900년도~2014년도 사이의 값을 지니며, 모름/무응답은 9999  이다
#- 이상치 확인후 만약 존재한다면 전처리 작업을 해줘야 하다.
#- 현재 데이터는 이상치(9999)나 NA(결측치)가 없다.

# 이상치 확인->없음
summary(welfare$birth) 

# 결측치 확인->없음
table(is.na(welfare$birth))

# 이상치 결측 처리->없으므로 생략 가능
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
table(is.na(welfare$birth))


#- 태어난 연도를 이용해 파생변수를 만든다.
#- 2015년도에 조사한 내용이므로  나이=  2015-태어난연도 를 하면된다.


welfare$age <- 2015 - welfare$birth + 1

summary(welfare$age)

#   Min. 1st Qu.  Median  Mean  3rd Qu.  Max. 
#   2.00   28.00   50.00    48.43    70.00    109.00 


qplot(welfare$age)




(2) 2단계 - 변수 간 관계 분석 

1) 나이별 월급 평균표 생성

################### R 실습 ########################

age_income <- welfare %>%  #기본데이터에서
  filter(!is.na(income)) %>%    #월급의 결측치가 없는 데이터만
  group_by(age) %>%           #나이별 그룹으로 
  summarise(mean_income = mean(income))  #월급 평균을 구한다.


head(age_income)

# A tibble: 6 x 2
#    age mean_income
#  <dbl>       <dbl>
#1    20    121.3000
#2    21    105.5185
#3    22    130.0923
#4    23    141.7157
#5    24    134.0877
#6    25    144.6559



2) 그래프 생성
- x축 나이, y축 월급으로 나이에 따른 월급의 변화를 선그래프로 생성한다.

ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()





4. 연령대에 따른 월급 차이 

(1) 1단계 - 변수 검토 및 전처리 

- 연령대 변수(ageg)는 앞에서 만든 나이변수(age)로 만들 수 있다.
- 초년(30미만), 중년(30~59세), 노년(60세이상)이란 범주를 만들고
각 범주에 몇명이 있는지 확인한다.

################### R 실습 ########################

welfare <- welfare %>%
  mutate(ageg = ifelse(age < 30, "young",
                       ifelse(age <= 59, "middle", "old")))

table(welfare$ageg)

#middle    old  young 
#  6049   6281   4334 

qplot(welfare$ageg)



(2) 2단계 - 변수 간 관계 분석 

1) 연련대별 월급 평균표 생성

################### R 실습 ########################

ageg_income <- welfare %>%   #기본데이터에서
  filter(!is.na(income)) %>%       #월급에서 결측치없이
  group_by(ageg) %>%            #연령대별로
  summarise(mean_income = mean(income)) #평균급여를 생성한다.

ageg_income
# A tibble: 3 x 2
#    ageg mean_income
#   <chr>       <dbl>
#1 middle    281.8871
#2    old    125.3295
#3  young    163.5953



2) 그래프 생성

ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + geom_col()



- 연령대별의 나이순으로 막대를 정렬하려면  scale_x_discrete(limits = c("young", "middle", "old")) 지정한다.

ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))

