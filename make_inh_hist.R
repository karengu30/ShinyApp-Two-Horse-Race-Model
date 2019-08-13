
make_inh_hist<- function (Individual,SRT,SSD,mRT,SSRT) {
Individual$inhibition<- as.factor(Individual$inhibition)
# print("MAKE_INH")
print(SRT)
# print(SSD)
# print(mRT)
# print(SSRT)
# print("END")
inh_hist<-ggplot(data=Individual, aes(Individual$Ind, fill=factor(Individual$inhibition)))+ geom_histogram()+ stat_bin(bins = 200)

inh_hist<-inh_hist + geom_segment(aes(x = SRT , y = 0, xend = SRT, yend = Inf),size = 1.5)
inh_hist<-inh_hist + geom_segment(aes(x = SSD, y = 0, xend = SSD, yend = Inf),size = 1.5)

delay <- -(SSD-mRT)
print(delay)

ttl <- paste("with mRT -", as.character(delay)," ms delay")

inh_hist <- inh_hist + labs(fill="response") + xlab("ms") + ggtitle(ttl)

return(inh_hist)
}
