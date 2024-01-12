
%%
basedir = '/albedo/work/projects/oce_rio/orichter/ollieWork/Misomip2/';
maskfile=[basedir,'oo0012/fesomInitialMesh/2dExtended/RTopo-2.0.4_30sec_mesh_gen_mask_CI11_cpl.nc'];
maskM=ncread(maskfile,'topo');
latM=ncread(maskfile,'lat');
lonM=ncread(maskfile,'lon');

densfile=[basedir,'oo0012/fesomInitialMesh/2dExtended/density_COARZE_mesh_improved_11_cpl_or3.nc'];
dens=ncread(densfile,'density');
lat=ncread(densfile,'lat');
lon=ncread(densfile,'lon');

%maskfile='/isibhv/projects/oce_rio/rtimmerm/RTopo-2/compile_rtopo2_0_4/RTopo-2.0.4_1min_aux_2019-07-12.nc';
%lonM=ncread(maskfile,'lon');
%latM=ncread(maskfile,'lat');
%maskM=ncread(maskfile,'amask');

[lonM2d,latM2d]=meshgrid(lonM(1,1:10:end),latM(2,1:10:end));
F = griddedInterpolant(lonM2d',latM2d',single(maskM(1:10:end,1:10:end)),'nearest','none');

[lon2d,lat2d]=meshgrid(lon,lat);
mask=F(lon2d',lat2d');

%dens((mask==1) | (mask==3))=NaN;
dens(mask>0)=NaN;
dens(dens<2)=2;


f = figure;
f.Position = [0 0 872 400];

subplot(2,2,1)
newdens=dens;
tickVals = linspace(2,300,9);
newTickVals=[0,2,5,10,20,50,100,200,300];
for tv = 2:length(newTickVals)
    % find all data between the new tick ranges, one block at a time
    ind = dens>newTickVals(tv-1) & dens<=newTickVals(tv);
    % Change the corresponding values in the copied data to scale to the
    % block edges
    newdens(ind) = rescale(dens(ind),tickVals(tv-1),tickVals(tv));
