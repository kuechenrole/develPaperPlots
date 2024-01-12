%%

load('/albedo/work/projects/oce_rio/orichter/uacpl/results/io0036/1979.00-Nodes129738-Ele254869-Tri3-kH1000-Antarctic-Forward-MeshFile.mat.mat');
MUAspin=MUA; Fspin=F;
[VAF,IceVolume,GroundedArea,hAF,hfPos]=CalcVAF([],MUA,F.h,F.B,F.S,F.rho,F.rhow,F.GF);
hAFspin=hAF;

load('/albedo/work/projects/oce_rio/orichter/uacpl/results/io0036/2018.00-Nodes129561-Ele254536-Tri3-kH1000-Antarctic-Forward-MeshFile.mat.mat');
[VAF,IceVolume,GroundedArea,hAF,hfPos]=CalcVAF([],MUA,F.h,F.B,F.S,F.rho,F.rhow,F.GF);

[RunInfo,hAFSpin] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAspin,MUA,NaN,hAFspin);
[RunInfo,hSpin] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAspin,MUA,NaN,Fspin.s-Fspin.b);

f=FindOrCreateFigure('Pig change');
%t = tiledlayout(2,2,'TileSpacing','Compact','Padding','Compact');

ax1=subplot(2,3,1);
GLgeo=[]; xGL=[] ; yGL=[];
[~,cbar] = PlotMeshScalarVariable(CtrlVar,MUAspin,-Fspin.ab);
ylabel(cbar,'Melt rate (m/yr)'); title(sprintf(""),interpreter="latex");
set(gcf,'color','w');
cmocean('thermal')
caxis([0,100]);
set(cbar,'YTick',0:20:100);
hold on
GLgeo=[]; xGL=[] ; yGL=[];
PlotGroundingLines(CtrlVar,MUAspin,Fspin.GF,GLgeo,xGL,yGL,'color',[0.5,0.5,0.5],'Linewidth',2);
%GLgeo=[]; xGL=[] ; yGL=[];
%PlotGroundingLines(CtrlVar,MUAspin,Fspin.GF,GLgeo,xGL,yGL,'k');
hold off
xlim([-1695 -1535])
ylim([-375 -200])
axis('off');
ax1.XAxis.Label.Visible = 'on';
xlabel('(a)')

ax2=subplot(2,3,2);
GLgeo=[]; xGL=[] ; yGL=[];
[~,cbar] = PlotMeshScalarVariable(CtrlVar,MUA,((F.s-F.b)-hSpin)./39);
ylabel(cbar,"Ice thickness trend (m/yr)") ; %title(sprintf("coupling, Cd=0.025",CtrlVar.time),interpreter="latex");
set(gcf,'color','w');
cmocean('balance')

caxis([-12,12]);
%set(cbar,'YTick',-500:100:500);
hold on
GLgeo=[]; xGL=[] ; yGL=[];
PlotGroundingLines(CtrlVar,MUAspin,Fspin.GF,GLgeo,xGL,yGL,'magenta','Linewidth',2);%,[0.5,0.5,0.5]);
PlotGroundingLines(CtrlVar,MUA,F.GF,GLgeo,xGL,yGL,'k','Linewidth',2);
hold off
xlim([-1695 -1535])
ylim([-375 -200])
%xlim([-1700 -1550])
%ylim([-400 -220])
axis('off');
ax2.XAxis.Label.Visible = 'on';
xlabel(['(b)' newline]);

ax3=subplot(2,3,3);
GLgeo=[]; xGL=[] ; yGL=[];
[~,cbar]=PlotMeshScalarVariable(CtrlVar,MUA,(hAF-hAFSpin)./39) ;
ylabel(cbar,"Height above flotation trend (m/yr)") ; title("",interpreter="latex")
%colorbar('off')
%set(cbar,'YTick',-2:0.5:2)
%axis tight
axis off
%hold on ; PlotLatLonGrid(CtrlVar.PlotXYscale) ;
hold on ; PlotGroundingLines(CtrlVar,MUA,F.GF,[],[],[],'k','Linewidth',1);hold off;
%xlabel("xps (km)",interpreter="latex") ; ylabel("yps (km)",interpreter="latex") ; 
%ylabel(cbar,"HAF trend (m/yr)") ; title("Height Above Flotation trend",interpreter="latex")
%fprintf("VAF=%f (Gt/yr)\n",VAF.Total/1e9)   ; 
%fprintf("GroundedArea=%-7.2f (times the area of iceland)\n",GroundedArea.Total/1e6/103e3) ; 
%colormap(othercolor('Blues7',1024));
%colormap(bluewhitered);
cmocean('-balance')
caxis([-2,2])
xlim([-1950 -1100])
ylim([-700 200])
axis('off');
ax3.XAxis.Label.Visible = 'on';
xlabel(['(c)' newline]);

