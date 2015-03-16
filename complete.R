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
