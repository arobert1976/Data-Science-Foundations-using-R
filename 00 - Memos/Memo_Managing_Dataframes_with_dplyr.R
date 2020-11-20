library(dplyr) ## this is a common library to ease the handling of dataframes

chicago = readRDS("data/chicago.rds")

## select returns a subset of columns
str(chicago)
chicago_city_dptp = select(chicago, city:dptp) ##retourne un nouveau dataframe avec les colonnes s?lectionn?es
chicago_minus_city_dptp = select(chicago, -(city:dptp))

## filter extracts a subset of rows based on logical conditions
chic.f = filter(chicago, pm25tmean2>25)
chic.f = filter(chicago, pm25tmean2>25 & tmpd>80)

## arrange reorders rows
chicago = arrange(chicago, date) ## reorders the rows by ascending date
chicago = arrange(chicago, desc(date))

## rename renames variable
chicago = rename(chicago, pm25=pm25tmean2, dewpoint=dptp)

## mutate adds new variables (columns) or transform existing variables
chicago = mutate(chicago, pm25detrend=pm25-mean(pm25, na.rm=TRUE))

## summarize generates summary statistics
chicago = mutate(chicago, tempcat=factor(tmpd>80, labels=c("cold","hot")))
hotcold = group_by(chicago, tempcat) ## class(hotcold) returns "grouped_df" "tbl_df" "tbl" "data.frame"
summarize(hotcold, pm25=mean(pm25, na.rm=TRUE), o3=max(o3tmean2), no2=median(no2tmean2)) ## returns the requested statistics

chicago = mutate(chicago, year=as.POSIXlt(date)$year+1900)
years = group_by(chicago, year) 
summarize(years, pm25=mean(pm25, na.rm=TRUE), o3=max(o3tmean2), no2=median(no2tmean2)) ## returns the requested statistics

## pipline operator %>%
chicago %>% mutate(mon=as.POSIXlt(date)$mon+1) %>% group_by(mon) %>% summarize(pm25=mean(pm25, na.rm=TRUE), o3=max(o3tmean2), no2=median(no2tmean2)) ## provides the requested statistics with a concise code