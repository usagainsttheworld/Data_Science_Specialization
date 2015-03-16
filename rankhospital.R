rankhospital<-function(state,outcome,num){
        mydata<-read.csv("outcome-of-care-measures.csv",colClasses="character")
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
              hosNo=nrow(df)
              if (num=="Best") {
                      minrate<-(min(df[,col],na.rm=T))                      
                      minrow<-which(df[,col]==minrate)
                      result<-df[minrow,2]       
              }
              else if (num=="worst") {
                      maxrate<-(max(df[,col],na.rm=T))
                      maxrow<-which(df[,col]==maxrate)
                      result<-df[maxrow,2]
              }
              else if (num>hosNo){
                      result=NA
              }
              else {myrow<-order(df[,col], df[,2], decreasing=F,na.last=NA)
                    rowwant<-myrow[num]
                    result<-df[rowwant,2]
              }
              result
        }        
}
##rankhospital("TX", "heart failure", 4)
##rankhospital("MD", "heart attack", "worst")
##rankhospital("MN", "heart attack", 5000)