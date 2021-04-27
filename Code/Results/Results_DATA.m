clear all;
close all;
clc;

load('matlab.mat');

%AVERAGE MAXIMUM VOLTAGE MAGNITUDE ERROR
%C1 = Transformer loading
%C2 = 

%% AMVME
LENGTH_AMVME(:,1) = squeeze(Vm_error_avg_inf_kron(1,:,1))';   %TRANSFORMER LOADING
LENGTH_AMVME(:,2) = squeeze(Vm_error_avg_inf_kron(1,:,2))';   %0.5l
LENGTH_AMVME(:,3) = squeeze(Vm_error_avg_inf_kron(2,:,2))';   %1l
LENGTH_AMVME(:,4) = squeeze(Vm_error_avg_inf_kron(3,:,2))';   %1.5l
LENGTH_AMVME(:,5) = squeeze(Vm_error_avg_inf_our(1,:,2))';    %0.5L
LENGTH_AMVME(:,6) = squeeze(Vm_error_avg_inf_our(2,:,2))';    %1L
LENGTH_AMVME(:,7) = squeeze(Vm_error_avg_inf_our(3,:,2))';    %1.5L
save('E:\Chaminda\7.State_Estimation_LotusGrove\V3_with_new_Krons\Error_with_length\With_Comparision\Results\LENGTH_AMVME.csv', 'LENGTH_AMVME', '-ASCII','-append');

%% AVME
LENGTH_AVME(:,1) = squeeze(Vm_error_avg_2_kron(1,:,1))';   %TRANSFORMER LOADING
LENGTH_AVME(:,2) = squeeze(Vm_error_avg_2_kron(1,:,2))';   % 0.5l
LENGTH_AVME(:,3) = squeeze(Vm_error_avg_2_kron(2,:,2))';   % 1l
LENGTH_AVME(:,4) = squeeze(Vm_error_avg_2_kron(3,:,2))';   % 1.5l
LENGTH_AVME(:,5) = squeeze(Vm_error_avg_2_our(1,:,2))';    % 0.5L
LENGTH_AVME(:,6) = squeeze(Vm_error_avg_2_our(2,:,2))';    % 1L
LENGTH_AVME(:,7) = squeeze(Vm_error_avg_2_our(3,:,2))';    % 1.5L
save('E:\Chaminda\7.State_Estimation_LotusGrove\V3_with_new_Krons\Error_with_length\With_Comparision\Results\LENGTH_AVME.csv', 'LENGTH_AVME', '-ASCII','-append');

%% AMCME
LENGTH_AMCME(:,1) = squeeze(Im_error_avg_inf_kron(1,:,1))';   %TRANSFORMER LOADING
LENGTH_AMCME(:,2) = squeeze(Im_error_avg_inf_kron(1,:,2))';   % 0.5l
LENGTH_AMCME(:,3) = squeeze(Im_error_avg_inf_kron(2,:,2))';   % 1l
LENGTH_AMCME(:,4) = squeeze(Im_error_avg_inf_kron(3,:,2))';   % 1.5l
LENGTH_AMCME(:,5) = squeeze(Im_error_avg_inf_our(1,:,2))';    % 0.5L
LENGTH_AMCME(:,6) = squeeze(Im_error_avg_inf_our(2,:,2))';    % 1L
LENGTH_AMCME(:,7) = squeeze(Im_error_avg_inf_our(3,:,2))';    % 1.5L
save('E:\Chaminda\7.State_Estimation_LotusGrove\V3_with_new_Krons\Error_with_length\With_Comparision\Results\LENGTH_AMCME.csv', 'LENGTH_AMCME', '-ASCII','-append');


%% ACME
LENGTH_ACME(:,1) = squeeze(Im_error_avg_2_kron(1,:,1))';   %TRANSFORMER LOADING
LENGTH_ACME(:,2) = squeeze(Im_error_avg_2_kron(1,:,2))';   % 0.5l
LENGTH_ACME(:,3) = squeeze(Im_error_avg_2_kron(2,:,2))';   % 1l
LENGTH_ACME(:,4) = squeeze(Im_error_avg_2_kron(3,:,2))';   % 1.5l
LENGTH_ACME(:,5) = squeeze(Im_error_avg_2_our(1,:,2))';    % 0.5L
LENGTH_ACME(:,6) = squeeze(Im_error_avg_2_our(2,:,2))';    % 1L
LENGTH_ACME(:,7) = squeeze(Im_error_avg_2_our(3,:,2))';    % 1.5L
save('E:\Chaminda\7.State_Estimation_LotusGrove\V3_with_new_Krons\Error_with_length\With_Comparision\Results\LENGTH_ACME.csv', 'LENGTH_ACME', '-ASCII','-append');
