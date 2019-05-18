# 작업디렉토리 지정 
getwd()
setwd("./[009]_MAP")
getwd()

packageVersion("ggmap")


# 001-[구글지도사용하기]
#remove.packages("ggmap")
# ggmap 2.7 을 설치해야 한다. CRAN에 등록되지 않음!
devtools::install_github('dkahle/ggmap')
# install.packages("stringr")

library(ggmap)
library(stringr)

# 구글 지도 API 인증키를 등록합니다. 
register_google(key = 'AIzaSyBqHc9X-Tqk6PCIfl6gW6VPkdpN9jaGxds')

# 위경도 읽어오기
loc <- read.csv("강동구주차장위경도.csv", 
                header = T)
loc

# 지도위치 가져오기/amsadong loc 
#gcode <- as.numeric(geocode("Amsa-dong", source="dsk"))
gcode <- as.numeric(geocode("Amsa-dong", source="google"))
gcode


kd <- get_googlemap(center=c(lon=gcode[1], lat=gcode[2]),
              zoom = 13,
              maptype = "roadmap",
              source = "google",
              key = mykey)

ggmap(kd)


# 주차장 위치에 포인트 지정
kor.map <- ggmap(kd) + 
  geom_point(data = loc, 
             aes(x = LON, y = LAT), 
             size = 3, 
             alpha = 0.7, 
             color = "red")

kor.map
# 주차장명과 함께 지도에 출력
kor.map + 
  geom_text(data = loc, 
            aes(x = LON, 
                y = LAT + 0.001, 
                label = 주차장명), 
            size = 3)

# 파일로 저장하기 ggsave("kd.png", dpi=500)













# 구립(구), 시립(시) 공영 주차장
# 구립 "red", 시립 "blue" 표시

# 구립 시립 구분하여 문자열 추출
loc2 <- str_sub(loc$주차장명, 
                start = -2, 
                end = -2)
loc2

colors <- c()


# 구립과 시립별 포인트 색상변수 지정
for ( i in 1:length(loc2)) {
  if (loc2[i] == '구' ) {
    colors <- c(colors, "red") }
  else { 
    colors <- c(colors, "blue") }
}


# 지도위치 가져오기
kd <- get_map("Amsa-dong", 
              zoom = 13, 
              maptype = "roadmap")

# 포인트 위지 지정
kor.map <- ggmap(kd) + 
  geom_point(data = loc, 
             aes(x = LON, y = LAT),
             size = 3, 
             alpha = 0.7, 
             color = colors)


# 주차장명 지정하여 출력하기
kor.map + 
  geom_text(data = loc,
            aes(x = LON, 
                y = LAT + 0.001, 
                label = 주차장명), 
            size = 3)

# 파일로 저장 ggsave("kd2.png", dpi=500)





# 002-[지도에 경로 표시하기]
# install.packages("ggplot2")
library(ggplot2)
library(ggmap)


# 경로 읽어오기
jeju <- read.csv("제주도.csv", 
                 header = T)
jeju


# 지도위치 가져오기
jeju1 <- get_map("Hallasan", 
                 maptype = "hybrid")


# 포인트 지정
jeju.map <- ggmap(jeju1) + 
  geom_point(data = jeju,
             aes(x = LON, y = LAT),
             size = 4, 
             alpha = 0.7,
             col = "red")

jeju.map
# geom_path 함수를 써서 
# 경로를 선으로 연결해서 표시
jeju.map + 
  geom_path(data = jeju, 
            aes(x = LON, y = LAT), 
            size = 1, 
            linetype = 2, 
            col = "white") +
  geom_text(data = jeju, 
            aes(x = LON, 
                y = LAT + 0.01, 
                label = 장소), 
            size = 4, 
            col = "green")


# 파일로 저장 ggsave("jeju_1.png",dpi=700)


# 1day use limitation of API
geocodeQueryCheck()



# 작업디렉토리 복원
getwd()
setwd("../")
getwd()


