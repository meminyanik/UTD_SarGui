%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRIGGER HSDC FOR CAPTURING PROESS FOR TI AWR144 FMCW RADAR
% 
% CREATED BY:
% MUHAMMET EMIN YANIK
% 
% ADVISOR:
% PROFESSOR MURAT TORLAK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ErrStatus = Trigger_HSDCPRO(NumberOfSamplesPerChannel,HSDCPRO_TimeoutInMs)
%HSDCPro_Clear_Memory clears old data in the memory of capture board and
%triggers capture
%   This function should be called before capturing fresh data
%   This function returns 0 if no error

% Disable Trigger
TriggerModeEnable = 0;
% int32_t __cdecl Trigger_Option ( int32_t TriggerModeEnable , int32_t SoftwareTriggerEnable , int32_t ArmOnNextCaptureButtonPress , uint8_t TriggerCLKDelays , int32_t TimeoutInMs );
ErrStatus = calllib('HSDCProAutomation_64Bit','Trigger_Option',TriggerModeEnable, 0, 0, 0, HSDCPRO_TimeoutInMs);
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while disabling trigger line12');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end
ErrStatus = calllib('HSDCProAutomation_64Bit','HSDC_Ready',HSDCPRO_TimeoutInMs); % Waiting to check if HSDCPro has completed all its operations.
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while checking ready status line18');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end
% Reset Board will clear old data
% int32_t __cdecl Reset_Board ( int32_t TimeoutInMs );
ErrStatus = calllib('HSDCProAutomation_64Bit','Reset_Board',HSDCPRO_TimeoutInMs);
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while resetting board line26');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end
ErrStatus = calllib('HSDCProAutomation_64Bit','HSDC_Ready',HSDCPRO_TimeoutInMs); % Waiting to check if HSDCPro has completed all its operations.
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while checking ready status line32');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end
% Set number of capture samples
% int32_t __cdecl Set_Number_of_Samples ( uint64_t NumberOfSamplesPerChannel , int32_t TimeoutInMs );
ErrStatus = calllib('HSDCProAutomation_64Bit','Set_Number_of_Samples',NumberOfSamplesPerChannel,HSDCPRO_TimeoutInMs);
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while setting number of capture samples line40');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end
ErrStatus = calllib('HSDCProAutomation_64Bit','HSDC_Ready',HSDCPRO_TimeoutInMs); % Waiting to check if HSDCPro has completed all its operations.
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while checking ready status line46');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end
% Enable Trigger again
TriggerModeEnable = 1;
% int32_t __cdecl Trigger_Option ( int32_t TriggerModeEnable , int32_t SoftwareTriggerEnable , int32_t ArmOnNextCaptureButtonPress , uint8_t TriggerCLKDelays , int32_t TimeoutInMs );
ErrStatus = calllib('HSDCProAutomation_64Bit','Trigger_Option',TriggerModeEnable, 0, 0, 0, HSDCPRO_TimeoutInMs);
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while enabling trigger line55');
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

