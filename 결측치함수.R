data = c(100, 89,50, NA, 90, 100, NA)
data
mean(data)

#결측치 데이터 처리 함수
na <- function(x){
  #1차 : NA 제거 
  print(x)
  print( mean(x, na.rm = T) )
  
  #2차 : NA를 0으로 대체  
  data = ifelse(!is.na(x), x, 0) # NA이면 0으로 대체
  print(data)
  print(mean(data))
  
  # 3차 : NA를 평균으로 대체 
  data2 = ifelse(!is.na(x), x, round(mean(x, na.rm=TRUE), 2) ) # 평균으로 대체 
  print(data2)
  print(mean(data2))
}
na(data) #함수 호출


# ※ 혼자 해보기 ※
# Q1. 다음 조건에 맞게 client 데이터프레임을 생성하고, 조건에 맞게 처리하시오.
# <vector 준비>
  name <-c("유관순","홍길동","이순신","신사임당")
gender <- c("F","M","M","F")
 price <-c(50,65,45,75)

# 조건1) 다음 3개 벡터 객체를 이용하여 client 데이터프레임을 생성하시오.
client = data.frame(name,gender,price)
client 
# 조건2) price 변수의 값이 65만원 이상이면 문자열 "Best", 65만원 미만이면 문자열
# "Normal"을 변수 result에 추가하시오. 힌트) ifelse() 함수 이용
client$result = ifelse(client$price >= 65,"Best","Normal")
client
# 조건3) result 변수를 대상으로 빈도수를 구하시오. 

table(client$result)






