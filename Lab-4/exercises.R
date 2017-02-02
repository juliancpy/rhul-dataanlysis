power<-function(){
  power<-2^3;
  print(power);
}

power2<-function(x, a){
  power<-x^a;
  print(power);
}
power2(10,3)
power2(8,17)
power2(131,3)

power3<-function(x, a){
  power3 = x^a;
  return(power3)
}
print(power3(8,2))

x<-1:10
y=power3(x, 2)
plot(x,y)

PlotPower<-function(x, a){
  power3 = x^a;
  plot(x, power3)
}

PlotPower(1:10, 3)

sum2<-function(n){
  v<-1:n;
  sum(v^2)
}
sum2(3)


sum3<-function(n){
  v<-1:n;
  sum(v^3)
}
sum3(3)
