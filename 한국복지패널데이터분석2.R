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

welfare <- left_join(welfare, list_job, id = "code_job")  #id 기준으로 welfare데이터에 직업 분류를 새로운 열로 조인
#Joining, by = "code_job"
#조인 상태 확ㅇ
welfare %>%
  filter(!is.na(code_job)) %>%
  select(code_job, job) %>%
  head(10)

(2) 2단계 - 변수 간 관계 분석 

1) 직업별 월급 평균표 만들기


################### R 실습 ########################

job_income <- welfare %>%                   
  filter(!is.na(job) & !is.na(income)) %>%         
  group_by(job) %>%
  summarise(mean_income = mean(income))


head(job_income)
#상위 10위 내림차순으로 정렬 .
top10 <- job_income %>%
  arrange(desc(mean_income)) %>%
  head(10)

3) 그래프 생성
- x축 직업명이 겹쳐 보여 잘 안보이므로 오른쪽으로 90도 회전해서 보기위해 coord_flip()를 추가한다.

ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) +
  geom_col() +
  coord_flip() #x축을 뒤집어서 표기 항목이 깨어지므로 전환함.
#하위 10위 내림차순으로 정렬 
bottom10 <- job_income %>%
  arrange(mean_income) %>%
  head(10)

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
  summarise(n = n()) %>% #빈도값을 구하는 함ㅅ
  arrange(desc(n)) %>%수 #빈도로 정ㄹ
  head(10)

ggplot(data = job_male, aes(x = reorder(job, n), y = n)) +
  geom_col()+
  coord_flip()

# 여성 직업 빈도 상위 10개 추출
job_female <- welfare %>%
  filter(!is.na(job) & gender == "female") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)


job_female
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
# 지역명 변수 추가 
welfare <- left_join(welfare, list_region, id = "code_region")
# 조인확인랙ㅁㄹㄹㄹ
welfare %>%
  select(code_region, region) %>%
  head

(2) 2단계 - 변수 간 관계 분석 

1) 지역별 연령대 비율표 만들기

region_ageg <- welfare %>%
  group_by(region, ageg) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>% #빈도수 합계 구하기
  mutate(pct = round(n/tot_group*100, 2)) #소수점 두자리 구하기 방금만들어진 파생변수를 바로 다시 사용할 수 있음.

2) 그래프 생성
- 연령대 비율 막대를 서로 다른색으로 표현하도록 aes의 fill = ageg 지정한다.
- 지역별로 비교가 쉽도록 coord_flip()를 추가해서 오른쪽으로 90도 회전한다.

ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip()
head(region_ageg)

3) 노년층 비율 높은 순으로 막대 정렬하기

# 노년층 비율 오름차순 정렬
list_order_old <- region_ageg %>%
  filter(ageg == "old") %>%
  arrange(pct)

- 지역명이 노년층 비율순으로 정렬된 order변수를 활용하여 그래프 생성한다.
# 지역명 순서 변수 만들기

order <- list_order_old$region

- 막대가 노년층 비율이 높은순으로   
ggplot(data = region_ageg, aes(x = region,  y = pct, fill = ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order) 
