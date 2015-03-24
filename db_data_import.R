rm(list = ls());
setwd("/home/gok/DB Project");
source("./data_import_util.R");
source("./mysql_con.R")

airport_data  <- read.csv(file = "AIRPORT.csv", sep = "\t");
colnames(airport_data) <- c("airport_code","airport_name","city","state");
for(i in 1:ncol(airport_data))
{
  airport_data[,i] = as.character(airport_data[,i]);
}


airplane_type_data  <- read.csv(file = "AIRPLANE_TYPE.csv", sep = "\t");
colnames(airplane_type_data)  <- c("airplane_type_name", "max_seats","company")
airplane_type_data$airplane_type_name  <- as.character(airplane_type_data$airplane_type_name);
airplane_type_data$company  <- as.character(airplane_type_data$company);

flight_data  <- read.csv(file = "FLIGHTS.dat", sep = ",", header = FALSE);
colnames(flight_data) = c("flight_number", "airline", "weekdays_raw", "departure_airport_code", "scheduled_departure_time", "arrival_airport_code", "scheduled_arrival_time", "duration");
flight_data$weekdays_raw = as.character(flight_data$weekdays_raw);
flight_data$weekdays = sapply(flight_data$weekdays_raw,generate_weekdays_bit_string);
flight_data$weekdays_raw = NULL;
flight_data$duration = NULL;
for(i in 1:ncol(flight_data))
{
  flight_data[,i] = as.character(flight_data[,i]);
}

airline_field  <- unique(flight_data$airline);

for(a in airline_field)
{
  l  <- nrow(flight_data[(flight_data$airline == a),]);
  pre <- rep(flight_data[(flight_data$airline == a),1][1],l);
  post  <- 1:l;
  flight_data[(flight_data$airline == a),1] = paste(pre,post,sep = "N");
}




