# 작업디렉토리 지정 
getwd()
setwd("./[009-1]_MAPTEST1")
getwd()






# 국세청 위치 출력
# install.packages("ggmap")
# install.packages("stringr")
library(ggmap)
library(stringr)

loc <- read.csv("국세청_위경도.csv", 
                header = T)
loc

kd <- get_map("Geumnam-myeon, 
              Sejong-si, 
              Republic of Korea", 
              zoom = 11, 
              maptype = "roadmap")

kor.map <- ggmap(kd) + 
  geom_point(data = loc, 
             aes(x = LON, y = LAT),
             size = 5, 
             alpha = 0.5, 
             color = "red")

kor.map + 
  geom_text(data = loc,
            aes(x = LON-0.001, 
                y = LAT-0.008, 
                label = 위치), 
            size = 6)











# 제주대학교 위치 출력
# install.packages("ggmap")
# install.packages("stringr")
library(ggmap)
library(stringr)

loc <- read.csv("제주대학교_위경도.csv", 
                header = T)
loc

kd <- get_map("Jeju National Univ. Hospital, 
              Jeju-si, 
              Jeju-do, 
              South Korea", 
              zoom = 12, 
              maptype = "roadmap")

kor.map <- ggmap(kd) + 
  geom_point(data = loc, 
             aes(x = LON, y = LAT),
             size = 5, 
             alpha = 0.5, 
             color = "red")

kor.map + 
  geom_text(data = loc,
            aes(x = LON - 0.005, 
                y = LAT - 0.005, 
                label = 위치), 
            size=6)










# 위도, 경도 확인
# install.packages("ggmap")
library(ggmap)

# 특정지명 사용하여 위경도 정보 획득
(gc <- geocode(enc2utf8("용인")))
(gc <- geocode(enc2utf8("제주대학교")))
(gc <- geocode(enc2utf8("불국사")))

# 도로명 주소 사용
(gc <- geocode(enc2utf8("경북 경주시 불국로 385")))

# 지번 주소 사용
(gc <- geocode(enc2utf8("세종특별자치시 남면 국세청로 8-14")))
(gc <- geocode(enc2utf8("대전광역시 대덕구 법1동 282-1")))
(gc <- geocode(enc2utf8("대전광역시 서구 둔산동 949")))
(gc <- geocode(enc2utf8("경상북도 경주시 진현동 15")))


# 위경도 정보 숫자형으로 변환 necessary
(cen <- as.numeric(gc))

# roadmap 출력
map <- get_googlemap(center = cen, 
                     maptype = "roadmap", 
                     markers = gc)
ggmap(map)

# satellite 출력
map <- get_googlemap(center = cen, 
                     maptype = "satellite", 
                     markers = gc)
ggmap(map)

# terrain 출력
map <- get_googlemap(center = cen, 
                     maptype = "terrain", 
                     markers = gc)
ggmap(map)

# hybrid 출력
map <- get_googlemap(center = cen, 
                     maptype = "hybrid", 
                     markers = gc)
ggmap(map)





# 작업디렉토리 복원
getwd()
setwd("../")
getwd()


