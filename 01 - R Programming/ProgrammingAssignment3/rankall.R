rankall <- function(outcome, num = "best") {
    
    ## Read outcome data
    ## Column 2  : Hospital.Name
    ## Column 7  : State
    ## Column 11 : Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack
    ## Column 17 : Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure
    ## Column 23 : Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia
    df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    if(!state %in% df[,7]) stop("invalid state")
    if(!outcome %in% c("heart attack","heart failure","pneumonia")) stop("invalid outcome")
    
    ## Keep only necessary columns in DataFrame and rename the columns to hospital and state  
    ## Change the rate as numeric
    ## Remove the rows where the rate is empty
    if(outcome == "heart attack") df <- df[,c(2,7,11)]
    if(outcome == "heart failure") df <- df[,c(2,7,17)]
    if(outcome == "pneumonia") df <- df[,c(2,7,23)]
    colnames(df) <- c("hospital","state","rate")
    df[, 3] <- as.numeric(df[, 3])
    df <- df[!is.na(df[,3]),]
    df <- df[order(df$state,df$rate,df$hospital),]
    df <- df[,c(1,2)]
    
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    by_state <- lapply(split(df, df$state), function(x) {
        if(num == "best") num <- 1
        if(num == "worst") num <- nrow(x)
        x[num,1] 
    })
    states <- names(by_state)
    hospitals <- character(length(states))
    for (i in 1:length(states)){
        hospitals[i] <- by_state[[i]]
    }
    cbind(hospitals,states)
}
