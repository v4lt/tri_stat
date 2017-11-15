# script R permettant de comparer les temps moyens de calcul des produits de matrices carrées entre algo classique et algo transposée
# pour des tailles variant de 2000 Ã  5000

library(ggplot2)
library(plyr)
library(reshape2)

data_thread1K <- data.frame(read.table(file="resultat/result1K.txt",sep=' ', dec='.',col.names=c("Nb_Thread", "Before_Crea","Crea_Thread","Wait","Tri","Destruct","Total")))
data_thread10K <-data.frame(read.table(file="resultat/result10K.txt",sep=' ', dec='.',col.names=c("Nb_Thread", "Before_Crea","Crea_Thread","Wait","Tri","Destruct","Total")))
data_thread100K<-data.frame(read.table(file="resultat/result100K.txt",sep=' ', dec='.',col.names=c("Nb_Thread", "Before_Crea","Crea_Thread","Wait","Tri","Destruct","Total")))
data_thread1M <- data.frame(read.table(file="resultat/result1M.txt",sep=' ', dec='.',col.names=c("Nb_Thread", "Before_Crea","Crea_Thread","Wait","Tri","Destruct","Total")))
# analyse statistique

stat_1K<-ddply(data_thread1K,c("Nb_Thread"),summarise,total=Total)
stat_10K<-ddply(data_thread10K,c("Nb_Thread"),summarise,total=Total)


# tracé des résultats obtenus

p <- ggplot()+scale_x_continuous(breaks=seq(0, 14, 1))
p <- p + geom_line(data=stat_1K, aes(x=Nb_Thread, y=total, colour = "1K Values"))+geom_point(data=stat_1K, aes(x=which.min(total),y=min(total),colour="fastest"))
p <- p + geom_line(data=stat_10K, aes(x=Nb_Thread, y=total, colour = "10K Values"))+geom_point(data=stat_10K, aes(x=which.min(total),y=min(total),colour="fastest"))

cbPalette <- c("1K Values"="#56B4E9","10K Values"="#009E73","100K Values"="#E69F00","1M Values"="#D55E00","fastest"="black")
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

pdf("pdf/Temps totals d'execution pour vecteurs de mille et 10 mille valeurs.pdf")
print(p+ ggtitle("Temps d'éxécution par thread pour des vecteurs \n de 1k et 10K valeurs"))
dev.off()



stat_100K<-ddply(data_thread100K,c("Nb_Thread"),summarise,total=Total)

p <- ggplot()+scale_x_continuous(breaks=seq(0, 12, 1))
p <- p + geom_line(data=stat_100K, aes(x=Nb_Thread, y=total, colour = "100K Values"))+geom_point(data=stat_100K, aes(x=which.min(total),y=min(total),colour="fastest"))

p <-  p + axis_x
p <- p + ylab("Temps de calcul (ms)")
p <-  p + themes
p <- p + scale_colour


pdf("pdf/Temps total d'execution pour vecteur de 100 mille valeurs.pdf")
print(p+ ggtitle("Temps d'éxécution par thread pour des vecteurs \n de 100k valeurs"))
dev.off()




stat_1M<-ddply(data_thread1M,c("Nb_Thread"),summarise,total=Total)
p <- ggplot()+scale_x_continuous(breaks=seq(0, 12, 1))
p <- p + geom_line(data=stat_1M, aes(x=Nb_Thread, y=total, colour = "1M Values"))+geom_point(data=stat_1M, aes(x=which.min(total),y=min(total),colour="fastest"))

p <-  p + axis_x
p <- p + ylab("Temps de calcul (ms)")
p <-  p + themes
p <- p + scale_colour

pdf("pdf/Temps total d'execution pour vecteur de 1 million valeurs.pdf")
print(p+ ggtitle("Temps d'éxécution par thread pour des vecteurs \n de 1M valeurs"))
dev.off()




