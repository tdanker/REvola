library(readxl)
library(devtools)
REdata<-read_xlsx("upload_data.xlsx", skip = 2)
demand<-REdata[,2:6]/1000
availability<-as.data.frame(REdata[,9:13])
names(availability)<-names(demand)
use_data(demand, overwrite = TRUE)
use_data(availability, overwrite = TRUE)
