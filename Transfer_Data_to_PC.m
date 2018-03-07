%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRANSFER CAPTURED DATA FROM HSDC TO PC FOR TI AWR144 FMCW RADAR
% 
% CREATED BY:
% MUHAMMET EMIN YANIK
% 
% ADVISOR:
% PROFESSOR MURAT TORLAK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ErrStatus = Transfer_Data_to_PC(DataFilePathWithName,HSDCPRO_TimeoutInMs)
%ReadDDR_and_SaveRawData transfers the captured data to PC
%   This function should be called after the frames are transmitted
%   This function returns 0 if no error

Trigger_TimeStamp = datetime('now');

% int32_t __cdecl Read_DDR_Memory ( int32_t WaitToCheckTrigger , int32_t TimeoutInMs );
ErrStatus = calllib('HSDCProAutomation_64Bit','Read_DDR_Memory',0,HSDCPRO_TimeoutInMs);
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while reading DDR memory line11');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end

%Check if capture is complete
iter = 1;
ErrStatus = -1;
while (ErrStatus ~=0) && (iter <=40)
    % int32_t __cdecl HSDC_Ready ( int32_t TimeoutInMs );
    ErrStatus = calllib('HSDCProAutomation_64Bit','HSDC_Ready',30000); % Waiting to check if HSDCPro has completed all its operations.
    iter = iter+1;
end
if (ErrStatus ~= 0)
    disp('HSDCPRO Error while checking ready status line25');
    fprintf('\nError Status = %d (%s)',ErrStatus,HSDCPro_Automation_Error_to_String(ErrStatus));
    return;
end

HSDCProDataPath = dir('C:\Program Files (x86)\Texas Instruments\High Speed Data Converter Pro\HSDCPro Data\ADC Temp0.bin') ;
CaptureTimeStamp = [HSDCProDataPath.date];
if ((CaptureTimeStamp - Trigger_TimeStamp) <= (-1/(3600*24)))
    ErrStatus = -1000;
    disp('HSDCPRO did not receive data from AR line33');
    return;
end
end