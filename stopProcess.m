%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STOP PROCESS OF INRAS FMCW RADAR
% 
% CREATED BY:
% MUHAMMET EMIN YANIK
% 
% ADVISOR:
% PROFESSOR MURAT TORLAK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fileName = 'SARData.mat';
save(fileName,'dataFull');

Brd.BrdRst();
Brd.BrdPwrDi();