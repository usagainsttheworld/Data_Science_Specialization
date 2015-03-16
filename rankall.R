rankall<-function(outcome,num="best"){
        mydata<-read.csv("outcome-of-care-measures.csv",colClasses="character")
        valid_outcomes<-c("heart attack","heart failure","pneumonia")
        mydata[,11]<-as.numeric(mydata[,11])
        mydata[,17]<-as.numeric(mydata[,17])
        mydata[,23]<-as.numeric(mydata[,23])
        
        if (!outcome %in% valid_outcomes) {
                stop("invalid outcome")
        } else {
                switch(outcome,`heart attack`={col=11},`heart failure`={col=17},`pneumonia`={col=23})
                dfdata<-mydata[,c(2,7,col)]
                pieces<-split(dfdata,dfdata$State)
                rank_hos<-function(onestate,num){
                        order_data<-order(onestate[,3],onestate[,1],na.last=NA)
                        if (num=="best"){
                                onestate$Hospital.Name[order_data[1]]
                        } else if (num=="worst") {
                                onestate$Hospital.Name[order_data[length(order_data)]]
                        } else if (num>length(order_data)) {
                                NA
                        } else {
                                onestate$Hospital.Name[order_data[num]]
                        }      
                }
                order_pieces<-lapply(pieces,rank_hos,num)
                data.frame(hospital=unlist(order_pieces),state=names(order_pieces),row.names=names(order_pieces))
        }
}
##head(rankall("heart attack", 20), 10)
##tail(rankall("pneumonia", "worst"), 3)
##tail(rankall("heart failure"), 10)

