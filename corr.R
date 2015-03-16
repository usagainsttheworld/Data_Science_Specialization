complete<-function(directory,id=1:332){
        
        nobs=numeric()
        for(i in id){
                mydata=read.csv(paste(directory,"/",formatC(i,width=3,flag="0"),".csv",sep=""))               
                row<-nrow(mydata)
                counter = as.integer(0)
                for(i in 1:row){
                        if(sum(is.na(mydata[i,])) == 0){
                                counter= counter+1                
                        }
                }
                nobs<-c(nobs,counter)
        }
        return(data.frame(id,nobs))
}

corr<-function(directory,threshold=0){       
        c_data=complete(directory)
        c_id=c_data[c_data["nobs"]>threshold,]$id
        cor_meet<-vector(mode="numeric",length=0)
        for(i in c_id){
                newread=read.csv(paste(directory,"/",formatC(i,width=3,flag="0"),".csv",sep=""))
                comp_data<-newread[complete.cases(newread),]               
                cor_meet=c(cor_meet, cor(comp_data$sulfate,comp_data$nitrate))   
        } 
        return(cor_meet)
} 
