# 작업디렉토리 지정 
getwd()
setwd("./[009-2]_MAPTEST2")
getwd()


library(ggplot2)
library(ggmap)
#path of line 3 by station position
loc <- read.csv("지하철3호선.csv", 
                header = T)

kor <- get_map("seodaemun-gu", 
               zoom = 11, 
               maptype = "roadmap")

kor.map <- ggmap(kor) + 
  geom_point(data = loc, 
             aes(x = LON, y = LAT),
             size = 2, 
             alpha = 0.7, 
             col = "red")

kor.map + 
  geom_path(data = loc,
            aes(x = LON, y = LAT),
            size = 1,
            linetype = 2,
            col = "blue") +
  geom_text(data = loc, 
            aes(x = LON, 
                y = LAT + 0.005, 
                label = 역명), 
            size = 3)


# 작업디렉토리 복원
getwd()
setwd("../")
getwd()


