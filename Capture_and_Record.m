%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CAPTURE DATA FROM TI AWR144 FMCW RADAR
% 
% CREATED BY:
% MUHAMMET EMIN YANIK
% 
% ADVISOR:
% PROFESSOR MURAT TORLAK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ErrStatus = Capture_and_Record(HSDCPRO_TimeoutInMs,NumberOfSamplesPerChannel,DataFilePathWithName,Frame_Repetition_Period_ms,Num_Frames)
% This function will reinitialize HSDCPRO, capture & save fresh data 
%   This function returns 0 if no error

ErrStatus = Config_HSDCPRO(HSDCPRO_TimeoutInMs);
if (ErrStatus ~= 0)
    disp('HSDCPRO Error inside Config_HSDCPRO');
    return;
end
ErrStatus = Capture_and_Record_simple(HSDCPRO_TimeoutInMs,NumberOfSamplesPerChannel,DataFilePathWithName,Frame_Repetition_Period_ms,Num_Frames);
if (ErrStatus ~= 0)
    disp('HSDCPRO Error inside Capture_and_Record_simple');
    return;
end
end

