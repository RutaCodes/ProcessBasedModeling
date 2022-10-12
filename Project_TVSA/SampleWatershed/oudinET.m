function [PE] = oudinET(J,Ta,lat)

% Initialize PET
PE = zeros(length(Ta),1);

% Latitude
hat = lat*2*pi/360;%deg to rad

% Earth rotation
omega = 0.2618; % rad/hr (15 deg/hr)

% Day angle
dayangle = (2*pi*(J-1))/365; % radians

% Declination
dec = 0.006918-0.399912*cos(dayangle)+0.070257*sin(dayangle)-0.006758*cos(2*dayangle)...
    +0.000907*sin(2*dayangle)-0.002697*cos(3*dayangle)+0.00148*sin(3*dayangle);% output in radians

% Eccentricity
Eo = 1.000110+0.034221*cos(dayangle)+0.001280*sin(dayangle)+0.000719*cos(2*dayangle)+0.000077*sin(2*dayangle);

% Timing of sunset
Ts = acos(-tan(dec)*tan(hat))/(omega);

%Zenith angle
%zen = acos(sin(hat)*sin(dec)+cos(hat)*cos(dec)*cos(om*t));

% Daily Extraterrestrial radiation (MJ/m2*day)
ket = 2.*4.921.*Eo.*(cos(dec).*cos(hat).*sin(omega.*Ts)./omega+sin(dec).*sin(hat).*Ts);
%ket = 2*(4.910).*Eo.*(sin(hat).*sin(dec).*Ts+(cos(hat).*cos(dec).*sin(omega.*Ts))./omega);
%ket = ket * 11.575; % MJ/m2 to W/m2

latentheat = 2.45; %MJ kg-1
denom = latentheat * 1000; % (MJ/kg)*(kg/m3) = MJ m-3

% PE in mm/day
for i = 1:length(Ta);
    if (Ta(i) + 5) > 0;
        PE(i,1) = (ket(i,1)/(denom)) * (Ta(i,1)+5)/100;
    else
        PE(i,1) = 0;
    end;
end;
