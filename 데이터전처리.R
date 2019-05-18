exam = read.csv('data/csv_exam.csv')
exam
exam %>% filter(class!=2)
# 수학 점수가 50점을 초과한 경우
exam %>% filter(math > 50)

# 수학 점수가 50점 미만인 경우
exam %>% filter(math < 50)

# 영어 점수가 80점 이상인 경우
exam %>% filter(english >= 80)

# 영어 점수가 80점 이하인 경우
exam %>% filter(english <= 80)

exam %>% filter(class %in% c(1,3,5))

class1 <- exam %>% filter(class == 1)  # class가 1인 행 추출, class1에 할당
class2 <- exam %>% filter(class == 2)  # class가 2인 행 추출, class2에 할당

mean(class1$math)                      # 1반 수학 점수 평균 구하기
mean(class2$math)                      # 2반 수학 점수 평균 구하기

# ※ 혼자서 해보기 ※
# 
# >>> mpg 데이터를 이용해 분석 문제를 해결해 보세요.
# Q1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다.
# displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가
# 평균적으로 더 높은지 알아보세요.(filter())
mpg = as.data.frame(ggplot2::mpg)
mpg_a = mpg %>% filter(displ <= 4)
mpg_b = mpg %>% filter(displ >=5)
mean(mpg_a$hwy)
mean(mpg_b$hwy)
# Q2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 합니다.
# "audi"와 "toyota" 중 어느 manufacturer(자동차 제조 회사)의 cty(도시 연비)가 평균적으로
# 더 높은지 알아보세요.

mpg_audi = mpg %>% filter(manufacturer=='audi')
mpg_toyota = mpg %>% filter(manufacturer=='toyota')
mean(mpg_audi$cty)
mean(mpg_toyota$cty)
# Q3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 합니다.
# 이 회사들의 자동차를 추출한 뒤 hwy 전체 평균을 구해보세요.(filter(),%in%)
# 
mpg_new = mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
mpg_new
mean(mpg_new$hwy)
exam %>% select(math)                  # math 추출

exam %>% select(english)               # english 추출

exam %>% select(class, math, english)  # class, math, english 변수 추출

exam %>% select(-math)                 # math 제외

exam %>% select(-math, -english)       # math, english 제외

exam %>%
  filter(class == 1) %>%  # class가 1인 행 추출
  select(english) 


exam %>% 
  select(id, math) %>% 
  head(10)
# ※ 혼자서 해보기 ※
# >>> mpg 데이터를 이용해서 분석 문제를 해결해보세요.
# Q1. mpg 데이터는 11개 변수로 구성되어 있습니다. 이 중 일부만 추출해서 분석에 활용하려고 합니다.
# mpg 데이터에서 class(자동차 종류), cty(도시 연비) 변수를 추출해 새로운 데이터를 만드세요.
# 새로 만든 데이터의 일부를 출력해서 두 변수로만 구성되어 있는지 확인하세요.(select())

mpg_test = mpg %>% 
          select(class,cty)
head(mpg_test)
# Q2. 자동차 종류에 따라 도시 연비가 다른지 알아보려고 합니다.
# 앞에서 추출한 데이터를 이용해서 class(자동차 종류)가 "suv"인 자동차와 "compact"인 자동차 중
# 어떤 자동차의 cty(도시 연비)가 더 높은지 알아보세요.(filter())
mpg_suv = mpg %>% 
          filter(class=='suv')
mpg_compact = mpg %>% filter(class=='compact')

mean(mpg_suv$cty)
mean(mpg_compact$cty)

################### R 실습 ####################

exam %>% arrange(math)         # math 오름차순 정렬
exam %>% arrange(desc(math))   # math 내림차순 정렬
exam %>% arrange(class, math)  # class 및 math 오름차순 정렬


# ※ 혼자서 해보기 ※
# >>> mpg 데이터를 이용해서 분석 문제를 해결해보세요.
# Q1. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 합니다.
# "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 자동차의 데이터를 출력하세요.
 
# >>> 힌트
# filter()를 이용해 "audi"에서 생산한 자동차만 추출하고, arrange()로 hwy를 내림차순 정렬하면 됩니다. 
# head()를 이용하면 이 중 특정 순위에 해당하는 자동차만 출력할 수 있습니다.
mpg %>% 
  filter(manufacturer=='audi') %>% 
    arrange(desc(hwy)) %>% 
  head(5)

exam %>%
  mutate(total = math + english + science) %>%  # 총합 변수 추가
  head 
exam %>%
  mutate(total = math + english + science,         # 총합 변수 추가
         mean = (math + english + science)/3) %>%  # 총평균 변수 추가
  head    
exam %>%
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>%
  head
exam %>%
  mutate(total = math + english + science) %>%  # 총합 변수 추가
  arrange(total) %>%                            # 총합 변수 기준 정렬
  head     