%%

load('/albedo/work/projects/oce_rio/orichter/uacpl/results/ii0047/20000-FW-Antarctic-Forward-MeshFileAdapt3-local.mat.mat');
MUAspin=MUA; Fspin=F;
[VAF,IceVolume,GroundedArea,hAF,hfPos]=CalcVAF(CtrlVar,MUA,F.h,F.B,F.S,F.rho,F.rhow,F.GF);
hAFspin=hAF;

load('/albedo/work/projects/oce_rio/orichter/uacpl/results/ii0047/20380-FW-Antarctic-Forward-MeshFileAdapt3-local.mat.mat');
[VAF,IceVolume,GroundedArea,hAF,hfPos]=CalcVAF(CtrlVar,MUA,F.h,F.B,F.S,F.rho,F.rhow,F.GF);

[RunInfo,hAFSpin] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAspin,MUA,NaN,hAFspin);
[RunInfo,hSpin] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAspin,MUA,NaN,Fspin.s-Fspin.b);


ax4=subplot(2,3,4);
GLgeo=[]; xGL=[] ; yGL=[];
[~,cbar] = PlotMeshScalarVariable(CtrlVar,MUAspin,-Fspin.ab);
ylabel(cbar,'Melt rate (m/yr)'); title(sprintf(""),interpreter="latex");
set(gcf,'color','w');
cmocean('thermal')
caxis([0,100]);
set(cbar,'YTick',0:20:100);
hold on
GLgeo=[]; xGL=[] ; yGL=[];
PlotGroundingLines(CtrlVar,MUAspin,Fspin.GF,GLgeo,xGL,yGL,'color',[0.5,0.5,0.5],'Linewidth',2);
%GLgeo=[]; xGL=[] ; yGL=[];
%PlotGroundingLines(CtrlVar,MUAspin,Fspin.GF,GLgeo,xGL,yGL,'k');
hold off
xlim([-1695 -1535])
ylim([-375 -200])
axis('off');
ax4.XAxis.Label.Visible = 'on';
xlabel('(d)')

ax5=subplot(2,3,5);
GLgeo=[]; xGL=[] ; yGL=[];
[~,cbar] = PlotMeshScalarVariable(CtrlVar,MUA,((F.s-F.b)-hSpin)./38);
ylabel(cbar,"Ice thickness trend (m/yr)") ; %title(sprintf("coupling, Cd=0.025",CtrlVar.time),interpreter="latex");
set(gcf,'color','w');
cmocean('balance')

caxis([-12,12]);
%set(cbar,'YTick',-500:100:500);
hold on
GLgeo=[]; xGL=[] ; yGL=[];
PlotGroundingLines(CtrlVar,MUAspin,Fspin.GF,GLgeo,xGL,yGL,'magenta','Linewidth',2);%,[0.5,0.5,0.5]);
PlotGroundingLines(CtrlVar,MUA,F.GF,GLgeo,xGL,yGL,'k','Linewidth',2);
hold off
xlim([-1695 -1535])
ylim([-375 -200])
%xlim([-1700 -1550])
%ylim([-400 -220])
axis('off');
ax5.XAxis.Label.Visible = 'on';
xlabel(['(e)' newline]);

ax6=subplot(2,3,6);
GLgeo=[]; xGL=[] ; yGL=[];
[~,cbar]=PlotMeshScalarVariable(CtrlVar,MUA,(hAF-hAFSpin)./38) ;
ylabel(cbar,"Height above flotation trend (m/yr)") ; title("",interpreter="latex")
%colorbar('off')
%set(cbar,'YTick',-2:0.5:2)
%axis tight
axis off
%hold on ; PlotLatLonGrid(CtrlVar.PlotXYscale) ;
hold on ; PlotGroundingLines(CtrlVar,MUA,F.GF,[],[],[],'k','Linewidth',1);hold off;
%xlabel("xps (km)",interpreter="latex") ; ylabel("yps (km)",interpreter="latex") ; 
%ylabel(cbar,"HAF trend (m/yr)") ; title("Height Above Flotation trend",interpreter="latex")
%fprintf("VAF=%f (Gt/yr)\n",VAF.Total/1e9)   ; 
%fprintf("GroundedArea=%-7.2f (times the area of iceland)\n",GroundedArea.Total/1e6/103e3) ; 
%colormap(othercolor('Blues7',1024));
%colormap(bluewhitered);
cmocean('-balance')
caxis([-2,2])
xlim([-1950 -1100])
ylim([-700 200])
axis('off');
ax6.XAxis.Label.Visible = 'on';
xlabel(['(f)' newline]);


