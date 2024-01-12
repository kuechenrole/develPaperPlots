%function writeGLNetCDF(fileName,resultsFolder,meshPath,slice_user)

%if exist(fileName, 'file')==2
%  delete(fileName);
%end
resultsFolder='./ollieWork/Misomip2/io0019/uaData/';
outFolder='./io0019_plots/'

% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(resultsFolder, '*.mat'); % Change to whatever pattern you need.
theFiles = dir(filePattern);

%if nargin > 3
 % slice = slice_user;
%else
 % slice = 1:length(theFiles);
%end

%theFiles = theFiles(slice);

%load(meshPath);

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    
    load(fullFileName);
    GLgeo=[]; xGL=[] ; yGL=[];

    time = CtrlVar.time;

    fig= FindOrCreateFigure('PIGBay');
    PlotMeshScalarVariable(CtrlVar,MUA,F.ab);   title(sprintf('ab in m/yr at t=%g',time))
    hold on
    

    [xGL,yGL,GLgeo]=PlotGroundingLines(CtrlVar,MUA,F.GF,GLgeo,xGL,yGL,'k');
    hold off
    %xlim([-700,100]);ylim([-1000,-400]); caxis([-2,1]);%Sibble Coast Ross GL
    xlim([-1800,-1450]);ylim([-500,-200]); %PIGBay
    caxis([-30,1]);
    %xlim([-1600,-400]);ylim([100,1100]); %FRIS

    FigName   = [num2str(k,'%03d') 'pigBay'] ;
    %set(0, 'CurrentFigure', FigHandle);
    saveas(fig,fullfile(outFolder, [FigName '.jpg']));

    %outFile=fullfile(outFolder,[string(time),'.fig']);
    %fprintf(1, 'Now save %s\n', outFile);
    %savefig(outFile);
    

end

%end