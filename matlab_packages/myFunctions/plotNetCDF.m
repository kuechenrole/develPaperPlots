function plotNetCDF(fileName)

time=ncread(fileName,'time');
VAF = ncread(fileName,'VAF');
SLE = ncread(fileName,'SLE');
SLED = ncread(fileName,'SLED');
GA = ncread(fileName,'GA');
IV = ncread(fileName,'IV');
IceExtent= ncread(fileName,'IceExtent');
IceShelfExtent= ncread(fileName,'IceShelfExtent');
GLFlux= ncread(fileName,'GLFlux');
BMB = ncread(fileName,'BMB');
SMB= ncread(fileName,'SMB');

figure('name','VAF');
movegui(1);
plot(time,VAF);
xlabel('time');
ylabel('VAF in km^3');
title('Volume Above Flotation in km^3');

figure('name','SLE');
plot(time,SLE);
%xlabel('time');
ylabel('SLE in m');
title('SLE in m');

figure('name','SLED');
plot(time,SLED);
%xlabel('time');
ylabel('SLE diff since start in mm');
title('SLE diff since start in mm');

figure('name','GA');
plot(time,GA);
xlabel('time');
ylabel('GA in km^2');
title('Grounded Area in km^2');

figure('name','IV');
plot(time,IV);
xlabel('time');
ylabel('IV in km^3');
title('Ice Volume in km^3');

figure('name','IceExtent');
plot(time,IceExtent);
xlabel('time');
ylabel('IceExtent in km^2');
title('Total Ice Extent in km^2');

figure('name','IceShelfExtent');
plot(time,IceShelfExtent);
xlabel('time');
ylabel('IceShelfExtent in km^2');
title('Total Floating Ice Extent in km^2');

figure('name','GLFlux');
plot(time,GLFlux);
xlabel('time');
ylabel('GLFlux in Gt/yr');
title('Flux across the grounding line in Gt/yr');

figure('name','SMB');
plot(time,SMB);
xlabel('time');
ylabel('SMB in Gt/yr');
title('Surface Mass Balance in Gt/yr');

figure('name','BMB');
plot(time,BMB);
xlabel('time');
ylabel('BMB in Gt/yr');
title('Basal Mass Balance in Gt/yr');

figure('name','MeanBasalMeltRate');
plot(time,-BMB.*1e12./917./(IceShelfExtent.*1e6));
xlabel('time');
ylabel('Melt Rate in m/yr');
title('Mean Basal Melt Rate in m/yr (positive=melting)');

figure('name','MeanBasalMeltRate');
mr = -BMB.*1e12./917./(IceShelfExtent.*1e6);
plot(time,mr./mean(mr).*100);
xlabel('time');
ylabel('Melt Rate in m/yr');
title('Mean Basal Melt Rate in m/yr (positive=melting)');

end