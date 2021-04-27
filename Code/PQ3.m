function [ P, Q, Y_red, Y] = PQ3(length, v,Uref,reduction_method)
% THIS FUNCTION CACLCULATE STATE MATRIX PARAMETERS

% INPUT TO THE FUNCTION
% line_no : LINE NUMBER OF THE FEEDER 1 AS MARKED IN THE FIGURE
% REQUIRED PHASE: PHASE 1, PHASE 2, PHASE 3

%CONDUCTANCE MATRIX PER UNIT LENGTH
G_u = [ 1544.307189,	-480.390712,	-553.6881161,	-425.5519795;
		-480.390712,	1481.167167,	-503.0823636, 	-362.2165323;
		-553.6881161,	-503.0823636,	1558.250209,	-430.7378822;
		-425.5519795,	-362.2165323,	-430.7378822,	1258.393941];

%SUSEPTANCE MATRIX PER UNIT LENGTH		
B_u = [ -517.2981263,	126.0663549,	64.1738193,		-36.76183315;
		126.0663549,	-655.7768157,	100.3622804, 	56.54297326;
		64.1738193,		100.3622804,	-481.620345,	-47.12491946;
		-36.76183315,	56.54297326,	-47.12491946,	-230.8965785];		

%ADMITTANCE MATRIX FOR THE GIVEN LINE
Y = (G_u + 1i*B_u)./length;

%REDUCED FORM OF Y matrix
Y_red = KronReduction(Y,4, reduction_method);


G = real(Y_red);
B = imag(Y_red);

%PRE DEFINED PARAMETERS
U_ref = Uref; %SINCE THE VOLTAGES ARE VARYING AROUND 250V

for w = 1:1:3
	%ANGLE CALCULATION
	d = v - w;
	switch d
    case 0
        d_psi_r = 0;
    case 1
        d_psi_r = -120;
    case -1
        d_psi_r = 120;
	case 2
        d_psi_r = 120;
    case -2
        d_psi_r = -120;
    otherwise
        disp('ERROR IN ANGLE CALCULATION');
	end
	
	%STATE MATRIX CALCULATION
	%VOLTAGE MAGNITUDE
	P(1, 2*(w-1)+1) = U_ref*( G(v,w)*cosd(d_psi_r) + B(v,w)*sind(d_psi_r));
	P(1, 2*(w-1)+7) = -1*P(1, 2*(w-1)+1);
	P(1, 2*(w-1)+2) = -1*U_ref^2*( -1*G(v,w)*sind(d_psi_r) + B(v,w)*cosd(d_psi_r));
	P(1, 2*(w-1)+8) = -1*P(1, 2*(w-1)+2);
	
	Q(1, 2*(w-1)+1) = U_ref*( G(v,w)*sind(d_psi_r) - B(v,w)*cosd(d_psi_r));
	Q(1, 2*(w-1)+7) = -1*Q(1, 2*(w-1)+1);
	Q(1, 2*(w-1)+2) = -1*U_ref^2*(G(v,w)*cosd(d_psi_r) + B(v,w)*sind(d_psi_r));
	Q(1, 2*(w-1)+8) = -1*Q(1, 2*(w-1)+2);
end

end

