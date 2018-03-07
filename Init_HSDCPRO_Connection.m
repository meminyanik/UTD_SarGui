%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INITIALIZE HSDC PRO CONNECTION FOR CAPTURING PROCESS FROM TI AWR144 FMCW RADAR
% 
% CREATED BY:
% MUHAMMET EMIN YANIK
% 
% ADVISOR:
% PROFESSOR MURAT TORLAK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Init_HSDCPRO_Connection(HSDCPRO_DLL_Path)
%This script establishes the connection with HSDCPRO software
%   Pre-requisites:
%   Configure HSDCPRO software as per the integration document

addpath('C:\Program Files (x86)\Texas Instruments\High Speed Data Converter Pro\HSDCPro Automation DLL\Manual and Examples\Automation DLL Matlab Example\64Bit Matlab\')

% Load the Automation DLL
if libisloaded('HSDCProAutomation_64Bit')
    unloadlibrary('HSDCProAutomation_64Bit');
end
loadlibrary(HSDCPRO_DLL_Path, @HSDCProAutomationHeader);
end

