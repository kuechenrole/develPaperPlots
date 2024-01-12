
%load('/albedo/work/projects/oce_rio/orichter/uacpl/results/ii0040/19790-FW-Antarctic-Forward-MeshFileAdapt3-local.mat.mat');
load('/albedo/work/projects/oce_rio/orichter/ollieWork/Misomip2/ii0020/uaData/19790-FW-Antarctic-Forward-MeshFileAdapt3.mat.mat');
%load('/albedo/work/projects/oce_rio/orichter/ollieWork/Misomip2/ii0020/uaData/19990-FW-Antarctic-Forward-MeshFileAdapt3.mat.mat');

MUAini=MUA; Fini=F;
%[VAF,IceVolume,GroundedArea,hAF,hfPos]=CalcVAF([],MUA,F.h,F.B,F.S,F.rho,F.rhow,F.GF);
%hAFini=hAF;

%load('/albedo/work/projects/oce_rio/orichter/uacpl/results/io0036/1979.00-Nodes129738-Ele254869-Tri3-kH1000-Antarctic-Forward-MeshFile.mat.mat');
load('/albedo/work/projects/oce_rio/orichter/ollieWork/Misomip2/ii0020/uaData/19990-FW-Antarctic-Forward-MeshFileAdapt3.mat.mat');

MUAspin=MUA; Fspin=F;
%[VAF,IceVolume,GroundedArea,hAF,hfPos]=CalcVAF([],MUA,F.h,F.B,F.S,F.rho,F.rhow,F.GF);
%hAFspin=hAF;

%load('/albedo/work/projects/oce_rio/orichter/uacpl/results/io0036/2018.00-Nodes129561-Ele254536-Tri3-kH1000-Antarctic-Forward-MeshFile.mat.mat');
load('/albedo/work/projects/oce_rio/orichter/uacpl/results/io0035/2018.00-Nodes129943-Ele255292-Tri3-kH1000-Antarctic-Forward-MeshFile.mat.mat');

%[VAF,IceVolume,GroundedArea,hAF,hfPos]=CalcVAF([],MUA,F.h,F.B,F.S,F.rho,F.rhow,F.GF);

%[RunInfo,bIni] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAini,MUA,NaN,Fini.b);
%[RunInfo,bSpin] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAspin,MUA,NaN,Fspin.b);

%[RunInfo,hAFIni] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAini,MUA,NaN,hAFini);
%[RunInfo,hAFSpin] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAspin,MUA,NaN,hAFspin);

%[RunInfo,hIni] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAini,MUA,NaN,Fini.s-Fini.b);
[RunInfo,hSpin] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAspin,MUA,NaN,Fspin.s-Fspin.b);

f=FindOrCreateFigure('Pig change');
%t = tiledlayout(2,2,'TileSpacing','Compact','Padding','Compact');

ax2=subplot(2,2,2);
%CtrlVar.PlotXYscale=1000;
GLgeo=[]; xGL=[] ; yGL=[];
[~,cbar] = PlotMeshScalarVariable(CtrlVar,MUAini,-Fini.ab);
ylabel(cbar,'Melt rate (m/yr)'); title(sprintf("Cd=0.025"),interpreter="latex");
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
xlim([-1695 -1535])
ylim([-375 -200])
axis('off');
ax2.XAxis.Label.Visible = 'on';
xlabel('(b)')

ax4=subplot(2,2,4);
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
ax4.XAxis.Label.Visible = 'on';
xlabel(['(d)' newline]);


load('/albedo/work/projects/oce_rio/orichter/uacpl/results/ii0040/19790-FW-Antarctic-Forward-MeshFileAdapt3-local.mat.mat');
%load('/albedo/work/projects/oce_rio/orichter/ollieWork/Misomip2/ii0020/uaData/19790-FW-Antarctic-Forward-MeshFileAdapt3.mat.mat');
%load('/albedo/work/projects/oce_rio/orichter/ollieWork/Misomip2/ii0020/uaData/19990-FW-Antarctic-Forward-MeshFileAdapt3.mat.mat');

