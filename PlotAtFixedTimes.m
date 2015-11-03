%%

PlotBoth = 0;
PlotDiff = 1;
x   = pos_01;
time   = time_01;

Nx = length(x);
Nt = length(time);
ExpDiff = fliplr( kymoRed_01 );
ExpRD   = fliplr( kymoGreen_01 );

xIs = 467;
xIe   = 530;

figure()
hold all
indPlot = 40;
holder = 1;
maxTimeInd = floor(length(time_01) / indPlot );
timeplot = zeros(1,maxTimeInd);
Frameplot = zeros(1,maxTimeInd);
for i = 1:maxTimeInd
    timeplot(i)  = time(holder);
    Frameplot(i) = holder;
    if PlotBoth %Both
    ax1 = subplot(1,2,1);
    hold all
    plot(1:Nx, ExpRD(holder,:),'-',...
        1:Nx, ExpDiff(holder,:),'--')
    ax2 = subplot(1,2,2);
    hold all
    plot(xIs:xIe, ExpRD(holder,xIs:xIe),'-',...
        xIs:xIe, ExpDiff(holder,xIs:xIe),'--')
    elseif PlotDiff %Diff
    ax1 = subplot(1,2,1);
    hold all
    plot(1:Nx, ExpDiff(holder,:),'-')
    ax2 = subplot(1,2,2);
    hold all
    plot(xIs:xIe, ExpDiff(holder,xIs:xIe),'-')
    else %RD
    ax1 = subplot(1,2,1);
    hold all
    plot(1:Nx, ExpRD(holder,:),'-')
    ax2 = subplot(1,2,2);
    hold all
    plot(xIs:xIe, ExpRD(holder,xIs:xIe),'-')
    end

    holder = holder + indPlot;
    
end

legendcell = cellstr(num2str(timeplot','t = %.2e'));
legend(ax1,legendcell,'location','best')

legendcell = cellstr(num2str(Frameplot','Frame = %d\n'));
legend(ax2,legendcell,'location','best')
