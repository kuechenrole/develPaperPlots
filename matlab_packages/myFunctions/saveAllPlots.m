%FolderName = '~/ollie1/work/ollie/orichter/Misomip2/io0013/reports/uadiag/';   % Your destination folder
FolderName = './io0013_plots/';   % Your destination folder
if ~exist(FolderName, 'dir')
   mkdir(FolderName)
end

FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  FigName   = num2str(get(FigHandle, 'Number'));
  set(0, 'CurrentFigure', FigHandle);
  savefig(fullfile(FolderName, [FigName '.fig']));
end