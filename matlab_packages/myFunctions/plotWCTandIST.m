
load Restart-Forward-Transient.mat;
CtrlVar=CtrlVarInRestartFile;

GLgeo=GLgeometry(MUA.connectivity,MUA.coordinates,GF,CtrlVar);
TRI=[]; DT=[]; xGL=[] ; yGL=[] ;
x=MUA.coordinates(:,1);  y=MUA.coordinates(:,2);


figure ;
PlotMeshScalarVariable(CtrlVarInRestartFile,MUA,F.b-F.B);
hold on ;
[xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVarInRestartFile,MUA,GF,GLgeo,xGL,yGL,'g');
PlotMuaBoundary(CtrlVarInRestartFile,MUA,'b')
title('water column thickness in m')
caxis([0, 1250])
colorbar;

figure;
PlotMeshScalarVariable(CtrlVarInRestartFile,MUA,F.h);
hold on ;
[xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVarInRestartFile,MUA,GF,GLgeo,xGL,yGL,'g');
PlotMuaBoundary(CtrlVarInRestartFile,MUA,'b')
title('ice thickness in m')
colorbar;

figure;
PlotMeshScalarVariable(CtrlVarInRestartFile,MUA,F.h.*(F.GF.node<1));
hold on ;
[xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVarInRestartFile,MUA,GF,GLgeo,xGL,yGL,'g');
PlotMuaBoundary(CtrlVarInRestartFile,MUA,'b')
title('ice shelf thickness in m')
colorbar;