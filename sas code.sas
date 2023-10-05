proc import datafile='/home/u50429604/winequalitywhite.xls' /*import xls file*/
	dbms='xls' /* specify the type of EXCEL file to read*/
	out=final replace /*name of the data set*/;
	getnames=yes;
	run;
proc corr data=final;
var quality fixedacidity volatileacidity citricacid residualsugar chlorides freesulfurdioxide totalsulfurdioxide density pH sulphates alcohol ;
run;
proc reg data=final;
model quality=fixedacidity volatileacidity citricacid residualsugar chlorides freesulfurdioxide totalsulfurdioxide density pH sulphates alcohol  / vif tol collin;
run;
/* 0<ridge<1 - Ridge Trace*/
proc reg data=final outvif plots(only)=ridge(unpack VIFaxis=log)
outest=pfinal ridge=0 to 1 by 0.1;
model quality=fixedacidity volatileacidity citricacid residualsugar chlorides freesulfurdioxide totalsulfurdioxide density pH sulphates alcohol ;
plot / ridgeplot nomodel nostat;
run;
proc print data=pfinal;
run;
/* Ridge : k=0.1*/
proc reg data=final outvif plots(only)=ridge(unpack VIFaxis=log)
outest=pfinal ridge=0.1;
model quality=fixedacidity volatileacidity citricacid residualsugar chlorides freesulfurdioxide totalsulfurdioxide density pH sulphates alcohol ;
plot / ridgeplot nomodel nostat;
run;
proc print data=pfinal;
run;
/* Ridge : Outseb*/
proc reg data=final outvif plots(only)=ridge(unpack VIFaxis=log)
outest=pfinal outseb ridge=0.1;
model quality=fixedacidity volatileacidity citricacid residualsugar chlorides freesulfurdioxide totalsulfurdioxide density pH sulphates alcohol ;
plot / ridgeplot nomodel nostat;
run;
proc print data=pfinal;
run;