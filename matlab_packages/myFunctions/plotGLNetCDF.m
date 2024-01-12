%function plotGLNetCDF(fileName,freq)
fileName='GL2.nc';
set(gca,'DefaultTextFontSize',24)
time=ncread(fileName,'time');
xGL= ncread(fileName,'xGL')./1000;
yGL = ncread(fileName,'yGL')./1000;

%figure('name','GL positions');
%cmap=cmocean('phase');
plot(xGL(:,1),yGL(:,1),'LineWidth',2,'LineStyle',':','DisplayName',string(int32(time(1))),'color','k');
hold on;
plot(xGL(:,end),yGL(:,end),'LineWidth',2,'DisplayName',string(int32(time(end))),'color','k');
%colororder(jet(size(time,1)));
%for k = 1:freq:length(time)
%    plot(xGL(:,k),yGL(:,k),'LineWidth',2,'DisplayName',string(int32(time(k))));
%    hold on
%end
lgd = legend('NumColumns',2,Location='bestoutside');
title(lgd,['year']);
%title('Grounding line positions at different times')
axis equal;

%end