library("RMySQL");

con = dbConnect(MySQL(), user='root', password='yamuna', dbname='Airline', host='localhost');

#row.names(airplane_type_data) = NULL;

dbWriteTable(con,"AIRPLANE_TYPE",airplane_type_data,append = TRUE, row.names = FALSE);


dbWriteTable(con,"AIRPORT",airport_data,append = TRUE, row.names = FALSE);

dbWriteTable(con,"FLIGHT",flight_data,append = TRUE, row.names = FALSE);



dbDisconnect(con);