f.Position=([0 0 872 500]);
%pos=get(ax1,'position'); set(ax1,'position',[pos(1)+0.2 pos(2) pos(3) pos(4)])
%pos=get(ax3,'position'); set(ax3,'position',[pos(1)+0.2 pos(2) pos(3) pos(4)])
exportgraphics(f,['figures/pigResponse.png'],'Resolution',300);

%% below just devel stuff




load('/albedo/work/projects/oce_rio/orichter/uacpl/results/io0036/1979.00-Nodes129738-Ele254869-Tri3-kH1000-Antarctic-Forward-MeshFile.mat.mat');

MUAini=MUA; Fini=F;
[VAF,IceVolume,GroundedArea,hAF,hfPos]=CalcVAF([],MUA,F.h,F.B,F.S,F.rho,F.rhow,F.GF);
hAFini=hAF;

load('/albedo/work/projects/oce_rio/orichter/uacpl/results/io0036/2018.00-Nodes129561-Ele254536-Tri3-kH1000-Antarctic-Forward-MeshFile.mat.mat');

[VAF,IceVolume,GroundedArea,hAF,hfPos]=CalcVAF([],MUA,F.h,F.B,F.S,F.rho,F.rhow,F.GF);

[RunInfo,hAFIni] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAini,MUA,NaN,hAFini);
[RunInfo,bIni] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAini,MUA,NaN,Fini.b);

%%
fig=FindOrCreateFigure('ab ini io0036') ;
fig.Position = [10 10 500 400];
%CtrlVar.PlotXYscale=1000;
GLgeo=[]; xGL=[] ; yGL=[];
[~,cbar] = PlotMeshScalarVariable(CtrlVar,MUAini,-Fini.ab);
ylabel(cbar,'Melt rate (m/yr)'); title("Initial melt rate");
set(gcf,'color','w');
cmocean('thermal')

caxis([0,100]);
set(cbar,'YTick',0:20:100);
hold on
GLgeo=[]; xGL=[] ; yGL=[];
PlotGroundingLines(CtrlVar,MUAini,Fini.GF,GLgeo,xGL,yGL,'color',[0.5,0.5,0.5],'Linewidth',2);
%GLgeo=[]; xGL=[] ; yGL=[];
%PlotGroundingLines(CtrlVar,MUAspin,Fspin.GF,GLgeo,xGL,yGL,'k');
hold off
%xlim([-1800 -1450])
%ylim([-700 -250])
xlim([-1700 -1550])
ylim([-400 -220])
axis('off')
fontsize(gcf,16,'points')

exportgraphics(gcf,['figures/abIniIo0036.png'],'Resolution',200);

%%
fig=FindOrCreateFigure('ab fin io0036') ;
fig.Position = [10 10 500 400];
%CtrlVar.PlotXYscale=1000;
GLgeo=[]; xGL=[] ; yGL=[];
[~,cbar] = PlotMeshScalarVariable(CtrlVar,MUA,-F.ab);
ylabel(cbar,'Melt rate (m/yr)'); title("Final melt rate");
set(gcf,'color','w');
cmocean('thermal')

caxis([0,100]);
set(cbar,'YTick',0:20:100);
hold on
GLgeo=[]; xGL=[] ; yGL=[];
PlotGroundingLines(CtrlVar,MUA,F.GF,GLgeo,xGL,yGL,'color',[0.5,0.5,0.5],'Linewidth',2);
%GLgeo=[]; xGL=[] ; yGL=[];
%PlotGroundingLines(CtrlVar,MUAspin,Fspin.GF,GLgeo,xGL,yGL,'k');
hold off
%xlim([-1800 -1450])
%ylim([-700 -250])
xlim([-1700 -1550])
ylim([-400 -220])
axis('off')
fontsize(gcf,16,'points')
%{
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];
%}
exportgraphics(gcf,['figures/abFinIo0036.png'],'Resolution',200);


%%
fig=FindOrCreateFigure('b diff io0036') ;
fig.Position = [10 10 500 400];
GLgeo=[]; xGL=[] ; yGL=[];
[~,cbar] = PlotMeshScalarVariable(CtrlVar,MUA,F.b-bIni);
ylabel(cbar,"Height difference (m)"); title("Ice shelf draft evolution (fin-ini)");
set(gcf,'color','w');
cmocean('balance')

