library(dplyr)


lm_eqn = function(m) {
    
    l <- list(a = format(coef(m)[1], digits = 2),
    b = format(abs(coef(m)[2]), digits = 2),
    r2 = format(summary(m)$r.squared, digits = 3));
    
    eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(r)^2~"="~r2,l)
    
    
    as.character(as.expression(eq));
}


#allzips <- readRDS("data/superzip.rds")
superzip <- read.csv(file="data/superzip.csv")
zipcodes <- read.csv(file="data/zip_codes_states.csv")

allzips <- merge(x=superzip, y=zipcodes, by.x="zipcode", by.y="zip_code")


allzips$latitude <- jitter(allzips$latitude)
allzips$longitude <- jitter(allzips$longitude)
allzips$college <- allzips$college * 100
allzips$unemployment <- allzips$Unemp..Rate * 100
allzips$zipcode <- formatC(allzips$zipcode, width=5, format="d", flag="0")
#row.names(allzips) <- allzips$zipcode

cleantable <- allzips %>%
  select(
    City = city.x,
    State = state.x,
    Zipcode = zipcode,
    Rank = rank,
    Score = centile,
    Superzip = superzip,
    Population = adultpop,
    College = college,
    unemployment = Unemp..Rate,
    Income = income,
    Lat = latitude,
    Long = longitude
  )
