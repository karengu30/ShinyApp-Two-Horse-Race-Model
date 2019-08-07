add_inhibition<- function (Ind,SRT,SSD){
  Ind_inh<-Ind
  Ind_inh<-as.data.frame(Ind)
  Ind_inh$inhibition<-""
  
  for (k in 1:(dim(Ind_inh)[1])) {
    
    if (Ind_inh$Ind[k] > SRT) 
    {
      Ind_inh$inhibition[k]<-"inhibited"
    } 
    else if (Ind_inh$Ind[k] < SSD) 
    {
      Ind_inh$inhibition[k]<-"early"
    } 
    else
    {Ind_inh$inhibition[k]<-"responded"}
  }
  
  return(Ind_inh) 
}