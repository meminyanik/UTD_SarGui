%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONFIG CAPTURING PROCESS FROM TI AWR144 FMCW RADAR
% 
% CREATED BY:
% MUHAMMET EMIN YANIK
% 
% ADVISOR:
% PROFESSOR MURAT TORLAK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ErrStatus = Config_HSDCPRO(HSDCPRO_TimeoutInMs)
% This function will reinitialize HSDCPRO and configure basic parameters 
%   This function returns 0 if no error

% Redownload firmware
FirmwareFilePath='C:\Program Files (x86)\Texas Instruments\High Speed Data Converter Pro\14J56revD Details\Firmware\AR12XX_2LANE_4CHIP_FIRMWARE.rbf';
WaitToCheck =1;
ErrStatus = calllib('HSDCProAutomation_64Bit','Download_Firmware',FirmwareFilePath,WaitToCheck,60000);
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while re-downloading Firmware line10');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end
ErrStatus = calllib('HSDCProAutomation_64Bit','HSDC_Ready',HSDCPRO_TimeoutInMs); % Waiting to check if HSDCPro has completed all its operations.
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while checking ready status line16');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end
% int32_t __cdecl Select_ADC_Device ( char ADCDevice [], int32_t TimeoutInMs );
ADCDevice_Name = 'AR12xx_4chip_LSB_LVDS_2lanes_16bit';
ErrStatus = calllib('HSDCProAutomation_64Bit','Select_ADC_Device',ADCDevice_Name,HSDCPRO_TimeoutInMs);
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while selecting adc device @line24');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end
ErrStatus = calllib('HSDCProAutomation_64Bit','HSDC_Ready',HSDCPRO_TimeoutInMs); % Waiting to check if HSDCPro has completed all its operations.
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while checking ready status line30');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end

% Set number of analysis samples to min value of 1024
% int32_t __cdecl ADC_Analysis_Window_Length ( uint32_t NumberOfSamplesForAnalysis , int32_t TimeoutInMs );
ErrStatus = calllib('HSDCProAutomation_64Bit','ADC_Analysis_Window_Length',1024,HSDCPRO_TimeoutInMs);
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while setting number of analysis samples line38');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end
ErrStatus = calllib('HSDCProAutomation_64Bit','HSDC_Ready',HSDCPRO_TimeoutInMs); % Waiting to check if HSDCPro has completed all its operations.
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while checking ready status line45');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end

% Set ADC output data rate
% int32_t __cdecl Pass_ADC_Output_Data_Rate ( double ADCOutputDataRate , int32_t TimeoutInMs );
ADCOutputDataRate = 11.25e6;
ErrStatus = calllib('HSDCProAutomation_64Bit','Pass_ADC_Output_Data_Rate',ADCOutputDataRate,HSDCPRO_TimeoutInMs);
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while setting number of ADC output data rate line55');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end
ErrStatus = calllib('HSDCProAutomation_64Bit','HSDC_Ready',HSDCPRO_TimeoutInMs); % Waiting to check if HSDCPro has completed all its operations.
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while checking ready status line61');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end

end

