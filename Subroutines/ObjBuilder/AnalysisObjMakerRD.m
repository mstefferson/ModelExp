% Builds the time structure
function [AnalysisObj] = AnalysisObjMakerRD(TrackAccumFromFlux,...
    TrackAccumFromFluxPlot, PlotMeMovAccum, PlotMeLastConcAccum,...
    PlotMeLastConc,QuickMovie,CheckConservDen,PlotMeRightRes,ShowRunTime)

%Build analysis Obj
AnalysisObj = struct('TrackAccumFromFlux', TrackAccumFromFlux,...
'TrackAccumFromFluxPlot', TrackAccumFromFluxPlot,...
'PlotMeMovAccum', PlotMeMovAccum, 'PlotMeLastConcAccum', PlotMeLastConcAccum,...
'PlotMeLastConc', PlotMeLastConc, 'QuickMovie', QuickMovie, ...
'CheckConservDen', CheckConservDen,...
'PlotMeRightRes', PlotMeRightRes,'ShowRunTime', ShowRunTime);

end