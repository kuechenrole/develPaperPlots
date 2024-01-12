%function plotdhdt(exp,year1,year2)
exp='io0035'; year1='1979';year2='2018';

resultsDir='/albedo/work/projects/oce_rio/orichter/uacpl/results/';
%file1 = dir(fullfile(resultsDir,exp,[year1,'*.mat']));
%load(fullfile(file1.folder,file1.name));
%F1=F; MUA1=MUA; CtlrVar1=CtrlVar;

file2 = dir(fullfile(resultsDir,exp,[year2,'*.mat']));
load(fullfile(file2.folder,file2.name));
%F2=F; MUA2=MUA; CtlrVar2=CtrlVar;

f=figure;
PlotMeshScalarVariable(CtrlVar,MUA,F.dhdt)
clim([-1,1]);
cmocean('-balance')
hold on
GLgeo=GLgeometry(MUA.connectivity,MUA.coordinates,F.GF,CtrlVar);
TRI=[]; DT=[]; xGL=[] ; yGL=[] ;
x=MUA.coordinates(:,1);  y=MUA.coordinates(:,2);
%[xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,F.GF,GLgeo,xGL,yGL,'k');
%plot(GLgeo(:,[3 4])'/CtrlVar.PlotXYscale,GLgeo(:,[5 6])'/CtrlVar.PlotXYscale,'k','LineWidth',1);

%I=h<=CtrlVar.ThickMin;
%plot(MUA.coordinates(I,1)/CtrlVar.PlotXYscale,MUA.coordinates(I,2)/CtrlVar.PlotXYscale,'.r')
%title(sprintf('ice thickness change at t=%-g ',CtrlVar.time)) ; title(colorbar,'(m/yr)')
title(colorbar,'(m/yr)')
axis equal
axis off
grid on
%saveas(f, 'dhdt.png');
set(gca, 'Color', 'none'); 
export_fig dhdt.png -transparent -r 300
%exportgraphics(f,'dhdt.png','Resolution',300,'BackgroundColor','none')
%end