stat_1K<-ddply(data_thread1K,c("Nb_Thread"),summarise,Before_Crea=Before_Crea)
stat_10K<-ddply(data_thread10K,c("Nb_Thread"),summarise,Before_Crea=Before_Crea)
stat_100K<-ddply(data_thread100K,c("Nb_Thread"),summarise,Before_Crea=Before_Crea)
stat_1M<-ddply(data_thread1M,c("Nb_Thread"),summarise,Before_Crea=Before_Crea)



p <- ggplot()+scale_x_continuous(breaks=seq(0, 12, 1))
p <- p + geom_line(data=stat_1K, aes(x=Nb_Thread, y=Before_Crea, colour = "1K Values"))+geom_point(data=stat_1K, aes(x=which.min(Before_Crea),y=min(Before_Crea),colour="fastest"))
p <- p + geom_line(data=stat_10K, aes(x=Nb_Thread, y=Before_Crea, colour = "10K Values"))+geom_point(data=stat_10K, aes(x=which.min(Before_Crea),y=min(Before_Crea),colour="fastest"))
p <- p + geom_line(data=stat_100K, aes(x=Nb_Thread, y=Before_Crea, colour = "100K Values"))+geom_point(data=stat_100K, aes(x=which.min(Before_Crea),y=min(Before_Crea),colour="fastest"))
p <- p + geom_line(data=stat_1M, aes(x=Nb_Thread, y=Before_Crea, colour = "1M Values"))+geom_point(data=stat_1M, aes(x=which.min(Before_Crea),y=min(Before_Crea),colour="fastest"))

p <-  p + axis_x
p <- p + ylab("Temps(ms)")
p <-  p + themes
p <- p + scale_colour


pdf("pdf/Temps d'initialisation.pdf")
print(p+ ggtitle("Comparaison des différents temps d'initialisation"))
dev.off()



stat_1M<-ddply(data_thread1M,c("Nb_Thread"),summarise,Crea_Thread=Crea_Thread)

p <- ggplot()+scale_x_continuous(breaks=seq(0, 12, 1))
p <- p + geom_line(data=stat_1M, aes(x=Nb_Thread, y=Crea_Thread, colour = "1M Values"))+geom_point(data=stat_1M, aes(x=which.min(Crea_Thread),y=min(Crea_Thread),colour="fastest"))

p <-  p + axis_x
p <- p + ylab("Temps(ms)")
p <-  p + themes
p <- p + scale_colour


pdf("pdf/Temps de creation des threads pour 1 million valeurs.pdf")
print(p+ ggtitle("Temps de creation des threads pour un vecteur de 1M valeurs"))
dev.off()



stat_1K<-ddply(data_thread1K,c("Nb_Thread"),summarise,Crea_Thread=Crea_Thread)
stat_10K<-ddply(data_thread10K,c("Nb_Thread"),summarise,Crea_Thread=Crea_Thread)
stat_100K<-ddply(data_thread100K,c("Nb_Thread"),summarise,Crea_Thread=Crea_Thread)

p <- ggplot()+scale_x_continuous(breaks=seq(0, 12, 1))
p <- p + geom_line(data=stat_1K, aes(x=Nb_Thread, y=Crea_Thread, colour = "1K Values"))+geom_point(data=stat_1K, aes(x=which.min(Crea_Thread),y=min(Crea_Thread),colour="fastest"))
p <- p + geom_line(data=stat_10K, aes(x=Nb_Thread, y=Crea_Thread, colour = "10K Values"))+geom_point(data=stat_10K, aes(x=which.min(Crea_Thread),y=min(Crea_Thread),colour="fastest"))
p <- p + geom_line(data=stat_100K, aes(x=Nb_Thread, y=Crea_Thread, colour = "100K Values"))+geom_point(data=stat_100K, aes(x=which.min(Crea_Thread),y=min(Crea_Thread),colour="fastest"))

p <-  p + axis_x
p <- p + ylab("Temps(ms)")
p <-  p + themes
p <- p + scale_colour


