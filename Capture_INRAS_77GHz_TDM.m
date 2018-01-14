function [RowData,nCall] = Capture_INRAS_77GHz_TDM(Brd,Cfg,CalData,RowData,nCall)

%--------------------------------------------------------------------------
% Enable Receive Chips
%--------------------------------------------------------------------------
Brd.RfRxEna();

%--------------------------------------------------------------------------
% Enable Transmit Chips
%--------------------------------------------------------------------------
TxChn           =   1;
TxPwr           =   63;
Brd.RfTxEna(TxChn, TxPwr);

Brd.RfMeas('ExtTrigUp_TxSeq',Cfg);

% Capture Data
DataTx1 = Brd.BrdGetData();
DataTx2 = Brd.BrdGetData();
DataTx3 = Brd.BrdGetData();
DataTx4 = Brd.BrdGetData();

DataTx = [DataTx1.'; DataTx2.'; DataTx3.'; DataTx4.'];

CalibratedData = CalData .* hilbert(DataTx.').';

RowData(:,:,nCall) = CalibratedData;

nCall = nCall + 1;

%% Post Processing
% Range FFT
% kf = (Cfg.fStop - Cfg.fStrt)/Cfg.TRampUp; % 7.8125e+12
% fs = Brd.Get('fs'); % 2000000
% % Cfg.N = 256;
% 
% c = physconst('LightSpeed');
% 
% numFFTbins = 1024;
% 
% rangeIdxToMeters = c * fs / (2 * kf * Cfg.N);
% rangeAxis = linspace(0, (Cfg.N/2-1) * rangeIdxToMeters, numFFTbins/2);
% 
% Data1Ch = CalibratedData(1,:);
% % Data1Ch = hilbert(RowData(1,:))*CalData(1);
% 
% Data1ChFFT = fft(Data1Ch,numFFTbins);
% Data1ChFFT = Data1ChFFT(1:numFFTbins/2);
% 
% figure;plot(rangeAxis,mag2db(abs(Data1ChFFT)))

%%
% fCarrier = 77*1e9; % 77 GHz;
% lambda = c / fCarrier;

% % maximumRange = fs * c / (2*kf);
% % rangeAxis1 = linspace(0, maximumRange, numFFTbins/2);
% 
% cHData = CalibratedData(1,:);
% cHDataRangeFFT = fft(cHData,numFFTbins);
% plot(rangeAxis,pow2db(abs(cHDataRangeFFT(1:numFFTbins/2))))
% 
% % Angle FFT
% AntIdx              =   [1:7, 9:15, 17:23, 25:32];
% VirtualArrayData = CalibratedData(AntIdx,:);
% VirtualArrayDataRangeFFT = fft(VirtualArrayData.',numFFTbins);
% % mesh(rangeAxis,1:29,pow2db(abs(VirtualArrayDataFFT(1:numFFTbins/2,:).')))
% mesh(pow2db(abs(VirtualArrayDataRangeFFT(1:numFFTbins/2,:).')))
% 
% peakData = VirtualArrayDataRangeFFT(9,:);
% VirtualArrayDataAngleFFT = fft(peakData,128);
% plot(abs(VirtualArrayDataAngleFFT(1:64)))