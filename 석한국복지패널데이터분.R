한국복지패널데이터:
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
#데이터 파악 함ㅅ
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

# 결측치 확인 9가 없으므로 폴스로 있는 수만큼 카운트함.
table(is.na(welfare$gender)

table(welfare$gender)

#- 성별 변수의 값이 1,2대신 이해하기 쉽게 male,female로 변경한다.

welfare$gender <- ifelse(welfare$gender == 1, "male", "female")
#  - qplot()는 최대값까지 출력되는데 대다수 차지하는 0~1000까지의 값이 잘 안나옴으로 
#   x축값을 0~1000값으로 조정을 한다.


class(welfare$income)
summary(welfare$income)
qplot(welfare$income)  #대다수 차지하는 0~1000까지의 값이 잘 안나옴
qplot(welfare$income) + xlim(0, 1000)

# - summary()로 이상치를 확인해 보면 최소값이 0이므로 0과 9999에 대해서 결측값 처리를 한다.
welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)
table(is.na(welfare$income))

gender_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(gender) %>%
  summarise(mean_income = mean(income))

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
welfare$age<-2015- welfare$birth+1
summary(welfare$age)

age_income <- welfare %>%  #기본데이터에서
  filter(!is.na(income)) %>%    #월급의 결측치가 없는 데이터만
  group_by(age) %>%           #나이별 그룹으로 
  summarise(mean_income = mean(income))  #월급 평균을 구한다.
2) 그래프 생성
- x축 나이, y축 월급으로 나이에 따른 월급의 변화를 선그래프로 생성한다
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
#mutate는 자주 사용됨. 다시 할당하지 않으면 안되므로 다시 할당

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
#1 middle    281.8871때
#3  young    163.5953

ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + geom_col()

ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old")) #x축 기준으로 정렬할 때

1. 연령대 및 성별 월급 차이 

(1) 1단계 - 변수 검토 및 전처리 

- 연령대, 성별, 월급 검토 및 전처리 앞에서 완료

(2) 2단계 - 변수 간 관계 분석 

1) 연령대 및 성별 월급 평균표 생성

################### R 실습 ########################
ageg_gender_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg, gender) %>%                 #연령대별 및 성별 그룹으로
  summarise(mean_income = mean(income))  #월급 평균을 생성

※참고) 소숫점 2자리까지 나오는 방법

ageg_gender_income = welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg,gender) %>% 
  summarise(mean_income=formatC(mean(income), digits = 2, format = "f"))

ggplot(data = ageg_gender_income, aes(x = ageg, y = mean_income, fill = gender)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))

- 독립된 막대로 성별을 표시
- 순서대로 "young", "middle", "old"
- 막대에서는 fill = gender
ggplot(data = ageg_gender_income, aes(x = ageg, y = mean_income, fill = gender)) +
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young", "middle", "old"))

3) 연령대로 구분하지 않고 나이 및 성별 월급 평균표 작성하여 그래프 그리기

gender_age <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age, gender) %>%
  summarise(mean_income = mean(income))

- 라인에서는 col = gender
ggplot(data = gender_age, aes(x = age, y = mean_income, col = gender)) + geom_line()

