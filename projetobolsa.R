
#### PACKAGES INSTALLATION ####
#### REMOVE TAG IF PACKAGE IS NOT INSTALLED ####

#install.packages("quantmod")
#install.packages("xts")
#install.packages("moments")

list.of.packages <- c("quantmod", "xts","moments","ggplot2")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(quantmod)
library(xts)
library(moments)
library(ggplot2)

#### CLEAR YOUR ENVIRONMENT ####

rm(list=ls())

#### CONFIGURE YOUR QUERY ####

startDate = as.Date("2017-01-01")
endDate = as.Date("2018-11-30")
carteira<-c("PETR4.SA","ITSA4.SA","UNIP6.SA","SHUL4.SA","BRSR6.SA")
#carteira<-c("MILS3.SA","OFSA3.SA")
pathtocsv<-("E:/bolsa.csv")
carteira

#### START THE CODE ####

#### CREATE XTS OBJECT FOR EACH STOCK ####

for(i in carteira){
  
 getSymbols(i, src = "yahoo", from = startDate, to = endDate, auto.assign = T)
  
}

#### UNITE ALL XTS OBJECTS IN A LIST ####

list_xts <- Filter(function(x) is(x, "xts"), mget(ls()))
names(list_xts[i])

#### TRANSFORMS ALL XTS INTO DATAFRAMES ####

for(i in names(list_xts)){
  
   df<-paste("df",i, sep = "")
   assign(df,data.frame(Date=index(list_xts[[i]]), coredata(list_xts[[i]]),Empresa=(substr(names(list_xts[i]),1,5))))
   
}

#### UNITE DATAFRAMES IN A LIST ####

list_dfs <- Filter(function(x) is(x, "data.frame"), mget(ls()))

#### RENAME ALL DATAFRAMES TO THE SAME COL NAME ####

j<-1
for(j in j:length(list_dfs)){
 
  colnames(list_dfs[[j]])<-c("Date","Open","High","Low","Close","Volume","Adjusted","Company")
  
}

#### UNITE ALL DATAFRAMES INTO 1 DATAFRAME ####

df_final<-do.call("rbind", list_dfs)

#### REMOVE ROW NAMES ####

rownames(df_final)<-NULL

    apply(df_final, 2, function(x) any(is.na(df_final)))

str(df_final)
#### EXPORTS TO CSV ####

write.csv2(df_final,pathtocsv, row.names=FALSE)

#### PLOT CHART STOCK QUOTATION####
ggplot(data=df_final,
       aes(x=Date, y=Close, colour=Company)) +
  geom_line()
