#Breakdown steps can be found in eda.Rmd
#Install the following packages if have not been done yet

#install.packages("psych",dependencies=TRUE)
#install. packages("tidyr")
#install. packages("dplyr")

library(psych)
library(tidyr)
library(dplyr)


scatter_matrix_function = function(dataset,g1,g2){
  data = dataset
  g1 = 1:17
  g2 = 18:34
  s1 = sample(g1, 2, replace=FALSE)
  s2 = sample(g2, 2, replace=FALSE)
  sm_sample = c(s1,s2)
  
  path = './test/test_output/corr.png'
  png(filename=path)
  
  pairs.panels(data[,sm_sample], 
               method = "pearson", # correlation method
               hist.col = "#00AFBB",
               density = TRUE,  # show density plots
               ellipses = TRUE # show correlation ellipses
  )
  dev.off()
}

stat_summary = function(dataset,g1,g2){
  data = dataset
  g1 = 1:17
  g2 = 18:34
  data_long <- gather(data, factor_key=TRUE)
  
  summarydf <- data_long %>% group_by(key) %>%
    summarize(mean= mean(value), sd= sd(value), max = max(value),min = min(value))
  
  write.csv(summarydf, "./test/test_output/stats_summary.csv")
  
  g1_stat = apply(summarydf[g1,2:5],2,mean)
  g2_stat = apply(summarydf[g2,2:5],2,mean)
  
  group_stat = data.frame(g1_stat,g2_stat)
  
  write.csv(group_stat, "./test/test_output/group_stat.csv")
  return(group_stat)
}
