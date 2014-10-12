f_download <- function(fileURL, f_name) 
{
	if(!file.exists(f_name)) 
	{
		download.file(fileURL, destfile = f_name, method = "curl")
	}
	f_name
}

prepareData <- function() 
{
	cacheFile <- "plot_data.csv"
	if(file.exists(cacheFile)) 
	{
		table <- read.csv(cacheFile)
		table$DateTime <- strptime(table$DateTime, "%Y-%m-%d %H:%M:%S")
	}
	else 
	{
		f_name <- f_download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
		con <- unz(f_name, "household_power_consumption.txt")
		table <- read.table(con, header = T, sep = ';', na.strings = "?", colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
		
		table <- table[(table$Date == "1/2/2007") | (table$Date == "2/2/2007"),]
		table$DateTime <- strptime(paste(table$Date, table$Time), "%d/%m/%Y %H:%M:%S")
		write.csv(table, cacheFile)
	}
	table
}
