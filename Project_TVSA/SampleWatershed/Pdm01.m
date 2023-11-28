function [OV,ET,Hend,Cend] = Pdm01(Hpar,Bpar,Hbeg,PP,PET);

b    = log(1-(Bpar/2))/log(0.5);
Cpar = Hpar/(1+b);
Cbeg = Cpar*(1-power((1-(Hbeg/Hpar)),(1+b)));

OV2   = max(PP+Hbeg-Hpar,0);
PPinf = PP-OV2;

Hint = min((PPinf+Hbeg),Hpar);
Cint = Cpar*(1-power((1-(Hint/Hpar)),(1+b)));
OV1  = max(PPinf+Cbeg-Cint,0);

OV = OV1+OV2;

%Function output
ET   = min(PET,Cint);
Cend = Cint-ET;
Hend = Hpar*(1-power((1-Cend/Cpar),1/(1+b)));