pdf("pdf/Temps de creation des threads pour vecteurs de mille, 10 mille et 100 mille valeurs.pdf")
print(p+ ggtitle("Comparaison des différents temps de la création des threads"))
dev.off()



stat_1K<-ddply(data_thread1K,c("Nb_Thread"),summarise,Wait=Wait)
stat_10K<-ddply(data_thread10K,c("Nb_Thread"),summarise,Wait=Wait)

p <- ggplot()+scale_x_continuous(breaks=seq(0, 12, 1))
p <- p + geom_line(data=stat_1K, aes(x=Nb_Thread, y=Wait, colour = "1K Values"))+geom_point(data=stat_1K, aes(x=which.min(Wait),y=min(Wait),colour="fastest"))
p <- p + geom_line(data=stat_10K, aes(x=Nb_Thread, y=Wait, colour = "10K Values"))+geom_point(data=stat_10K, aes(x=which.min(Wait),y=min(Wait),colour="fastest"))

p <-  p + axis_x
p <- p + ylab("Temps(ms)")
p <-  p + themes
p <- p + scale_colour


pdf("pdf/Temps d'attente de syncronisation pour des vecteurs de mille et 10 mille valeurs.pdf")
print(p+ ggtitle("Comparaison des temps d'attente de syncronisation \n des threads pour 1k et 10k valeurs"))
dev.off()


stat_100K<-ddply(data_thread100K,c("Nb_Thread"),summarise,Wait=Wait)

p <- ggplot()+scale_x_continuous(breaks=seq(0, 12, 1))
p <- p + geom_line(data=stat_100K, aes(x=Nb_Thread, y=Wait, colour = "100K Values"))+geom_point(data=stat_100K, aes(x=which.min(Wait),y=min(Wait),colour="fastest"))

p <-  p + axis_x
p <- p + ylab("Temps(ms)")
p <-  p + themes
p <- p + scale_colour


pdf("pdf/Temps d'attente de syncronisation des vecteurs de 100 mille vecteurs.pdf")
print(p+ ggtitle("Comparaison des temps d'attente de syncronisation \n des threads pour 100K valeurs"))
dev.off()



stat_1M<-ddply(data_thread1M,c("Nb_Thread"),summarise,Wait=Wait)
p <- ggplot()+scale_x_continuous(breaks=seq(0, 12, 1))
p <- p + geom_line(data=stat_1M, aes(x=Nb_Thread, y=Wait, colour = "1M Values"))+geom_point(data=stat_1M, aes(x=which.min(Wait),y=min(Wait),colour="fastest"))
p <-  p + axis_x
p <- p + ylab("Temps(ms)")
p <-  p + themes
p <- p + scale_colour
pdf("pdf/Comparaison des temps d'attente de syncronisation des threads \n pour 1M valeurs.pdf")
print(p+ ggtitle("Comparaison des temps d'attente de syncronisation \n des threads pour 1M valeurs"))
dev.off()


stat_1K<-ddply(data_thread1K,c("Nb_Thread"),summarise,Tri=Tri)
stat_10K<-ddply(data_thread10K,c("Nb_Thread"),summarise,Tri=Tri)
stat_100K<-ddply(data_thread100K,c("Nb_Thread"),summarise,Tri=Tri)
stat_1M<-ddply(data_thread1M,c("Nb_Thread"),summarise,Tri=Tri)

p <- ggplot()+scale_x_continuous(breaks=seq(0, 12, 1))
p <- p + geom_line(data=stat_1K, aes(x=Nb_Thread, y=Tri, colour = "1K Values"))+geom_point(data=stat_1K, aes(x=which.min(Tri),y=min(Tri),colour="fastest"))
p <- p + geom_line(data=stat_10K, aes(x=Nb_Thread, y=Tri, colour = "10K Values"))+geom_point(data=stat_10K, aes(x=which.min(Tri),y=min(Tri),colour="fastest"))
p <- p + geom_line(data=stat_100K, aes(x=Nb_Thread, y=Tri, colour = "100K Values"))+geom_point(data=stat_100K, aes(x=which.min(Tri),y=min(Tri),colour="fastest"))
p <- p + geom_line(data=stat_1M, aes(x=Nb_Thread, y=Tri, colour = "1M Values"))+geom_point(data=stat_1M, aes(x=which.min(Tri),y=min(Tri),colour="fastest"))

