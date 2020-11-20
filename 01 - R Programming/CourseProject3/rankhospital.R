rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    ## Column 2  : Hospital.Name
    ## Column 7  : State
    ## Column 11 : Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack
    ## Column 17 : Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure
    ## Column 23 : Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia
    df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    df[, 11] <- as.numeric(df[, 11])
    df[, 17] <- as.numeric(df[, 17])
    df[, 23] <- as.numeric(df[, 23])
    
    ## Check that state and outcome are valid
    if(!state %in% df[,7]) {
        stop("invalid state")
    }
    
    if(!outcome %in% c("heart attack","heart failure","pneumonia")) {
        stop("invalid outcome")
    }
    
    ## Return hospital name in that state with the given rank 30-day death rate
    if(outcome == "heart attack") {
        f_df <- df[which(df$State == state), c(2,11)]
        bad <- is.na(f_df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
        f_df <- f_df[!bad,]
        s_df <- f_df[order(f_df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,f_df$Hospital.Name),]
    }
    if(outcome == "heart failure") {
        f_df <- df[which(df$State == state), c(2,17)]
        bad <- is.na(f_df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
        f_df <- f_df[!bad,]
        s_df <- f_df[order(f_df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,f_df$Hospital.Name),]
    }
    if(outcome == "pneumonia") {
        f_df <- df[which(df$State == state), c(2,23)]
        bad <- is.na(f_df$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
        f_df <- f_df[!bad,]
        s_df <- f_df[order(f_df$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,f_df$Hospital.Name),]
    }
    if(num == "best") num <- 1
    if(num == "worst") num <- nrow(s_df) 
    if(num > nrow(s_df)) return(NA)
    s_df[num,]
    
}
