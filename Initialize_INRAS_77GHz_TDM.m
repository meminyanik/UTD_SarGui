function [Brd,Cfg,CalData,RowData,nCall] = Initialize_INRAS_77GHz_TDM()

% Description:
% Configure FMCW Mode with sequential activation of Tx antennas and measure upchirp IF signal
%
% (1) Start of chirps are triggered with external trigger Demux2
% (2) Activation of antennas is configured with SPI commands
% (3) FPGA Sequencer is used to programm desired parameters
% (4) Cfg.TxSeq       =   [1, 2, 3]; -> used to set activation sequence
% (5) FrmCntr, SeqId, Data  -> SeqId is used to identify antenna

% clear;
% close all;

%--------------------------------------------------------------------------
% Include all necessary directories
%--------------------------------------------------------------------------
% CurPath = pwd();
addpath('C:\D\UTD\Research\Radar\DriverPackage\Matlab\ClassComp');
addpath('C:\D\UTD\Research\Radar\DriverPackage\Matlab\ClassComp\PNet')

%--------------------------------------------------------------------------
% Define Constants
%--------------------------------------------------------------------------
% c0 = physconst('LightSpeed'); 

Brd     =   Mimo77('PNet','192.168.1.1');

%--------------------------------------------------------------------------
% Reset Board and Enable Power Supply
%--------------------------------------------------------------------------
Brd.BrdRst();
Brd.BrdPwrEna();


%--------------------------------------------------------------------------
% Load Calibration Data
%--------------------------------------------------------------------------
CalCfg.Mask         =   1;
CalCfg.Len          =   64;
CalData             =   Brd.BrdGetCalData(CalCfg);

% %--------------------------------------------------------------------------
% % Enable Receive Chips
% %--------------------------------------------------------------------------
% Brd.RfRxEna();
% 
% %--------------------------------------------------------------------------
% % Enable Transmit Chips
% %--------------------------------------------------------------------------
% TxChn           =   1;
% TxPwr           =   63;
% Brd.RfTxEna(TxChn, TxPwr);

%--------------------------------------------------------------------------
% Configure Up-Chirp
% 0: Power Off
% 1: TX1 on
% 2: TX2 on
% 3: TX3 on
% 4: TX4 on
%--------------------------------------------------------------------------
Cfg.fStrt       =   76.0e9;
Cfg.fStop       =   77.0e9;
Cfg.TRampUp     =   256e-6; % 128e-6;
Cfg.TRampDo     =   32e-6;
Cfg.TInt        =   200e-3;
Cfg.Tp          =   400e-6;
Cfg.N           =   256;
Cfg.NrFrms      =   1;
Cfg.TxSeq       =   [1, 2, 3, 4];
% Brd.RfMeas('ExtTrigUp_TxSeq',Cfg);

%--------------------------------------------------------------------------
% Read Settings for N and fs
%--------------------------------------------------------------------------
% N               =   Brd.Get('N');
% fs              =   Brd.Get('fs');

%--------------------------------------------------------------------------
% Configure Signal Processing
%--------------------------------------------------------------------------
% TxPosn = Brd.RfGet('TxPosn');
% RxPosn = Brd.RfGet('RxPosn');


% kf                  =   (Cfg.fStop - Cfg.fStrt)/Cfg.TRampUp;

% Calibration data: Remove 8, 16, 24 measurement (overlappling ones)
% AntIdx              =   [1:7, 9:15, 17:23, 25:32];
% mCalData            =   repmat(CalData(AntIdx).',N-11,1);
numRxAnt = 8;
numTxAnt = 4;
numMeasurements = 300;

RowData = zeros(numRxAnt*numTxAnt,Cfg.N,numMeasurements);
CalData = repmat(CalData,1,Cfg.N); 
nCall = 1;