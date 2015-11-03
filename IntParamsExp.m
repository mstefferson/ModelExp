clear
clc

CurrentDir = pwd;
addpath( genpath( CurrentDir) );

trial    = 501;

% Turn things on
NLcoup             = 1;
RunMe              = 1;
ChemOnEndPts       = 1;
SaveMe             = 1;

% "Analysis" subroutines
TrackAccumFromFlux     = 0;
TrackAccumFromFluxPlot = 0;
PlotMeMovAccum         = 0;
PlotMeLastConcAccum    = 0;
PlotMeLastConc         = 0;
QuickMovie             = 0;
CheckConservDen        = 0;
PlotMeRightRes         = 0;
ShowRunTime            = 1;

% Load experimental grid
load('ExpVars.mat')

x_tot   = pos_01;
t_tot   = time_01(end);
t_rec   = time_01(1);  % time interval for recording dynamics

ExpDiff = fliplr( kymoRed_01 );
ExpRD   = fliplr( kymoGreen_01 );
xGelInd = 410;
xGel    = x(410:end);

Lgel    = xGel(end);
Nxgel      = size(xGel);


%Non Dimensional and Concentration
KDinv = 0;           % Binding affinity
Koff  = 0;           % scaled koff
Kon   = KDinv * Koff;  % scaled kon
% Kon   = 1e4;        % scaled kon
% Koff  = 1e1;        % scaled koff
nu    = 0;        % Dc/Da
Dnl   = 1;      % Dsat/DA. Only used for nonlinear diffusion beta  > 1?
Bt    = 0;     % molar (old: 1e-2) (new: 1e-3)
AL    = 1;     % molar 2e-5
AR    = 0;

% time
dt          = (Lgel/(Nxgel-1))^2;   % time step
ss_epsilon  = 1e-12;   % steady state condition
NumPlots    = 10;      % For the accumulation plot subroutine

% Boudary conditions: 'Dir', 'VN', 'Res','PBC'
A_BC = 'VN';
C_BC = 'VN';

fprintf('trial:%d A_BC: %s C_BC: %s\n', trial,A_BC, C_BC)
% Calculate other parameters
KDinv = Kon/Koff; %Binding affinity

% keyboard
% Build Objects
[ParamObj] = ParamObjMakerRD(SaveMe,ChemOnEndPts,Nxgel,Lbox,Lr,A_BC,C_BC,Kon,Koff,nu,Dnl,...
    NLcoup,Bt,AL,AR,trial);
[TimeObj] = TimeObjMakerRD(dt,t_tot,t_rec,ss_epsilon,NumPlots);
[AnalysisObj] = AnalysisObjMakerRD(TrackAccumFromFlux,...
    TrackAccumFromFluxPlot, PlotMeMovAccum, PlotMeLastConcAccum,...
    PlotMeLastConc,QuickMovie,CheckConservDen,PlotMeRightRes,ShowRunTime);

FileDir = sprintf('RdNx%dA%sC%st%d',Nxgel,A_BC,C_BC,trial);
Where2SavePath    = sprintf('%s/%s/%s',pwd,'Outputs',FileDir);
% disp( max(dt * (Nx/Lbox)^2,nu * dt * (Nx/Lbox)^2) ) 

if SaveMe
    diary('RunDiary.txt')
    disp(ParamObj)
end
% keyboard
if RunMe == 1
    tic
%     keyboard
 %     ChemDiffMainAResVn
%     ChemDiffMainDir
%     ChemDiffMainVn

fprintf('Starting run \n')
if strcmp(A_BC,'Dir') && strcmp(C_BC,'VN')
[A,C,DidIBreak,SteadyState] = ChemDiffMainDirVn(ParamObj,TimeObj,AnalysisObj);
elseif strcmp(A_BC,'Dir') && strcmp(C_BC,'Dir')
[A,C,DidIBreak,SteadyState] = ChemDiffMainDir(ParamObj,TimeObj,AnalysisObj);
elseif strcmp(A_BC,'VN') && strcmp(C_BC,'VN')
[A,C,DidIBreak,SteadyState] = ChemDiffMainVn(ParamObj,TimeObj,AnalysisObj);
elseif strcmp(A_BC,'Res') && strcmp(C_BC,'VN')
[A,C,DidIBreak,SteadyState] = ChemDiffMainResVn(ParamObj,TimeObj,AnalysisObj);
elseif strcmp(A_BC,'PBC') && strcmp(C_BC,'PBC')
ParamObj.Nlcoup = 1; % Currently, Nl coup turns on all chem    
[A,C,DidIBreak,SteadyState] = ChemDiffMainPBCft(ParamObj,TimeObj,AnalysisObj);
end
fprintf('Finished run\n')

% ChemDiffMainPBCft
    if SaveMe 
      diary off
      mkdir(Where2SavePath)
      movefile('*.mat', Where2SavePath)
      movefile('*.txt', Where2SavePath)
    end
    toc
    fprintf('Break = %d Steady = %d\n',DidIBreak,SteadyState)
%     cd /home/mws/Documents/MATLAB/Research/BG/DDFT/HRddft/Drive/IsoDiffCube
end



    
