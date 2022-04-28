function [BHP,BHF,j,t,outmsg,HistBW] = HS_Orig(FObj,N,HMB,HMS,HMCR,PAR,BW)
% global BWIni It ContSat BWMax BWMin SatBW CBW Aj
global M Tol SatHS
MaxJ = 1e10;
MaxSat = 1e3;
M = MaxJ;
Tol = 1e-3;
SatHS = MaxSat;
% BWMin = 1e-5;
% BWMax = 2;
% BWIni = 1;
% SatBW = 15;
% CBW = 1;
% It = 0;
% BW = BWIni;
VBand = 0;
BWMode = 0;
% Define maximun the iterations number for process
% M = 50000;
% Tol = 1e-9;
% Boundaries (HMB)
% HMU = HMB(:,2);
% HML = HMB(:,1);

% Define the harmony memory size
% HMS = 20;

% eval(['FObj = @(x)',FObj1]);

% Generate initial harmonics and evaluate the objective function (real number arrays)
HM = zeros(HMS,N);
FHM = zeros(HMS,1);
for i = 1 : HMS,
    HM(i,:) = Seeder(HMB);
    FHM(i) = FObj(HM(i,:));
end

% Find the better and worst harmony location
[BFHM,BHM] = min(FHM);
[WFHM,WHM] = max(FHM);
BFHM_ = BFHM;

% Define pitch adjusting rate and pitch limits
% PAR = 0.5;

% Define pitch band width
% BW = 0.001;

% Define harmony memory accepting rate or considering rate
% HMCR = 0.9;

% New candidate solution
X = nan(1,N);

ContHist=1;

flag = 0; err = inf;
tic;
%%
for j = 1 : M,
    %     pause(.5)
    %     clc, HM
    for d = 1 : N,
        % Generate new harmonics by accepting best harmonics
        if rand < HMCR,
            % Choose an existing harmonic randomly
            Xp = randi(HMS);
            X(d) = HM(Xp,d);
            if rand < PAR,
                % Adjust the pitch randomly within a bandwidth
%                 LastBW = BW;
%                 [BW,BWMode] = GetBWVarRand(VBand,LastBW,BWMode,j);
                HistBW(ContHist) = BW;
                ContHist = ContHist + 1;
                X(d) = X(d) + BW*(2*rand - 1);
            end
        else
            % Generate new harmonics via randomization
            X_ = Seeder(HMB);
            X(d) = X_(d);
        end
    end
    
    % Reposition
%     if ConstCheck(X) == 0, X(:) = Seeder(HMB); end
% Verifica y corrige que se encuentre dentro del dominio
        X = Chk_Feas(X,HMB,2);
    
    % Accept the new harmonics (solutions) if better
    FX = FObj(X);
    if FX < WFHM,
        HM(WHM,:) = X;
        FHM(WHM) = FX;
        VBand = 1;
    else
        VBand = 0;
    end
    [BFHM,BHM] = min(FHM);
    [WFHM,WHM] = max(FHM);
    
        if (BFHM == BFHM_),
            flag = 1 + flag;
        else
            if BFHM < BFHM_,
                flag = 0;
%                 err = abs(BFHM_ - BFHM);
                err = abs(BFHM);
                BFHM_ = BFHM;
            else
                flag = 1 + flag;
            end
        end
    % Stop criterion is below
        if err < Tol || flag >= SatHS,
            t = toc;
            if err < Tol,
                outmsg = 'Err';
            end
            if flag >= 500,
                outmsg = 'Sat';
            end
            BHP = HM(BHM,:);
            BHF = BFHM;
            return;
%             break;
        end
    
end
% Find the current best estimates
t = toc;
outmsg = 'Ite';
BHP = HM(BHM,:);
BHF = BFHM;
% figure(1), plot(HistBW,'k-')