MUAini=MUA; Fini=F;

load('/albedo/work/projects/oce_rio/orichter/uacpl/results/io0036/1979.00-Nodes129738-Ele254869-Tri3-kH1000-Antarctic-Forward-MeshFile.mat.mat');
%load('/albedo/work/projects/oce_rio/orichter/ollieWork/Misomip2/ii0020/uaData/19990-FW-Antarctic-Forward-MeshFileAdapt3.mat.mat');



MUAspin=MUA; Fspin=F;

load('/albedo/work/projects/oce_rio/orichter/uacpl/results/io0036/2018.00-Nodes129561-Ele254536-Tri3-kH1000-Antarctic-Forward-MeshFile.mat.mat');
%load('/albedo/work/projects/oce_rio/orichter/uacpl/results/io0035/2018.00-Nodes129943-Ele255292-Tri3-kH1000-Antarctic-Forward-MeshFile.mat.mat');

[RunInfo,bIni] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAini,MUA,NaN,Fini.b);
[RunInfo,hSpin] = MapNodalVariablesFromMesh1ToMesh2UsingScatteredInterpolant(CtrlVar,RunInfo,MUAspin,MUA,NaN,Fspin.s-Fspin.b);

ax1=subplot(2,2,1);
%CtrlVar.PlotXYscale=1000;
GLgeo=[]; xGL=[] ; yGL=[];
PlotMeshScalarVariable(CtrlVar,MUAini,-Fini.ab);
colorbar('off');
%ylabel(cbar,'Melt rate (m/yr)');
title(sprintf("Cd=0.0125"),interpreter="latex");
set(gcf,'color','w');
cmocean('thermal')

caxis([0,100]);
%set(cbar,'YTick',0:20:100);
hold on
GLgeo=[]; xGL=[] ; yGL=[];
PlotGroundingLines(CtrlVar,MUAini,Fini.GF,GLgeo,xGL,yGL,'color',[0.5,0.5,0.5],'Linewidth',2);
%GLgeo=[]; xGL=[] ; yGL=[];
%PlotGroundingLines(CtrlVar,MUAspin,Fspin.GF,GLgeo,xGL,yGL,'k');
hold off
xlim([-1695 -1535])
ylim([-375 -200])
axis('off')
ax1.XAxis.Label.Visible = 'on';
xlabel('(a)');
%fontsize(gcf,14,'points')
%exportgraphics(gcf,['figures/abIniio0036.png'],'Resolution',200);



ax3=subplot(2,2,3);
%CtrlVar.PlotXYscale=1000;
GLgeo=[]; xGL=[] ; yGL=[];
[~,cbar] = PlotMeshScalarVariable(CtrlVar,MUA,((F.s-F.b)-hSpin)./39);
colorbar('off');
%ylabel(cbar,"Draft difference (m)") ; %title(sprintf("coupling, Cd=0.0125",CtrlVar.time),interpreter="latex");
set(gcf,'color','w');
cmocean('balance')

caxis([-12,12]);
%set(cbar,'YTick',-500:100:500);
hold on
GLgeo=[]; xGL=[] ; yGL=[];
PlotGroundingLines(CtrlVar,MUAspin,Fspin.GF,GLgeo,xGL,yGL,'magenta','Linewidth',2);%color',[0.5,0.5,0.5]);
PlotGroundingLines(CtrlVar,MUA,F.GF,GLgeo,xGL,yGL,'k','Linewidth',2);
hold off
xlim([-1695 -1535])
ylim([-375 -200])
axis('off');
ax3.XAxis.Label.Visible = 'on';
xlabel('(c)');
f.Position=([0 0 872 500]);
pos=get(ax1,'position'); set(ax1,'position',[pos(1)+0.2 pos(2) pos(3) pos(4)])
pos=get(ax3,'position'); set(ax3,'position',[pos(1)+0.2 pos(2) pos(3) pos(4)])
exportgraphics(f,['figures/pigResponse.png'],'Resolution',300);