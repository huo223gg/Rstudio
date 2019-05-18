[11] 데이터 분석 실습 - 한국인의 삶을 파악하기2
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


ageg_gender_income

# A tibble: 6 x 3
# Groups:   ageg [?]
#    ageg gender mean_income
#   <chr>  <chr>       <dbl>
#1 middle  female   187.97552
#2 middle    male   353.07574
#3    old   female    81.52917
#4    old     male   173.85558
#5  young  female   159.50518
#6  young   male   170.81737


※참고) 소숫점 2자리까지 나오는 방법

ageg_gender_income = welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg,gender) %>% 
  summarise(mean_income=formatC(mean(income), digits = 2, format = "f"))

ageg_gender_income



2) 그래프 생성
- 연령대 별로 표시되므로 x축에 ageg를 지정하며 성별에 따라 다른 색으로 표현되도록
fill = gender를 명시합니다.
- 연령대 순으로 정렬을 위해서 scale_x_discrete(limits = c("young", "middle", "old"))  지정한다.

ggplot(data = ageg_gender_income, aes(x = ageg, y = mean_income, fill = gender)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))





- 독립된 막대로 성별을 표시하기 위해서   geom_col(position = "dodge")

ggplot(data = ageg_gender_income, aes(x = ageg, y = mean_income, fill = gender)) +
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young", "middle", "old"))




3) 연령대로 구분하지 않고 나이 및 성별 월급 평균표 작성하여 그래프 그리기

gender_age <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age, gender) %>%
  summarise(mean_income = mean(income))


head(gender_age)

# A tibble: 6 x 3
# Groups:   age [3]
#    age gender mean_income
#  <dbl>  <chr>       <dbl>
#1    20 female    147.4500
#2    20   male     69.0000
#3    21 female    106.9789
#4    21   male    102.0500
#5    22 female    139.8547
#6    22   male    118.2379


ggplot(data = gender_age, aes(x = age, y = mean_income, col = gender)) + geom_line()








2. 직업별 월급 차이 

(1) 1단계 - 변수 검토 및 전처리 

1) 월급의 변수검토 및 전처리를 되어있으므로 직업에 대한 변수 검토 및 전처리를 하나.
- code_job변수는 직업분류코드이다 이변수를 파악하여 직업 명칭 변수를 만든다.


################### R 실습 ########################

class(welfare$code_job)

table(welfare$code_job)


#- 코드북(Koweps_Codebook.xlsx)의 직종코드 sheet 에서 직업 명칭을 가져온다.
#- left_join()으로 job변수를 welfare에 결합하다. 공통변수 code_job을 기준으로 결합한다.


library(readxl) #엑셀에서 읽어오는 함수가 들어있는 패키지 로등

list_job <- read_excel("./data/12/Koweps_Codebook.xlsx", col_names = T, sheet = 2) #엑셀파일 읽어오기


head(list_job)

# A tibble: 6 x 2
#  code_job                                 job
#     <dbl>                               <chr>
#1      111 의회의원 고위공무원 및 공공단체임원
#2      112                        기업고위임원
#3      120             행정 및 경영지원 관리자
#4      131       연구 교육 및 법률 관련 관리자
#5      132                 보험 및 금융 관리자
#6      133        보건 및 사회복지 관련 관리자


dim(list_job)
#[1] 149   2


welfare <- left_join(welfare, list_job, id = "code_job")  #id 기준으로 welfare데이터에 직업 분류를 새로운 열로 조인
#Joining, by = "code_job"


welfare %>%
  filter(!is.na(code_job)) %>%
  select(code_job, job) %>%
  
  head(10)
#   code_job                                job
#1       942                   경비원 및 검표원
#2       762                             전기공
#3       530 방문 노점 및 통신 판매 관련 종사자
#4       999        기타 서비스관련 단순 종사원
#5       312                    경영관련 사무원
#6       254             문리 기술 및 예능 강사
#7       510                        영업 종사자
#8       530 방문 노점 및 통신 판매 관련 종사자
#9       286   스포츠 및 레크레이션 관련 전문가
#10      521                   매장 판매 종사자 




(2) 2단계 - 변수 간 관계 분석 

1) 직업별 월급 평균표 만들기


################### R 실습 ########################

