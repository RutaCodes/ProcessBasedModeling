Julian_day<-function(date){
  #date2=as.date(date)
  date_f=as.Date(date,format="%m/%d/%y")
  #jul_day=julian(date_f)
  jul_day=date$yday+1
  year=date$year+1900
  minyear = min(year);
  maxyear = max(year);
  
  jdc_com=matrix(0,)
  for (i in seq (minyear,maxyear)){
    b=which(year==i)
    jdc=seq(1,length(b)) #one year
    jdc_com[,i]=jdc
  }
}



minyear = min(date);
maxyear = max(date);

for (i in seq (minyear,maxyear)){
  b=which(year==i)
  jdc=seq(1,length(b))
}
[~,b] = find(year == i);
jdc = (1:length(b))';
   
    if length(b) < 365;
        jdc = ((365 - length(b) + 1): 365)';
if i == minyear;
jdall = jdc;
elseif i == maxyear;
#jdc = (1:length(b))';
            jdall = vertcat(jdall,jdc);
        else
            jdall = vertcat(jdall,jdc);
        end;
        
    else
        if i == minyear;
            jdall = jdc;
        else
            jdall = vertcat(jdall,jdc);
        end;
    end;
end;
return(jdall)
}
