
media<-mean(normal$Qtd)
sigma<-sd(normal$Qtd)
x<-90
x0<-40

range<- seq(media-4*sigma,media+4*sigma,0.01)
y = dnorm(range,media,sigma)
plot(range,y,main =, type='l',ylim = c(0,max(y)+0.01))

cord.a= c(0, seq(min(range),x,0.01),x)
cord.b = c(0, dnorm(seq(min(range),x,0.01),media,sigma),0)
polygon(cord.a,cord.b, col="blue")

cord.x= c(0, seq(min(range),x0,0.01),x0)
cord.y = c(0, dnorm(seq(min(range),x0,0.01),media,sigma),0)
polygon(cord.x,cord.y, col="yellow")

cord.c= c(x, seq(x,max(range),0.01),x)
cord.d = c(0, dnorm(seq(x,max(range),0.01),media,sigma),0)
polygon(cord.c, cord.d, col="yellow")

percent <- function(x, digits = 2, format = "f", ...) {
  paste0(formatC(100 * x, format = format, digits = digits, ...), "%")
}

percent(pnorm(x,media,sigma)-pnorm(x0,media,sigma))