job_income <- welfare %>%                   
  filter(!is.na(job) & !is.na(income)) %>%         
  group_by(job) %>%
  summarise(mean_income = mean(income))


head(job_income)



2) 월급을 내림차순으로 정렬후 상위10위까지 출력

top10 <- job_income %>%
  arrange(desc(mean_income)) %>%
  head(10)


top10

# A tibble: 10 x 2
#                                    job mean_income
#                                  <chr>       <dbl>
# 1      금속 재료 공학 기술자 및 시험원    845.0667
# 2                      의료진료 전문가    843.6429
# 3  의회의원 고위공무원 및 공공단체임원    750.0000
# 4                  보험 및 금융 관리자    726.1800
# 5                     제관원 및 판금원    572.4067
# 6              행정 및 경영지원 관리자    563.7633
# 7 문화 예술 디자인 및 영상 관련 관리자    557.4667
#8        연구 교육 및 법률 관련 관리자    549.9125
# 9        건설 전기 및 생산 관련 관리자    535.8056
#10       석유 및 화학물 가공장치 조작원    531.6600



3) 그래프 생성
- x축 직업명이 겹쳐 보여 잘 안보이므로 오른쪽으로 90도 회전해서 보기위해 coord_flip()를 추가한다.

ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) +
  geom_col() +
  coord_flip()



- 직업을 하위10위로 정렬하여 그래프로 그려본다.

bottom10 <- job_income %>%
  arrange(mean_income) %>%
  head(10)


bottom10

# A tibble: 10 x 2
#                            job mean_income
#                          <chr>       <dbl>
# 1          가사 및 육아 도우미    80.16648
# 2              임업관련 종사자    83.33000
# 3  기타 서비스관련 단순 종사원    88.22101
# 4        청소원 및 환경 미화원    88.78775
# 5               약사 및 한약사    89.00000
# 6              작물재배 종사자    92.00000
# 7     농립어업관련 단순 종사원   101.58125
# 8 의료 복지 관련 서비스 종사자   103.52643
# 9         음식관련 단순 종사원   107.84511
#10         판매관련 단순 종사원   116.82203



ggplot(data = bottom10, aes(x = reorder(job, -mean_income), 
                            y = mean_income)) +
  geom_col() + 
  coord_flip() + 
  ylim(0, 850)   #하위순위의 월급 평균이 최대100이 안되므로 상위10위비교하기 위해 y축을 지정하였다.








3. 성별 직업 빈도 

(1) 1단계 - 변수 검토 및 전처리 

1) 성별 및 직업의 검토및 전처리 완료됨


(2) 2단계 - 변수 간 관계 분석 

1) 성별 직업 빈도표 생성
- 성별로 직업빈도표를 구해 상위 10개 생성


################### R 실습 ########################

# 남성 직업 빈도 상위 10개 추출
job_male <- welfare %>%
  filter(!is.na(job) & gender == "male") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)


job_male

# A tibble: 10 x 2
#                        job     n
#                      <chr> <int>
# 1          작물재배 종사자   640
#2            자동차 운전원   251
# 3          경영관련 사무원   213
# 4              영업 종사자   141
# 5         매장 판매 종사자   132
# 6     제조관련 단순 종사원   104
# 7    청소원 및 환경 미화원    97
# 8 건설 및 광업 단순 종사원    95
# 9         경비원 및 검표원    95
#10              행정 사무원    92


# 여성 직업 빈도 상위 10개 추출
job_female <- welfare %>%
  filter(!is.na(job) & gender == "female") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)


job_female

# A tibble: 10 x 2
#                            job     n
#                          <chr> <int>
# 1              작물재배 종사자   680
# 2        청소원 및 환경 미화원   228
# 3             매장 판매 종사자   221
#4         제조관련 단순 종사원   185
# 5          회계 및 경리 사무원   176
# 6            음식서비스 종사자   149
# 7             주방장 및 조리사   126
# 8          가사 및 육아 도우미   125
# 9 의료 복지 관련 서비스 종사자   121
#10         음식관련 단순 종사원   104





2) 그래프 생성

# 남성 직업 빈도 상위 10개 직업

