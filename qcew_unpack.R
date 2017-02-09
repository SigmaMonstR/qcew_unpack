
tot.emp <- function(string){
  
  df <- read.csv(string)
  fields <- c("area_fips", "year", "qtr", "month1_emplvl", "month2_emplvl", "month3_emplvl")
  df <- df[df$own_code==0, fields]
  df2 <- reshape(df, 
                 varying = c("month1_emplvl", "month2_emplvl", "month3_emplvl"),
                 v.names = c("emp"),
                 idvar = c("area_fips","year","qtr"),
                 direction = "long")
  months <- data.frame(qtr = c(1,1,1,2,2,2,3,3,3,4,4,4),
                       time = rep(c(1,2,3), 4),
                       month = seq(1,12,1))
  df2 <- merge(df2, months, by = c("qtr", "time"))
  df2 <- df2[,c("year", "month", "area_fips", "emp")]
  
  return(df2)
}