caxis([-500,500]);
set(cbar,'YTick',-500:100:500);
hold on
GLgeo=[]; xGL=[] ; yGL=[];
PlotGroundingLines(CtrlVar,MUAini,Fini.GF,GLgeo,xGL,yGL,'magenta','Linewidth',2);%,[0.5,0.5,0.5]);
%PlotGroundingLines(CtrlVar,MUAspin,Fspin.GF,GLgeo,xGL,yGL,'k--');
PlotGroundingLines(CtrlVar,MUA,F.GF,GLgeo,xGL,yGL,'k','Linewidth',2);
hold off
%xlim([-1800 -1450])
%ylim([-700 -250])
xlim([-1700 -1550])
ylim([-400 -220])
axis('off');
fontsize(gcf,16,'points')
exportgraphics(gcf,['figures/bDiffIo0036.png'],'Resolution',200);

%%

f=FindOrCreateFigure("hAfdiff io0036");
fig.Position = [10 10 500 400];
[~,cbar]=PlotMeshScalarVariable(CtrlVar,MUA,(hAF-hAFIni)./39) ;
ylabel(cbar,"HAF trend (m/yr)") ; title("Height Above Flotation trend",interpreter="latex")
%colorbar('off')
%set(cbar,'YTick',-2:0.5:2)
%axis tight
axis off
%hold on ; PlotLatLonGrid(CtrlVar.PlotXYscale) ;
hold on ; PlotGroundingLines(CtrlVar,MUA,F.GF,[],[],[],'k','Linewidth',1);hold off;
%xlabel("xps (km)",interpreter="latex") ; ylabel("yps (km)",interpreter="latex") ; 
%ylabel(cbar,"HAF trend (m/yr)") ; title("Height Above Flotation trend",interpreter="latex")
%fprintf("VAF=%f (Gt/yr)\n",VAF.Total/1e9)   ; 
%fprintf("GroundedArea=%-7.2f (times the area of iceland)\n",GroundedArea.Total/1e6/103e3) ; 
%colormap(othercolor('Blues7',1024));
%colormap(bluewhitered);
cmocean('-balance')
caxis([-2,2])
xlim([-1950 -1100])
ylim([-700 200])
set(gcf,'color','w');
fontsize(gcf,14,'points')
%f.Position = [0 0 500 700];
exportgraphics(gcf,'figures/dhAFdtIo0036.png','Resolution',200);
%exportgraphics(ax,'myplot.png','Resolution',300) 
%%

load('/albedo/work/projects/oce_rio/orichter/uacpl/results/ii0047/20000-FW-Antarctic-Forward-MeshFileAdapt3-local.mat.mat');

MUAini=MUA; Fini=F;
[VAF,IceVolume,GroundedArea,hAF,hfPos]=CalcVAF(CtrlVar,MUA,F.h,F.B,F.S,F.rho,F.rhow,F.GF);
hAFini=hAF;

load('/albedo/work/projects/oce_rio/orichter/uacpl/results/ii0047/20380-FW-Antarctic-Forward-MeshFileAdapt3-local.mat.mat');

[VAF,IceVolume,GroundedArea,hAF,hfPos]=CalcVAF(CtrlVar,MUA,F.h,F.B,F.S,F.rho,F.rhow,F.GF);

[RunInfo,bIni] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAini,MUA,NaN,Fini.b);
[RunInfo,hAFIni] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAini,MUA,NaN,hAFini);

%%
fig=FindOrCreateFigure('ab ini ii0047') ;
fig.Position = [10 10 500 400];
%CtrlVar.PlotXYscale=1000;
GLgeo=[]; xGL=[] ; yGL=[];
[~,cbar] = PlotMeshScalarVariable(CtrlVar,MUAini,-Fini.ab);
ylabel(cbar,'Melt rate (m/yr)'); title(sprintf("Initial melt rate"),interpreter="latex");
set(gcf,'color','w');
cmocean('thermal')

caxis([0,100]);
set(cbar,'YTick',0:20:100);
hold on
GLgeo=[]; xGL=[] ; yGL=[];
PlotGroundingLines(CtrlVar,MUAini,Fini.GF,GLgeo,xGL,yGL,'color',[0.5,0.5,0.5],'Linewidth',2);
%GLgeo=[]; xGL=[] ; yGL=[];
%PlotGroundingLines(CtrlVar,MUAspin,Fspin.GF,GLgeo,xGL,yGL,'k');
hold off
%xlim([-1800 -1450])
%ylim([-700 -250])
xlim([-1700 -1550])
ylim([-400 -220])
axis('off')
fontsize(gcf,14,'points')
%{
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];
%}
exportgraphics(gcf,['figures/abIniIi0047.png'],'Resolution',200);