end
contourf(lon,lat,newdens',tickVals)
C=parula(8);
%C(end+1,:)=1;
colormap(C);
cb=colorbar('Ticks',tickVals,...
    'TickLabels',["0" "2" "5" "10" "20" "50" "100" "200" "300"])
%title(cb, 'Resolution in km')
ylabel(cb,'Resolution in km')
set(gcf,'color','w');
%fontsize(gcf,16,"points");
xlabel(['longitude (' char(176) ')' newline '(a)']);
ylabel(['latitude (' char(176) ')']);


subplot(2,2,2)
newdens=dens;
tickVals = linspace(2,300,11);
newTickVals=[0,2,4,8,10,15,20,35,50,100,200];
for tv = 2:length(newTickVals)
    % find all data between the new tick ranges, one block at a time
    ind = dens>newTickVals(tv-1) & dens<=newTickVals(tv);
    % Change the corresponding values in the copied data to scale to the
    % block edges
    newdens(ind) = rescale(dens(ind),tickVals(tv-1),tickVals(tv));
end
contourf(lon,lat,newdens',tickVals)
C=parula(10);
%C(end+1,:)=1;
colormap(C);
cb=colorbar('Ticks',tickVals,...
    'TickLabels',["0" "2" "4" "8" "10" "15" "20" "35" "50" "100" "200"]);
axis([-180 180 -87 -57])
ylabel(cb,'Resolution in km')
set(gcf,'color','w');

xlabel(['longitude (' char(176) ')' newline '(b)']);
ylabel(['latitude (' char(176) ')']);



ax = subplot(2,2,3)
load('/albedo/work/projects/oce_rio/orichter/uacpl/results/io0036/1979.00-Nodes129738-Ele254869-Tri3-kH1000-Antarctic-Forward-MeshFile.mat.mat', ...
    'MUA','BCs','F','CtrlVar')

dens=sqrt(MUA.EleAreas.*4).*(3^(-1/4))./1000-1;
newdens=dens;
tickVals = linspace(2,200,9);
newTickVals=[0,2,5,10,20,50,100,150,200];
for tv = 2:length(newTickVals)
    % find all data between the new tick ranges, one block at a time
    ind = dens>=newTickVals(tv-1) & dens<newTickVals(tv);
    % Change the corresponding values in the copied data to scale to the
    % block edges
    newdens(ind) = rescale(dens(ind),tickVals(tv-1),tickVals(tv));
end
PlotElementBasedQuantities(MUA.connectivity,MUA.coordinates,newdens,CtrlVar);
C=parula(8);
%C(end+1,:)=1;
colormap(C);
cb=colorbar('Ticks',tickVals,...
    'TickLabels',["0" "2" "5" "10" "20" "50" "100" "150" "200"]);
%cb = colorbar;
ylabel(cb,'Resolution in km')
axis off;
ax.XAxis.Label.Visible = 'on';
xlabel('(c)')
ylabel('')
set(gcf,'color','w');
%hold on; [~,~,~,~,~,hlat,~,hlon]=PlotLatLonGrid(1000); hold off;
%set(cb,'YTick',[2 20 40 60 80 100 120 140 160 180]);
%hold on
%[xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,F.GF,GLgeo,xGL,yGL,'k');
%caxis([2 200])
%ylabel(cb,'Resolution in km','FontSize',12,'Rotation',270)

ax=subplot(2,2,4);

load('/albedo/work/projects/oce_rio/orichter/uacpl/results/ii0040/19790-FW-Antarctic-Forward-MeshFileAdapt3-local.mat.mat',...
    'MUA','BCs','F','CtrlVar');

meshpath='/albedo/work/projects/oce_rio/orichter/ollieWork/Misomip2/oo0021/fesomInitialMesh/';


nod2d_file=[meshpath,'nod2d.out'];
elem2d_file=[meshpath,'elem2d.out'];
cflag_file=[meshpath,'cavity_flag_nod2d.out'];

derotate=1;

fid=fopen(nod2d_file,'r');
n2d=fscanf(fid,'%g',1);
nodes=fscanf(fid, '%g', [4,n2d]);
fclose(fid);
if derotate
    alpha=50;
    beta=15;
    gamma=-90;
    [nlon,nlat]=grid_rotate_r2g(alpha,beta,gamma,nodes(2,:),nodes(3,:));
else
    nlon=nodes(2,:);
    nlat=nodes(3,:);
end

fid=fopen(elem2d_file);
el2d=fscanf(fid,'%g',1);
elem=fscanf(fid,'%g',[3 el2d]);
fclose(fid);

[xFes,yFes]=polarstereo_fwd(nlat',nlon',6378137.0,0.08181919,-71,0);

MUAHack=MUA;
MUAHack.coordinates=[xFes yFes];
MUAHack.connectivity=elem';
MUAHack.Nele=el2d;

CtrlVar.WhenPlottingMesh_PlotMeshBoundaryCoordinatesToo=0;
CtrlVar.PlotIndividualGLs=1 ; 
PlotMuaMesh(CtrlVar,MUAHack,[],'color','b') ;
hold on
PlotMuaMesh(CtrlVar,MUA,[],'k') ;
[xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,F.GF,[],[],[],'color','r');
hold off

axis([-1700 -1550 -370 -240]);
axis off;
ax.XAxis.Label.Visible = 'on';
xlabel(['(d)' newline])

hold on;
for x=-1625:8:-1593
    for y=-368:8:-336

plot([-1625 -1593],[y y],'b','Linewidth',1)
plot([x x],[-368 -336],'b','Linewidth',1)
    end
end
hold off
title('');

f.Position = [0 0 872 600];
exportgraphics(f,'./figures/meshAll.png','BackgroundColor','none','Resolution',300);



%% below just devel stuff
f = figure;
f.Position = [100 100 740 600];
newdens=dens;
tickVals = linspace(2,300,9);
newTickVals=[0,2,5,10,20,50,100,200,300];
for tv = 2:length(newTickVals)
    % find all data between the new tick ranges, one block at a time
    ind = dens>newTickVals(tv-1) & dens<=newTickVals(tv);
    % Change the corresponding values in the copied data to scale to the
    % block edges
    newdens(ind) = rescale(dens(ind),tickVals(tv-1),tickVals(tv));
end
contourf(lon,lat,newdens',tickVals)
C=parula(8);
%C(end+1,:)=1;
colormap(C);
cb=colorbar('Ticks',tickVals,...
    'TickLabels',["0" "2" "5" "10" "20" "50" "100" "200" "300"])
%title(cb, 'Resolution in km')
ylabel(cb,'Resolution in km')
set(gcf,'color','w');
fontsize(gcf,16,"points");
xlabel(['longitude (' char(176) ')']);
ylabel(['latitude (' char(176) ')']);
pos = get(gca, 'Position');
set(gca, 'Position', [pos(1) pos(2) pos(3)-0.02 pos(4)]);
%savefig('./figures/densTotal.fig');
saveas(gcf,'figures/fesomResolutionTotal.png');



%%
f = figure;
f.Position = [100 100 740 600];
newdens=dens;
tickVals = linspace(2,300,11);
newTickVals=[0,2,4,8,10,15,20,35,50,100,200];
for tv = 2:length(newTickVals)
    % find all data between the new tick ranges, one block at a time
    ind = dens>newTickVals(tv-1) & dens<=newTickVals(tv);
    % Change the corresponding values in the copied data to scale to the
    % block edges
    newdens(ind) = rescale(dens(ind),tickVals(tv-1),tickVals(tv));
end
contourf(lon,lat,newdens',tickVals)
C=parula(10);
%C(end+1,:)=1;
colormap(C);
cb=colorbar('Ticks',tickVals,...
    'TickLabels',["0" "2" "4" "8" "10" "15" "20" "35" "50" "100" "200"])
axis([-180 180 -87 -57])
ylabel(cb,'Resolution in km')
set(gcf,'color','w');
fontsize(gcf,16,"points");
xlabel(['longitude (' char(176) ')']);
ylabel(['latitude (' char(176) ')']);
pos = get(gca, 'Position');
set(gca, 'Position', [pos(1) pos(2) pos(3)-0.02 pos(4)]);
%pos = get(gca, 'Position');
%set(gca, 'Position', [pos(1)-1 pos(2) pos(3)+1 pos(4)]);
saveas(gcf,'figures/fesomResolutionSouthOwnColobar.png')


%%
f = figure;
f.Position = [100 100 540 400];
newdens=dens;
tickVals = linspace(2,50,9);
newTickVals=[0,2,5,10,15,20,30,40,50];
for tv = 2:length(newTickVals)
    % find all data between the new tick ranges, one block at a time
    ind = dens>newTickVals(tv-1) & dens<=newTickVals(tv);
    % Change the corresponding values in the copied data to scale to the
    % block edges
    newdens(ind) = rescale(dens(ind),tickVals(tv-1),tickVals(tv));
end
contourf(lon,lat,newdens',tickVals)
axis([-180 180 -87 -57])

C=parula(8);
%C(end+1,:)=1;
colormap(C);
cb=colorbar('Ticks',tickVals,...
    'TickLabels',["0" "2" "5" "10" "15" "20" "30" "40" ">50"])
ylabel(cb,'Resolution in km')
set(gcf,'color','w');
fontsize(gcf,12,"points");
xlabel(['longitude (' char(176) ')']);
ylabel(['latitude (' char(176) ')']);
%savefig('./figures/densTotal.fig');
%saveas(gcf,'figures/fesomResolutionTotal.png');
%%





%levels=[2,3,4,5,6,7,8,9,10,20];
%contourf(lon,lat,log(dens'),log(levels),'LineColor','None')
%contourf(lon,lat,log(dens'))
contourf(lon,lat,dens',levels)
%set(gca,'colorscale','log');
%colormap(parula);
%hold on
%contour(lon,lat,dens',levels,'k')
%hold off
c=colorbar;
%set(cb,'YTick',log([2 10 20 30 40 50 60]));
%%
%c.TickLabels=string(round(exp(str2double(c.TickLabels))));
ylabel(c,'Resolution in km');
set(gcf,'color','w');
fontsize(gcf,12,"points");
xlabel(['longitude (' char(176) ')']);
ylabel('latitude')
%savefig('./figures/densTotal.fig');
%%saveas(gcf,'figures/densTotal.png');


%%
figure(4)
contourf(lon,lat,log(dens'))
colormap(parula)
c=colorbar;
c.TickLabels=string(round(exp(str2double(c.TickLabels))));
xlabel('Longitude in deg')
ylabel('Latitude in deg')
ylabel(c,'Resolution in km');
axis([-180 180 -86 -50])
%axis([-130 -75 -76 -64]);
%savefig('./figures/densDetailPIG.fig');
axes('position',[.5 .12 .25 .25])
box on
contourf(lon,lat,log(dens'))
axis off
%saveas(gcf,'figures/densSouth.png');

axis([-130 -75 -76 -64]);
%savefig('./figures/densDetailFRIS.fig');
%saveas(gcf,'figures/densDetailFRIS.png');