mpg
# ※ 혼자서 해보기 ※
# >>> mpg 데이터를 이용해서 분석 문제를 해결해보세요.
# >>> mpg 데이터는 연비를 나타내는 변수가 hwy(고속도로 연비), cty(도시 연비) 두 종류로 분리되어 있습니다.
# 두 변수를 각각 활용하는 대신 하나의 통합 연비 변수를 만들어 분석하려고 합니다.
# Q1. mpg 데이터 복사본을 만들고, cty와 hwy를 더한 '합산 연비 변수'를 추가하세요.
# Q2. 앞에서 만든 '합산 연비 변수'를 2로 나눠 '평균 연비 변수'를 추가세요.
# Q3. '평균 연비 변수'가 가장 높은 자동차 3종의 데이터를 출력하세요.
# Q4. 1~3번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 출력하세요. 
# 데이터는 복사본 대신 mpg 원본을 이용하세요.
mpg_copy = mpg
mpg_copy = mpg %>% 
  mutate(total = cty + hwy,
         mean = total/2) %>% 
  arrange(desc(mean)) %>% 
  head(3)
 mpg_copy 

 ################### R 실습 ####################
 exam %>% summarise(mean_math = mean(math))  # math 평균 산출
 
 exam %>% 
   group_by(class) %>%                   # class별로 분리
   summarise(mean_math = mean(math))     # math 평균 산출


 exam %>% 
   group_by(class) %>%                   # class별로 분리
   summarise(mean_math = mean(math),     # math 평균
             sum_math = sum(math),       # math 합계
             median_math = median(math), # math 중앙값
             n = n())  

 
 mpg %>%
   group_by(manufacturer, drv) %>%       # 회사별, 구동방식별 분리
   summarise(mean_cty = mean(cty)) %>%   # cty 평균 산출
   head(10) 
 
 mpg %>%
   group_by(manufacturer) %>%           # 회사별로 분리
   filter(class == "suv") %>%           # suv 추출
   mutate(tot = (cty+hwy)/2) %>%        # 통합 연비 변수 생성
   summarise(mean_tot = mean(tot)) %>%  # 통합 연비 평균 산출
   arrange(desc(mean_tot)) %>%          # 내림차순 정렬
   head(5) 
 
 # ※ 혼자서 해보기 ※
 # >>> mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
 # Q1. mpg 데이터의 class는 "suv", "compact" 등 자동차를 특징에 따라 일곱 종류로 분류한 변수입니다. 
 # 어떤 차종의 연비가 높은지 비교해보려고 합니다. class별 cty 평균을 구해보세요.
 mpg %>% 
   group_by(class) %>% 
   summarise(mean_cty=mean(cty))
 # Q2. 앞 문제의 출력 결과는 class 값 알파벳 순으로 정렬되어 있습니다. 
 # 어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 cty 평균이 높은 순으로 정렬해 출력하세요.
 mpg %>% 
   group_by(class) %>% 
   summarise(mean_cty=mean(cty)) %>% 
   arrange(desc(mean_cty))
 # Q3. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려고 합니다. 
 # hwy 평균이 가장 높은 회사 세 곳을 출력하세요.
 mpg %>% 
   group_by(manufacturer) %>% 
   summarise(mean_hwy=mean(hwy)) %>% 
   arrange(desc(mean_hwy)) %>% 
   head(3)
 
 # Q4. 어떤 회사에서 "compact"(경차) 차종을 가장 많이 생산하는지 알아보려고 합니다. 
 # 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.
 
 mpg %>% 
   filter(class=='compact') %>% 
   group_by(manufacturer) %>% 
   summarise(count = n()) %>% 
   arrange(desc(count))
 
 ################### R 실습 ####################
 # 중간고사 데이터 생성
 test1 <- data.frame(id = c(1, 2, 3, 4, 5),           
                     midterm = c(60, 80, 70, 90, 85))
 
 # 기말고사 데이터 생성
 test2 <- data.frame(id = c(1, 2, 3, 4, 5),           
                     final = c(70, 83, 65, 95, 80))
 
 test1  # test1 출력
 test2  # test2 출력
 
 total <- left_join(test1, test2, by = "id")  # id 기준으로 합쳐서 total에 할당
 total                                        # total 출력
 
 name <- data.frame(class = c(1, 2, 3, 4, 5),
                    teacher = c("kim", "lee", "park", "choi", "jung"))
 name
 
 exam_new <- left_join(exam, name, by = "class")
 exam_new
 
 # 학생 1~5번 시험 데이터 생성
 group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                       test = c(60, 80, 70, 90, 85))
 
 # 학생 6~10번 시험 데이터 생성
 group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                       test = c(70, 83, 65, 95, 80))
 
 group_a  # group_a 출력
 group_b  # group_b 출력
 
 group_all <- bind_rows(group_a, group_b)  # 데이터 합쳐서 group_all에 할당
 group_all                                 # group_all 출력
 
 # ※ 혼자서 해보기 ※
 # >>> mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
 # mpg 데이터의 fl 변수는 자동차에 사용하는 연료(fuel)를 의미합니다. 
 # 아래는 자동차 연료별 가격을 나타낸 표입니다.
 
 # fl 연료 종류 가격(갤런당 USD)
 # c CNG 2.35
 # d diesel 2.38
 # e ethanol E85 2.11
 # p premium 2.76
 # r regular 2.22
 # 
 # 우선 이 정보를 이용해서 연료와 가격으로 구성된 데이터 프레임을 만들어 보세요.
  fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                     price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                    stringsAsFactors = F)
  fuel  # 출력
 # ##   fl price_fl
 # ## 1  c     2.35
 # ## 2  d     2.38
 # ## 3  e     2.11
 # ## 4  p     2.76
 # ## 5  r     2.22
 # 
 # Q1. mpg 데이터에는 연료 종류를 나타낸 fl 변수는 있지만 연료 가격을 나타낸 변수는 없습니다. 
 # 위에서 만든 fuel 데이터를 이용해서 mpg 데이터에 price_fl(연료 가격) 변수를 추가하세요.
 table(mpg$fl)
 mpg = left_join(mpg, fuel, by='fl')
 head(mpg) 
# Q2. 연료 가격 변수가 잘 추가됐는지 확인하기 위해서 model, fl, price_fl 변수를 추출해 
 # 앞부분 5행을 출력해 보세요.
 # 
 mpg %>% 
   select(model, fl, price_fl) %>% 
   head(5)
   
 
 
 
 
 
 
 
 
 
 
 
 
 
 