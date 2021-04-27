close all;
clc;

%AVERAGE MAXIMUM VOLTAGE MAGNITUDE ERROR
%C1 = Transformer loading
%C2 = 

LENGTH(:,1) = squeeze(Vm_error_avg_inf_kron(1,:,1))';   %TRANSFORMER LOADING
LENGTH(:,1) = squeeze(Vm_error_avg_inf_kron(1,:,2))';   %0.5l
LENGTH(:,1) = squeeze(Vm_error_avg_inf_kron(2,:,2))';   %1l
LENGTH(:,1) = squeeze(Vm_error_avg_inf_kron(3,:,2))';   %1.5l
LENGTH(:,1) = squeeze(Vm_error_avg_inf_our(1,:,2))';    %0.5L
LENGTH(:,1) = squeeze(Vm_error_avg_inf_our(2,:,2))';    %1L
LENGTH(:,1) = squeeze(Vm_error_avg_inf_our(3,:,2))';    %1.5L