%%
fig=FindOrCreateFigure('ab fin ii0047') ;
fig.Position = [10 10 500 400];
%CtrlVar.PlotXYscale=1000;
GLgeo=[]; xGL=[] ; yGL=[];
[~,cbar] = PlotMeshScalarVariable(CtrlVar,MUA,-F.ab);
ylabel(cbar,'Melt rate (m/yr)'); title(sprintf("Final melt rate"),interpreter="latex");
set(gcf,'color','w');
cmocean('thermal')

caxis([0,100]);
set(cbar,'YTick',0:20:100);
hold on
GLgeo=[]; xGL=[] ; yGL=[];
PlotGroundingLines(CtrlVar,MUA,F.GF,GLgeo,xGL,yGL,'color',[0.5,0.5,0.5],'Linewidth',2);
%GLgeo=[]; xGL=[] ; yGL=[];
%PlotGroundingLines(CtrlVar,MUAspin,Fspin.GF,GLgeo,xGL,yGL,'k');
hold off
%xlim([-1800 -1450])
%ylim([-700 -250])
xlim([-1700 -1550])
ylim([-400 -220])
axis('off')
fontsize(gcf,14,'points')

exportgraphics(gcf,['figures/abFinIi0047.png'],'Resolution',200);


%%
fig=FindOrCreateFigure('b diff ii0047') ;
fig.Position = [10 10 500 400];
GLgeo=[]; xGL=[] ; yGL=[];
[~,cbar] = PlotMeshScalarVariable(CtrlVar,MUA,F.b-bIni);
ylabel(cbar,"Height difference (m)") ; title("Ice shelf draft difference (Fin-Ini)");
set(gcf,'color','w');
cmocean('balance')

caxis([-500,500]);
set(cbar,'YTick',-500:100:500);
hold on
GLgeo=[]; xGL=[] ; yGL=[];
PlotGroundingLines(CtrlVar,MUAini,Fini.GF,GLgeo,xGL,yGL,'magenta','Linewidth',2);%,[0.5,0.5,0.5]);
%PlotGroundingLines(CtrlVar,MUAspin,Fspin.GF,GLgeo,xGL,yGL,'k--');
PlotGroundingLines(CtrlVar,MUA,F.GF,GLgeo,xGL,yGL,'k','Linewidth',2);
hold off
%xlim([-1800 -1450])
%ylim([-700 -250])
xlim([-1700 -1550])
ylim([-400 -220])
axis('off');
fontsize(gcf,14,'points')
exportgraphics(gcf,['figures/bDiffIi0047.png'],'Resolution',200);

%%
f=FindOrCreateFigure("ii0047, hAfdiff");
fig.Position = [10 10 500 400];
[~,cbar]=PlotMeshScalarVariable(CtrlVar,MUA,(hAF-hAFIni)./38) ;
ylabel(cbar,"HAF trend (m/yr)") ; title("Height Above Flotation trend")
%colorbar('off')
%set(cbar,'YTick',-2:0.5:2)
%axis tight
axis off
%hold on ; PlotLatLonGrid(CtrlVar.PlotXYscale) ;
hold on ; PlotGroundingLines(CtrlVar,MUA,F.GF,[],[],[],'k','Linewidth',1);hold off;
%xlabel("xps (km)",interpreter="latex") ; ylabel("yps (km)",interpreter="latex") ; 
%ylabel(cbar,"HAF trend (m/yr)") ;% title("coupling, Cd=0.0125",interpreter="latex")
%fprintf("VAF=%f (Gt/yr)\n",VAF.Total/1e9)   ; 
%fprintf("GroundedArea=%-7.2f (times the area of iceland)\n",GroundedArea.Total/1e6/103e3) ; 
%colormap(othercolor('Blues7',1024));
%colormap(bluewhitered);
cmocean('-balance')
caxis([-2,2])
xlim([-1950 -1100])
ylim([-700 200])
set(gcf,'color','w');
fontsize(gcf,14,'points')
%f.Position = [0 0 500 700];
exportgraphics(gcf,'figures/dhAFdtIi0047.png','Resolution',200);
%exportgraphics(ax,'myplot.png','Resolution',300) 
