function [ SE_V,Y_red,Y] = SE(SE_V, Mes_points, line, line_length, Uref, Sigma_P, Sigma_V, reduction_type)
%measurement vector = [BUS1_vm, BUS1_va, BUS2_vm, Mes_points, BUS3_vm, BUS3_va, P1, P2, P3, Q1, Q2, Q3, V1, V2, V3]
%The only change happen to the last three voltages
%Other are always known

%Mes_points=[BUS2_V1, BUS2_V2, BUS3_v3]
%Mes_points=[1,1,1]

%WE always going to store previous bus voltages and angles in BUS_V_i
%matrix

%line=line numner=1,2,3,4,5,6

%Sigma_P = Uncertainity in power measurements
%Sigma_Q = uncertainity in voltage measurements

%U = Uncertainity = [Voltages, angles, Power]
load('LF_P.mat');
load('LF_Q.mat');
load('LF_V.mat');

%Uncertainity Calculation ...
U = [300*(Sigma_V/(1.96*100)), 0.05, 7000*(Sigma_P/(1.96*100))]; %V,Angle,PQ
u = [U(1), U(2), U(1), U(2), U(1), U(2), U(3), U(3), U(3), U(3), U(3), U(3)];

switch line
    case 11
        V_i = SE_V(1,1:3);
    case 15
        V_i = SE_V(14,1:3);
    case 25
        V_i = SE_V(1,1:3);
    case 31
        V_i = SE_V(1,1:3);
    case 39
        V_i = SE_V(35,1:3);
    case 48
        V_i = SE_V(1,1:3);
    case 57
        V_i = SE_V(51,1:3);
    otherwise
        V_i = SE_V(line,1:3);
end
Z = [abs(V_i(1,1)); angle(V_i(1,1)); abs(V_i(1,2)); angle(V_i(1,2)); abs(V_i(1,3)); angle(V_i(1,3)); LF_P(line,1); LF_P(line,2); LF_P(line,3); LF_Q(line,1); LF_Q(line,2); LF_Q(line,3)];
Z_u = [0;0;0;0;0;0;7000*(Sigma_P/(1.96*100))*randn(6,1)];
Z = Z + Z_u;

%CALCULATING STATE VECTOR COEFFICIENTS
%PQ(1,1) = LINE 1, PHASE 1
%PQ(1,2) = LINE 1, PHASE 2
%PQ(1,3) = LINE 1, PHASE 3
[P1_subbus,Q1_subbus,Y_red,Y] = PQ3(line_length,1,Uref, reduction_type); %PHASE 1 = P AND Q
[P2_subbus,Q2_subbus,~,~] = PQ3(line_length,2,Uref, reduction_type); %PHASE 2 = P AND Q
[P3_subbus,Q3_subbus,~,~] = PQ3(line_length,3,Uref, reduction_type); %PHASE 3 = P AND Q
%DEFINE MEASUREMENT VECTOR
H = zeros(12+sum(Mes_points),12);
H(1,1) = 1;
H(2,2) = 1;
H(3,3) = 1;
H(4,4) = 1;
H(5,5) = 1;
H(6,6) = 1;
H(7,:) = P1_subbus;
H(8,:) = P2_subbus;
H(9,:) = P3_subbus;
H(10,:) = Q1_subbus;
H(11,:) = Q2_subbus;
H(12,:) = Q3_subbus;
index = 12;

for i=1:3
    switch Mes_points(i)
    case 1
        Z(end+1) = abs(LF_V(line+1,i)) + 300*(Sigma_V/(1.96*100))*randn(1,1);
        u(end+1) = U(1);
        H(index+1,6+2*(i-1)+1) = 1;
        index = index+1;
    otherwise  
    end
end
R = diag(u);
% STATE ESTIMATION
% display(size(H));
% display(size(R));
% display(size(Z));
x = inv(H'*inv(R)*H)*H'*inv(R)*Z;

%Bus voltages as COMPLEX NUMBERS
Bus_i_V = [x(1)*exp(1i*x(2)),   x(3)*exp(1i*x(4)),  x(5)*exp(1i*x(6))];
Bus_j_V = [x(7)*exp(1i*x(8)),   x(9)*exp(1i*x(10)), x(11)*exp(1i*x(12))];

SE_V(line+1,1:3) = Bus_j_V;
end