p <-  p + axis_x
p <- p + ylab("Temps(ms)")
p <-  p + themes
p <- p + scale_colour


pdf("pdf/Temps de tri pour des vecteurs de mille et 10 mille valeurs.pdf")
print(p+ ggtitle("Comparaison des différents temps de tri pour vecteurs \n de 1k et 10k valeurs"))
dev.off()






stat_100K<-ddply(data_thread100K,c("Nb_Thread"),summarise,Tri=Tri)

p <- ggplot()+scale_x_continuous(breaks=seq(0, 12, 1))
p <- p + geom_line(data=stat_100K, aes(x=Nb_Thread, y=Tri, colour = "100K Values"))+geom_point(data=stat_100K, aes(x=which.min(Tri),y=min(Tri),colour="fastest"))
p <-  p + axis_x
p <- p + ylab("Temps(ms)")
p <-  p + themes
p <- p + scale_colour


pdf("pdf/Temps de tri de vecteurs de 100 mille valeurs.pdf")
print(p+ ggtitle("Comparaison des différents temps de tri pour vecteurs \n de 100k valeurs"))
dev.off()


stat_1M<-ddply(data_thread1M,c("Nb_Thread"),summarise,Tri=Tri)

p <- ggplot()+scale_x_continuous(breaks=seq(0, 12, 1))
p <- p + geom_line(data=stat_1M, aes(x=Nb_Thread, y=Tri, colour = "1M Values"))+geom_point(data=stat_1M, aes(x=which.min(Tri),y=min(Tri),colour="fastest"))

p <-  p + axis_x
p <- p + ylab("Temps(ms)")
p <-  p + themes
p <- p + scale_colour


pdf("pdf/Temps de tri pour des vecteurs de 1 million valeurs.pdf")
print(p+ ggtitle("Comparaison des différents temps de tri pour vecteurs \n de 1M valeurs"))
dev.off()





stat_1K<-ddply(data_thread1K,c("Nb_Thread"),summarise,Destruct=Destruct)
stat_10K<-ddply(data_thread10K,c("Nb_Thread"),summarise,Destruct=Destruct)
stat_100K<-ddply(data_thread100K,c("Nb_Thread"),summarise,Destruct=Destruct)
stat_1M<-ddply(data_thread1M,c("Nb_Thread"),summarise,Destruct=Destruct)



p <- ggplot()+scale_x_continuous(breaks=seq(0, 12, 1))
p <- p + geom_line(data=stat_1K, aes(x=Nb_Thread, y=Destruct, colour = "1K Values"))+geom_point(data=stat_1K, aes(x=which.min(Destruct),y=min(Destruct),colour="fastest"))
p <- p + geom_line(data=stat_10K, aes(x=Nb_Thread, y=Destruct, colour = "10K Values"))+geom_point(data=stat_10K, aes(x=which.min(Destruct),y=min(Destruct),colour="fastest"))
p <- p + geom_line(data=stat_100K, aes(x=Nb_Thread, y=Destruct, colour = "100K Values"))+geom_point(data=stat_100K, aes(x=which.min(Destruct),y=min(Destruct),colour="fastest"))
p <- p + geom_line(data=stat_1M, aes(x=Nb_Thread, y=Destruct, colour = "1M Values"))+geom_point(data=stat_1M, aes(x=which.min(Destruct),y=min(Destruct),colour="fastest"))

p <-  p + axis_x
p <- p + ylab("Temps(ms)")
p <-  p + themes
p <- p + scale_colour


pdf("pdf/Temps de destruction des threads pour des vecteurs de differente taille.pdf")
print(p+ ggtitle("Comparaison des différents temps de destruction des threads"))
dev.off()
