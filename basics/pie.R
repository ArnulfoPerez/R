todos <- colors(T)
par(mfrow=c(2,2),oma=rep(0,4),mar=rep(0,4))
pie(rep(1,10),col=todos)
pie(rep(1,20),col=todos)
pie(rep(1,50),col=todos)
pie(rep(1,100),col=todos)

par(mfrow=c(1,1),oma=rep(0,4),mar=rep(0,4))
pie(rep(1,100))
pie(rep(1,100),col=1:100)
pie(rep(1,100),col=todos)
text(1,1,'¿cuales son las coordenadas?')
abline(h=c(-1,0,1),v=c(-1,0,1))
pie(rep(1,100),col=todos,radius = 0.5)
pie(rep(1,100),col=todos,radius = 0.8)
pie(rep(1,100),col=todos,radius = 1.0)
pie(rep(1,100),col=todos,radius = 1.0,labels = '')
