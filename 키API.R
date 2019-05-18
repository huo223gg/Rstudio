구글 api키: AIzaSyAshj_W-_TikgkWXjpTRzIvr6_8_8f5P-U

library(DBI)
library(tidyverse)
library(ggmap)
library(rgdal)
library(rgeos)

tmp <- tempdir()
db <- "~/Downloads/handelsregister.db"
con <- dbConnect(RSQLite::SQLite(), db)

sql <- "select id, company_number as company_id, current_status, retrieved_at, registered_address from company"
res <- dbSendQuery(con, sql)
company <- dbFetch(res)
dbClearResult(res)
sql <- "select id as officer_id, company_id, firstname, start_date, end_date, dismissed from officer"
res <- dbSendQuery(con, sql)
officer <- dbFetch(res)
dbClearResult(res)
dbDisconnect(con)

company %>%
  filter(current_status == "currently registered",
         !is.na(registered_address)) %>%
  mutate(plz = str_extract(registered_address, "\\d{5}")) %>%
  filter(plz != "") %>%
  select(company_id, plz) -> company_plz

officer %>%
  filter(firstname != "",
         !is.na(firstname),
         is.na(dismissed)) -> officer_firstname

company_plz %>%
  left_join(officer_firstname) %>%
  filter(!is.na(firstname)) -> company_firstname

nl <- read_csv2("https://raw.githubusercontent.com/MatthiasWinkelmann/firstname-database/master/firstnames.csv") %>%
  rename(firstname = name) %>%
  select(firstname, gender) %>%
  group_by(firstname) %>%
  filter(n() == 1) %>%
  ungroup()

company_firstname %>%
  left_join(nl) %>%
  filter(gender == 'M' | gender == 'F') -> plz_name_gender
The overall share of female officers in Germany based on this classification is 17.0%. How does this share vary across German regions? Let’s get some OSM shape data.

# Shape file is based on OSM data.
# Source: https://www.suche-postleitzahl.org/downloads

download.file("https://www.suche-postleitzahl.org/download_files/public/plz-gebiete.shp.zip",
              file.path(tmp, "shape5.zip"))
unzip(file.path(tmp, "shape5.zip"), exdir = tmp)
plz5_polys <- readOGR(file.path(tmp, "plz-gebiete.shp"))

download.file("https://www.suche-postleitzahl.org/download_files/public/plz-2stellig.shp.zip",
              file.path(tmp, "shape2.zip"))
unzip(file.path(tmp, "shape2.zip"), exdir = tmp)
plz2_polys <- readOGR(file.path(tmp, "plz-2stellig.shp"))
Now we can create maps. First at the post area level (identified by the first to digits of the PLZ).

plz_name_gender %>%
  mutate(plz2 = substr(plz, 1, 2)) %>%
  group_by(plz2) %>%
  summarise(nobs = n(),
            female = sum(gender == 'F')/n()) -> plz2_female_share
plz_map <- 
  fortify(plz2_polys, region = "plz") %>% 
  left_join(plz2_female_share, by = c("id" = "plz2"))

plz2_map <- ggplot(plz_map, aes(x = long, y = lat, group = group, fill = female)) +
  geom_polygon(colour = NA, lwd=0, aes(group = group)) + 
  scale_fill_gradient2(name = "Share of female officers", 
                       low = "orange", mid = "gray90", high = "purple", 
                       midpoint = median(plz2_female_share$female, na.rm = TRUE),
                       breaks = 0.05*(2:4), labels = scales::percent(0.05*(2:4), 
                                                                     accuracy = 1)) + 
  coord_map() +
  theme_void() +
  theme(legend.justification=c(0,1), legend.position=c(0,1), plot.caption = element_text(hjust = 0)) +
  labs(caption = "Data as provided by OffeneRegister.de. Graph by @JoachimGassen with #rstats.")





posi1 <- read.csv("소상공인시장진흥공단_상가업소정보_201809_1.csv", header=T, as.is=T)
ggmap(map) + geom_point(data=airport, aes(x=lon, y=lat),color='yellow', size=1)




install.packages("munsell")
> library(ggmap)
Google's Terms of Service: https://cloud.google.com/maps-platform/terms/.
Please cite ggmap if you use it! See citation("ggmap") for details.
>Google's Terms of Service: https://cloud.google.com/maps-platform/terms/.
> packageStartupMessage("Please cite ggmap if you use it! See citation(\"ggmap\") for details.")
Please cite ggmap if you use it! See citation("ggmap") for details.
get_googlemap("gangnamgu", zoom = 6, maptype = "satellite") %>% ggmap


geom_point(topo, aes(x = 경도, y = 위도), colour = col4, data = i2, alpha=0.3, size = 0.5) + 
  theme(legend.position="none")


delete.dirt <- function(DF, dart=c('NA')) {
  dirty_rows <- apply(DF, 1, function(r) !any(r %in% dart))
  DF <- DF[dirty_rows, ]
}

topon <- delete.dirt(topo)







