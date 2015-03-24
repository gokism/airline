
generate_weekdays_bit_string  <- function(ws)
{
  days <- c("Sun","Mon","Tue","Wed","Thu","Fri","Sat");
  bit_string = "";
  
  for(day in days)
  {
    if(length(grep(day,ws, ignore.case = TRUE)) >= 1)
    {
       bit_string = paste(bit_string,"1",sep = "");
    }
    else
    {
       bit_string = paste(bit_string,"0",sep = "");
    }
  }
  bit_string = paste("b","'",bit_string,"'",sep = "");
  return(bit_string);  
}

