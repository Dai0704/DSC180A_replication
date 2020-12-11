#install.packages("rstudioapi")
# run this above line if returns 'there is no package called ‘rstudioapi’'

install.packages("rjson",repos = "http://cran.us.r-project.org")
#run this above line if rjson has not yet been installed

install.packages("psych",repos = "http://cran.us.r-project.org")
install.packages("tidyr",repos = "http://cran.us.r-project.org")
install.packages("devtools",repos = "http://cran.us.r-project.org")

target = as.character(commandArgs(trailingOnly=TRUE))
library("rjson")
library(psych)
library(tidyr)
library(dplyr)

# build path to the R script where all the functions are stored
path = './src/methods.R'
# source that path
source(path)



if (length(target) == 0){
	target = "test"
}

# run these functions
if ('eda' %in% target) {
	params = fromJSON(file = "./config/eda-params.json")
  	eda_generator(params['data'],params['csv_filename'],params['g1'],params['g2'])
} else if ('all' %in% target) {
  	# build path and load data for the first method
  	data_fp = fromJSON(file = "./config/methods.json")
    
  	path = data_fp['data_fp']
  	mootha  = read.table(as.character(path), header = TRUE)
  	mootha_function(mootha)
    
  	# build path and load data for the second method
  	path2 = data_fp['data_fp2']
  	Z = scan(as.character(path2))
  	Jongho_function(Z)
} else if ('test' %in% target){
	# build path and load data for the first method
  	data_fp = fromJSON(file = "./config/test.json")
    
  	path = data_fp['data_fp']
  	mootha  = read.table(as.character(path), header = TRUE)
  	mootha_function(mootha)
    
  	# build path and load data for the second method
  	path2 = data_fp['data_fp2']
  	Z = scan(as.character(path2))
  	Jongho_function(Z)
} else {
	print('invalid input. Command Line options -- all/test (default test)')
}

#######2
path_2 = './src/eda.R'
# source that path
source(path_2)

if (length(target) == 0){
  target = "test"
}

# run these functions
if ('eda' %in% target) {
  params = fromJSON(file = "./config/eda-params.json")
  eda_generator(params['data'],params['csv_filename'],params['g1'],params['g2'])
} else if ('all' %in% target) {
  # build path and load data for the first method
  data_fp = fromJSON(file = "./config/methods.json")
  
  path = data_fp['data_fp']
  mootha  = read.table(as.character(path), header = TRUE)
  mootha_function(mootha)
  
  # build path and load data for the second method
  path2 = data_fp['data_fp2']
  Z = scan(as.character(path2))
  Jongho_function(Z)
} else if ('test' %in% target){
  # build path and load data for the first method
  data_fp = fromJSON(file = "./config/test.json")
  
  path = data_fp['data_fp']
  g1 = data_fp['g1']
  g2 = data_fp['g2']
  mootha  = read.table(as.character(path),header = TRUE)
  
  scatter_matrix_function(mootha,g1,g2)
  stat_summary(mootha,g1,g2)
} else {
  print('invalid input. Command Line options -- all/test (default test)')
}

#FDR_function()
#simulate_function()
#fit_function()
#source('./src/functions.R')
#mootha <- read.table('./src/data/MoothaData.txt')
#Z = scan('./src/data/JonghoZscores.txt')
#mootha_function(mootha)
#Jongho_function(Z)
