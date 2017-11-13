# script R permettant de comparer les temps moyens de calcul des produits de matrices carrées entre algo classique et algo transposée
# pour des tailles variant de 2000 à 5000


library(ggplot2)
library(plyr)
library(reshape2)

# extraction des données
data_thread1K <- data.frame(read.table(file="resultat/result1K.txt",sep=' ', dec='.',col.names=c("Nb_Thread", "Before_Crea","Crea_Thread","Wait","Tri","Destruct","Total")))
data_thread10K <- data.frame(read.table(file="resultat/result10K.txt",sep=' ', dec='.',col.names=c("Nb_Thread", "Before_Crea","Crea_Thread","Wait","Tri","Destruct","Total")))
data_thread100K <- data.frame(read.table(file="resultat/result100K.txt",sep=' ', dec='.',col.names=c("Nb_Thread", "Before_Crea","Crea_Thread","Wait","Tri","Destruct","Total")))
data_thread1M <- data.frame(read.table(file="resultat/result1M.txt",sep=' ', dec='.',col.names=c("Nb_Thread", "Before_Crea","Crea_Thread","Wait","Tri","Destruct","Total")))
# analyse statistique

stat_1K<-ddply(data_thread1K,c("Nb_Thread"),summarise,total=Total)
stat_10K<-ddply(data_thread10K,c("Nb_Thread"),summarise,total=Total)
stat_100K<-ddply(data_thread100K,c("Nb_Thread"),summarise,total=Total)
stat_1M<-ddply(data_thread1M,c("Nb_Thread"),summarise,total=Total)


# tracé des résultats obtenus

p <- ggplot()+scale_x_continuous(breaks=seq(0, 14, 1))+ expand_limits(y=min(stat_1K[,2]))

p <- p + geom_line(data=stat_1K, aes(x=Nb_Thread, y=total, colour = "1K Values"))
p <- p + geom_line(data=stat_10K, aes(x=Nb_Thread, y=total, colour = "10K Values"))

cbPalette <- c("1K Values"="#56B4E9","10K Values"="#009E73","100K Values"="#E69F00","1M Values"="#D55E00","point"="black")

themes <-  theme(panel.background = element_rect(fill = "lightgrey"),
                panel.grid.minor = element_line(colour = "black", linetype="dashed", size = 0.1),
                panel.grid.major = element_line(colour = "black", size = 0.1),
                plot.title = element_text(family = "Helvetica", face = "bold", size = (15)),
                axis.text = element_text(family = "Courier", colour = "black", size = (12)),
                legend.position="bottom")

axis_x <- xlab("Nombre de thread")

scale_colour <- scale_colour_manual("",values = cbPalette)

p <-  p + axis_x
p <- p + ylab("Temps de calcul (ms)")
p <-  p + themes
p <- p + scale_colour

pdf("pdf/1K_10K_Total_Exec.pdf")
print(p+ ggtitle("Temps d'éxécution par thread pour des vecteurs \n de 1k et 10K valeurs"))
dev.off()



p <- ggplot()+scale_x_continuous(breaks=seq(0, 14, 1))
p <- p + geom_line(data=stat_100K, aes(x=Nb_Thread, y=total, colour = "100K Values"))

p <-  p + axis_x
p <- p + ylab("Temps de calcul (ms)")
p <-  p + themes
p <- p + scale_colour


pdf("pdf/100K_Total_Exec.pdf")
print(p+ ggtitle("Temps d'éxécution par thread pour des vecteurs \n de 100k valeurs"))
dev.off()



p <- ggplot()+scale_x_continuous(breaks=seq(0, 14, 1))
p <- p + geom_line(data=stat_1M, aes(x=Nb_Thread, y=total, colour = "1M Values"))

p <-  p + axis_x
p <- p + ylab("Temps de calcul (ms)")
p <-  p + themes
p <- p + scale_colour

pdf("pdf/1M_Total_Exec.pdf")
print(p+ ggtitle("Temps d'éxécution par thread pour des vecteurs \n de 1M valeurs"))
dev.off()




stat_1K<-ddply(data_thread1K,c("Nb_Thread"),summarise,Before_Crea=Before_Crea)
stat_10K<-ddply(data_thread10K,c("Nb_Thread"),summarise,Before_Crea=Before_Crea)
stat_100K<-ddply(data_thread100K,c("Nb_Thread"),summarise,Before_Crea=Before_Crea)
stat_1M<-ddply(data_thread1M,c("Nb_Thread"),summarise,Before_Crea=Before_Crea)




p <- ggplot()+scale_x_continuous(breaks=seq(0, 14, 1))
p <- p + geom_line(data=stat_1K, aes(x=Nb_Thread, y=Before_Crea, colour = "1K Values"))
p <- p + geom_line(data=stat_10K, aes(x=Nb_Thread, y=Before_Crea, colour = "10K Values"))
p <- p + geom_line(data=stat_100K, aes(x=Nb_Thread, y=Before_Crea, colour = "100K Values"))
p <- p + geom_line(data=stat_1M, aes(x=Nb_Thread, y=Before_Crea, colour = "1M Values"))

p <-  p + axis_x
p <- p + ylab("Temps(ms)")
p <-  p + themes
p <- p + scale_colour


pdf("pdf/Before_Crea.pdf")
print(p+ ggtitle("Comparaison des différents temps avant la création"))
dev.off()
