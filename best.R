best<-function(state,outcome){
        mydata<-read.csv("outcome-of-care-measures.csv", colClasses="character")
        valid_outcomes<-c("heart attack","heart failure","pneumonia")
        mydata[,11]<-as.numeric(mydata[,11])
        mydata[,17]<-as.numeric(mydata[,17])
        mydata[,23]<-as.numeric(mydata[,23])
        if (!state %in% mydata[,7]){
                stop ("invalid state")        
        }else if (!outcome %in% valid_outcomes) {
                stop("invalid outcome")
        }else{switch(outcome,`heart attack`={col=11},`heart failure`={col=17},`pneumonia`={col=23})
              df<-subset(mydata,State==state)
              minrate<-(min(df[,col],na.rm=T)) 
              minrow<-which(df[,col]==minrate)
              result<-df[minrow,2]
              result
              }                      
}

##best("TX", "heart attack")
##best("TX", "heart failure")
##best("MD", "heart attack")
##best("MD", "pneumonia")
##best("BB", "heart attack")
##best("NY", "hert attack")