ggplot(data = job_male, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()





# 여성 직업 빈도 상위 10개 직업

ggplot(data = job_female, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()






4. 지역별 연령대 비율 

(1) 1단계 - 변수 검토 및 전처리

1) 지역 변수 검토 및 전처리
- code_region 변수의 값은 7개로 나누어진 지역 코드이다.
- 코드북의 내용을 참조하여 지역명 변수를 추가한다.


################### R 실습 ########################

class(welfare$code_region)
table(welfare$code_region)

# 지역 코드 목록 만들기
list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(인천/경기)",
                                     "부산/경남/울산",
                                     "대구/경북",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주도"))



list_region

#  code_region                region
#1           1                  서울
#2           2     수도권(인천/경기)
#3           3        부산/경남/울산
#4           4             대구/경북
#5           5             대전/충남
#6           6             강원/충북
#7           7 광주/전남/전북/제주도


# 지역명 변수 추가 
welfare <- left_join(welfare, list_region, id = "code_region")

welfare %>%
  select(code_region, region) %>%
  head

#  code_region region
#1           1   서울
#2           1   서울
#3           1   서울
#4           1   서울
#5           1   서울
#6           1   서울




(2) 2단계 - 변수 간 관계 분석 

1) 지역별 연령대 비율표 만들기

region_ageg <- welfare %>%
  group_by(region, ageg) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 2))


head(region_ageg)

# A tibble: 6 x 5
# Groups:   region [2]
#                 region   ageg     n tot_group   pct
#                 <fctr>  <chr> <int>     <int> <dbl>
#1             강원/충북 middle   417      1257 33.17
#2             강원/충북    old   555      1257 44.15
#3             강원/충북  young   285      1257 22.67
#4 광주/전남/전북/제주도 middle   947      2922 32.41
#5 광주/전남/전북/제주도    old  1233      2922 42.20
#6 광주/전남/전북/제주도  young   742      2922 25.39



2) 그래프 생성
- 연령대 비율 막대를 서로 다른색으로 표현하도록 aes의 fill = ageg 지정한다.
- 지역별로 비교가 쉽도록 coord_flip()를 추가해서 오른쪽으로 90도 회전한다.

ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip()




3) 노년층 비율 높은 순으로 막대 정렬하기

# 노년층 비율 오름차순 정렬
list_order_old <- region_ageg %>%
  filter(ageg == "old") %>%
  arrange(pct)


list_order_old
# A tibble: 7 x 5
# Groups:   region [7]
#                 region  ageg     n tot_group   pct
#                 <fctr> <chr> <int>     <int> <dbl>
#1     수도권(인천/경기)   old  1109      3711 29.88
#2                  서울   old   805      2486 32.38
#3             대전/충남   old   527      1467 35.92
#4        부산/경남/울산   old  1124      2785 40.36
#5 광주/전남/전북/제주도   old  1233      2922 42.20
#6             강원/충북   old   555      1257 44.15
#7             대구/경북   old   928      2036 45.58


- 지역명이 노년층 비율순으로 정렬된 order변수를 활용하여 그래프 생성한다.
# 지역명 순서 변수 만들기

order <- list_order_old$region


order

#[1] 수도권(인천/경기)     서울                  대전/충남             부산/경남/울산       
#[5] 광주/전남/전북/제주도 강원/충북             대구/경북            
#7 Levels: 강원/충북 광주/전남/전북/제주도 대구/경북 대전/충남 부산/경남/울산 ... 수도권(인천/경기)


- 막대가 노년층 비율이 높은순으로   
ggplot(data = region_ageg, aes(x = region,  y = pct, fill = ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)



4) 연령대 순으로 막대 색깔 나열하기
- 초년, 중년, 노년의 연령대순으로 나열한다.
- 연령대 별 막대그래프의 색상을 순서대로 나열하기 위해 fill= 변수의범주(ageg) 해야한다.
- ageg는 범주가 아니므로 factor()로 factor로 변환하고 level파라미터를 이용해 순서를 지정한다.

class(region_ageg$ageg)

#[1] "character"


levels(region_ageg$ageg)

#NULL


region_ageg$ageg <- factor(region_ageg$ageg,       #factor로 변환 및 level지정
                           level = c("old", "middle", "young"))


class(region_ageg$ageg)

#[1] "factor"


levels(region_ageg$ageg)

#[1] "old"    "middle" "young" 


- 그래프 생성

ggplot(data = region_ageg, aes(x = region,  y = pct, fill = ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)

