library(tidyr)
library(dplyr)


##Multiple csv files are saved in this directory
setwd("A://University_Work//Analysis of SptatioTemporal Data//Final Project//67c5acc701983cc696fb6324cf3362da821a952a")

#Read all the csv files
files <-dir(pattern = "*.csv", recursive = TRUE, full.names = TRUE)



#map all of them 
dfs <- map(files, ~read_csv(.x))

#Set their name, but then the names are used as the directory names
#which will be very long, so to let's remove everything and selected the 
#last name as the file name
names(dfs) <- sapply(strsplit(files, "/"), tail, n = 1)


#in this we are selecting only important fields such that, the data size 
#is reduced
selected_dfs <- lapply(dfs, function(df){
  df[c("Month", "Falls within", "Longitude", "Latitude", "Crime type")]
})


#Now, let's store all of them in a single dataframe
all_data = do.call(rbind, dfs)


all_data$Year <- substring(all_data$Month, 1, 4)


#Now, I have decided to work on this location, so filtering this whole file,
#by location
metroPolice_data <- all_data[all_data$`Falls within`=="Metropolitan Police Service", ]



#Saving the file in a .csv format, to use for future work
write.csv(metroPolice_data, "metroPolice_data.csv", row.names = FALSE)


### The file has been saved as a CSV, since, we just want to work with 
### Metropolitan Police Service 

