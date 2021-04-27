% clear all;
% close all;
% clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%PREDEFINED VALUES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

min_power 			= 0.25; %Minimum power of each load
max_power 			= 8; 	%Maximum power of each load
Transformer_rating 	= 400;
it					= 1;
V_un 				= [0.1, 0.1, 0.5, 0.5];
P_un 				= [0.2, 0.5, 0.8, 1];
length_factor 		= [0.5 1 1.5 2 2.5];
n_MC 				= 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Network Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
secLengths      = cell(8,1);
secCustomers    = cell(8,1);

%SECTIONA 1
secCustomers{1} =[3 1 2 2 2 2 2 2 2 1]; %No of customers connected
secLengths{1}   =[36 19 21 27 24 26 28 23 21 22]; 	%Distance to each node

%SECTION 2
secCustomers{2} =[0 0 1 1];				%No of customers connected
secLengths{2}   =[36 30 30 32]; 					%Distance to each node

%SECTION 3
secCustomers{3} =[2 2 2 2 2 1 1 2 2 1]; %No of customers connected
secLengths{3}   =[25 25 30 25 26 10 9 11 12 9]; 	%Distance to each node

%SECTION 4
secCustomers{4} =[1 1 1 1 1 1]; 		%No of customers connected
secLengths{4}   =[27 28 29 25 24 26]; 				%Distance to each node

%SECTION 5
secCustomers{5} =[0 0 0 0 2 1 2 1]; 	%No of customers connected
secLengths{5}   =[22 30 33 28 23 24 25 29]; 		%Distance to each node

%SECTION 6
secCustomers{6} =[0 0 2 2 2 2 4 3 3]; 	%No of customers connected
secLengths{6}   =[28 27 20 20 23 24 20 25 24]; 		%Distance to each node

%SECTION 7
secCustomers{7} =[0 0 1 2 2 2 2 2 1]; 	%No of customers connected
secLengths{7}   =[44 29 30 25 27 22 28 23 30]; 		%Distance to each node

%SECTION 8
secCustomers{8} =[2 2 2 2 1 3]; 		%No of customers connected
secLengths{8}   =[30 28 29 24 28 15]; 				%Distance to each node
		
%Calculating total number of loads
totalnumload	= sum(secCustomers{1}) + sum(secCustomers{2}) + sum(secCustomers{3}) ... 
+ sum(secCustomers{4}) + sum(secCustomers{5}) + sum(secCustomers{6}) ... 
+ sum(secCustomers{7}) + sum(secCustomers{8});

c=[0 0 13 0 0 34 0 50]; 	%Connection point when starting new Line
Mes_points  =  [1,1,1;  %%BUS1
				0,0,1;  %%BUS2
				1,0,1;  %%BUS3
				0,0,1;  %%BUS4
				0,1,1;  %%BUS5
				1,1,0;  %%BUS6
				0,1,1;  %%BUS7
				0,1,1;  %%BUS8
				1,0,1;  %%BUS9
				0,0,1;  %%BUS10
				1,1,0;  %%BUS11
				0,0,1;  %%BUS12
				1,0,1;  %%BUS13
				0,0,1;  %%BUS14
				0,1,1;  %%BUS15
				1,1,0;  %%BUS16
				0,1,1;  %%BUS17
				0,1,1;  %%BUS18
				1,0,1;  %%BUS19
				0,0,1;  %%BUS20
				1,1,0;  %%BUS21
				0,0,1;  %%BUS22
				1,0,1;  %%BUS23
				0,0,1;  %%BUS24
				0,1,1;  %%BUS25
				1,1,0;  %%BUS26
				0,1,1;  %%BUS27
				0,1,1;  %%BUS28
				1,0,1;  %%BUS29
				0,0,1;  %%BUS30
				1,1,0;  %%BUS31
				0,0,1;  %%BUS32
				1,0,1;  %%BUS33
				0,0,1;  %%BUS34
				0,1,1;  %%BUS35
				1,1,0;  %%BUS36
				0,1,1;  %%BUS37
				0,1,1;  %%BUS38
				1,0,1;  %%BUS39
				0,0,1;  %%BUS40
				1,1,0;  %%BUS41
				0,0,1;  %%BUS42
				1,0,1;  %%BUS43
				0,0,1;  %%BUS44
				0,1,1;  %%BUS45
				1,1,0;  %%BUS46
				0,1,1;  %%BUS47
				0,1,1;  %%BUS48
				1,0,1;  %%BUS49
				0,0,1;  %%BUS50
				1,1,0;  %%BUS51
				0,0,1;  %%BUS52
				1,0,1;  %%BUS53
				0,0,1;  %%BUS54
				0,1,1;  %%BUS55
				1,1,0;  %%BUS56
				0,1,1;  %%BUS57
				0,1,1;  %%BUS58
				1,0,1;  %%BUS59
				0,0,1;  %%BUS60
				1,0,1;  %%BUS61
				0,0,1  %%BUS62
				];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% START LOOP%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for length_case = 1:3
	Sigma_P = P_un(1,1);
	Sigma_V = V_un(1,1);
	for Loading = 0.1:0.05:1
	
		Vm_error_inf_kron= 0;
		Vm_error_2_kron	= 0;
        Im_error_inf_kron= 0;
		Im_error_2_kron	= 0;
        
        Vang_error_inf_kron	= 0;
		Vang_error_2_kron	= 0;
        Iang_error_inf_kron	= 0;
		Iang_error_2_kron	= 0;
        
        Vm_error_inf_our= 0;
		Vm_error_2_our	= 0;
        Im_error_inf_our= 0;
		Im_error_2_our	= 0;
        
        Vang_error_inf_our	= 0;
		Vang_error_2_our	= 0;
        Iang_error_inf_our	= 0;
		Iang_error_2_our	= 0;
		
		for MC	= 1:n_MC
			%Calculating load values for each loding...
			powerfactor			= round(0.9+0.1*rand(totalnumload,1),3);
			mean_pf 			= mean(powerfactor);
			Total_active_power 	= Transformer_rating*Loading*mean_pf;
			loadpower			= round(randfixedsum(totalnumload,1,Total_active_power,min_power,max_power),1);
			
			%Creating single phase loads for each customer ...
			for v = 1:totalnumload
				f = normrnd(1,0.1,[1,3]); %Generate normally distributed random variable with mean 1 and std=0.2
				Load_power_Ac(v,:) = f.*(loadpower(v)/sum(f)); %Generate signle phase load power values
			end
			
			%Calculating PV capacities for each loading...
			pvkw	= Loading*[2 6 4.2 5 4.2 4.2 2 10 4 5.4 5 3.3 5 2.6 3.5 17 10 5.3 4.8 6.9 4.3];
			pvkva	= pvkw/sqrt(1-0.44^2);
			pvphase	= randi(3,length(pvkw),1);
			pvbus	= randi(62,length(pvkw),1);

			if exist('DSSStartOK','var')==0
				[DSSStartOK, DSSObj, DSSText] = DSSStartup(cd);
			end

			DSSStartOK;
			if DSSStartOK
				
			DSSText.command = 'Clear';

			DSSText.command = 'new circuit.Feeder01 basekv=11 pu=1.05 phases=3 bus1=SourceBus Angle=30';    
			 
			DSSText.command = 'New Wiredata.ABC70Ph GMR=0.0035937 DIAM=9.9 RDC=0.443';
			DSSText.command = '~ Runits=km radunits=mm gmrunits=m';
			DSSText.command = 'New Wiredata.ABC70Ne GMR=0.0034485 DIAM=9.5 RDC=0.63';
			DSSText.command = '~ Runits=km radunits=mm gmrunits=m';
			 
			DSSText.command = 'New Linegeometry.ABC70 nconds=4 nphases=3';
			DSSText.command = '~ cond=1 Wire=ABC70Ph x=0.00675 h=8.00675 units=m';
			DSSText.command = '~ cond=2 Wire=ABC70Ph x=0.05235 h=8.00675 units=m';
			DSSText.command = '~ cond=3 Wire=ABC70Ph x=0.01985 h=7.9869  units=m';
			DSSText.command = '~ cond=4 Wire=ABC70Ne x=0.01985 h=8       units=m';
			DSSText.command = 'New Transformer.TR1 Buses=[SourceBus.1.2.3.0, busno_0.1.2.3.4] Phases=3 Conns=[Delta Wye] kVs= [11 0.413] kVAs=[400 400] XHL=10 Rneut=0.5'; %%Windings=2 %%%%%DSSText.command = 'New Linecode.ALXLPE R1=0.35 X1=0.026 R0=.1784 X0=.4047 C1=3.4 C0=1.6 Units=km';
			 
			% define lines for all bus path with  transmission line
			k	= 1;   
			p	= 1;
			feders_starts	= [];
			separation		= [];
			
			for i=1:8
				%for each i value, length1 = length_i
                length1 = length_factor(length_case).*secLengths{i};
				%for each i value, Costomers = node_no_customers_i
                Customers = secCustomers{i};

				%%%%% line connecton bus blength1)-1)];
				busnum	= [c(i) k:1:(k+length(length1)-1)];
				
				feders_starts	= [feders_starts k];
				separation		= [separation c(i)];
				
				for j=1:length(length1)
				%%%% define the transmission line 
					DSSText.command = strcat('New Line.LINE',num2str(k),' Bus1=busno_',num2str(busnum(j)),'.1.2.3.4 Bus2=busno_',num2str(busnum(j+1)),'.1.2.3.4 Geometry=ABC70 Length=',num2str(length1(j)),' Units=m');
					%%%%% define load connected to j+1 bus bar
					if(Customers(j)~=0)
						 for g=1:Customers(j)
							DSSText.command = strcat('New Load.LOAD',num2str(p),'_P1',' Bus1=busno_',num2str(busnum(j+1)),'.1.4 kV=0.238 kW=',num2str(Load_power_Ac(1,1)),' PF=',num2str(powerfactor(p)),' phases=1');
							DSSText.command = strcat('New Load.LOAD',num2str(p),'_P2',' Bus1=busno_',num2str(busnum(j+1)),'.2.4 kV=0.238 kW=',num2str(Load_power_Ac(1,2)),' PF=',num2str(powerfactor(p)),' phases=1');
							DSSText.command = strcat('New Load.LOAD',num2str(p),'_P3',' Bus1=busno_',num2str(busnum(j+1)),'.3.4 kV=0.238 kW=',num2str(Load_power_Ac(1,3)),' PF=',num2str(powerfactor(p)),' phases=1');
							p=p+1;
						  end
					end
					k	= k+1;
			   end
			end
			nofbus 			= k-1;
			feders_starts	= [feders_starts nofbus];

			%%% adding Pv panel
			DSSText.command = 'New XYCurve.MyPvsT npts=4 xarray=[0 25 75 100] yarray=[1.0 1.0 1.0 1.0]';
			DSSText.command = 'New XYCurve.MyEff npts=4 xarray=[0.1 0.2 0.4 1.0] yarray=[1.0 1.0 1.0 1.0]';

			for y=1:length(pvkw)
				DSSText.command = strcat('New PVSystem.PV',num2str(y),' phases=1 Bus1=busno_',num2str(pvbus(y)),'.',num2str(pvphase(y)),'.4 kv=0.24 kVA=',num2str(pvkva(y)),' irrad=1 Pmpp=',num2str(pvkw(y)),' PF=1 effcurve=MyEff P-Tcurve=MyPvsT');
			end

			DSSText.command = 'Set voltagebases=[11 0.413]';
			DSSText.command = 'Calcvoltagebases';
				
			DSSText.command = 'Solve';
			%DSSText.command = 'show voltages';
			%DSSText.command = 'Show Voltage LN Nodes';
			%DSSText.command = 'Show power kva elem';
			%DSSText.command = 'Show current elem';

			for i = 0:(nofbus)
				im	= strcat('busno_',num2str(i));
				DSSObj.ActiveCircuit.Buses(im);
				puvoltage(i+1,:)	= DSSObj.ActiveCircuit.ActiveBus.puVoltages; 
			end

			%EXTRACTING VOLTAGE (COMPLEX) AT EACH NODE 0-62 NODES TOTAL = 63 NODES
			for i=0:(nofbus)
				LF_V(i+1,1) = (puvoltage(i+1,1)+1i*puvoltage(i+1,2))*0.413*10^3/sqrt(3); 
				LF_V(i+1,2) = (puvoltage(i+1,3)+1i*puvoltage(i+1,4))*0.413*10^3/sqrt(3); 
				LF_V(i+1,3) = (puvoltage(i+1,5)+1i*puvoltage(i+1,6))*0.413*10^3/sqrt(3); 
				LF_V(i+1,4) = (puvoltage(i+1,7)+1i*puvoltage(i+1,8))*0.413*10^3/sqrt(3); 
			end

			end
			save('LF_V.mat','LF_V');
			Uref = round(mean(mean(abs(LF_V(:,1:3)))),0)+1;

			%%%%%%%%%%%%%%%%%%%%%%%%% EXTRACT P AND Q %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			for line=1:(nofbus)
			DSSText.Command=strcat('select Line.LINE',num2str(line));
			LF_PQ(line,:) = DSSObj.ActiveCircuit.ActiveElement.power;
			LF_P(line,:)=1000.*[LF_PQ(line,1),LF_PQ(line,3),LF_PQ(line,5)];
			LF_Q(line,:)=1000.*[LF_PQ(line,2),LF_PQ(line,4),LF_PQ(line,6)];
			end
			save('LF_P.mat','LF_P');
			save('LF_Q.mat','LF_Q');
			S=LF_P + 1i*LF_Q;
			save('S.mat','S');

			%%%%%%%%%%%%%%%%%%%%%%%%% EXTRACT I %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			% for i_Line = 1:NrOfLines
			% DSSObject.ActiveCircuit.SetActiveElement( LinesListDSS{i_Line} );
			% Currents_DSS_Lines(i_Line,:) = DSSObject.ActiveCircuit.ActiveCktElement.Currents;
			% end
			for line=1:(nofbus)
			DSSText.Command=strcat('select Line.LINE',num2str(line));
			temp = DSSObj.ActiveCircuit.ActiveElement.currents;
			LF_I(line,1) = temp(1,1)+1i*temp(1,2);
			LF_I(line,2) = temp(1,3)+1i*temp(1,4);
			LF_I(line,3) = temp(1,5)+1i*temp(1,6);
			LF_I(line,4) = temp(1,7)+1i*temp(1,8);
			end
			
			%%%%%%%%%%%%%%%%%%%%%%%%%%% STATE ESTIMATION - KRON'S METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%% STATE ESTIMATION - KRON'S METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%% STATE ESTIMATION - KRON'S METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%% STATE ESTIMATION - KRON'S METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			SE_V_kron(1,1:3) = LF_V(1,1:3);
			SE_V_kron(1,4) = 0;

			%STATE ESTIMATION   
			line_length	= length_factor(length_case).*[secLengths{1},secLengths{2},secLengths{3},secLengths{4},secLengths{5},secLengths{6},secLengths{7},secLengths{8}];

			for line=1:62
				[SE_V_kron,Y_red,Y] = SE(SE_V_kron,Mes_points(line,:),line,line_length(1,line),Uref,Sigma_P,Sigma_V, 1); %ESTIMATING VOLTAGE MAGNITUDES AND ANGLES
				switch line
					case 11
						SE_I_kron(line,1) = conj(S(line,1)/SE_V_kron(1,1));
						SE_I_kron(line,2) = conj(S(line,2)/SE_V_kron(1,2));
						SE_I_kron(line,3) = conj(S(line,3)/SE_V_kron(1,3));
					case 15
						SE_I_kron(line,1) = conj(S(line,1)/SE_V_kron(14,1));
						SE_I_kron(line,2) = conj(S(line,2)/SE_V_kron(14,2));
						SE_I_kron(line,3) = conj(S(line,3)/SE_V_kron(14,3));
					case 25
						SE_I_kron(line,1) = conj(S(line,1)/SE_V_kron(1,1));
						SE_I_kron(line,2) = conj(S(line,2)/SE_V_kron(1,2));
						SE_I_kron(line,3) = conj(S(line,3)/SE_V_kron(1,3));
					case 31
						SE_I_kron(line,1) = conj(S(line,1)/SE_V_kron(1,1));
						SE_I_kron(line,2) = conj(S(line,2)/SE_V_kron(1,2));
						SE_I_kron(line,3) = conj(S(line,3)/SE_V_kron(1,3));
					case 39
						SE_I_kron(line,1) = conj(S(line,1)/SE_V_kron(35,1));
						SE_I_kron(line,2) = conj(S(line,2)/SE_V_kron(35,2));
						SE_I_kron(line,3) = conj(S(line,3)/SE_V_kron(35,3));
					case 48
						SE_I_kron(line,1) = conj(S(line,1)/SE_V_kron(1,1));
						SE_I_kron(line,2) = conj(S(line,2)/SE_V_kron(1,2));
						SE_I_kron(line,3) = conj(S(line,3)/SE_V_kron(1,3));
					case 57
						SE_I_kron(line,1) = conj(S(line,1)/SE_V_kron(51,1));
						SE_I_kron(line,2) = conj(S(line,2)/SE_V_kron(51,2));
						SE_I_kron(line,3) = conj(S(line,3)/SE_V_kron(51,3));
					otherwise
						SE_I_kron(line,1) = conj(S(line,1)/SE_V_kron(line,1));
						SE_I_kron(line,2) = conj(S(line,2)/SE_V_kron(line,2));
						SE_I_kron(line,3) = conj(S(line,3)/SE_V_kron(line,3));
				end
				SE_I_kron(line,4) = -1*(SE_I_kron(line,1)+SE_I_kron(line,2)+SE_I_kron(line,3));
				Delta_V_kron   = inv(Y)*SE_I_kron(line,:)';
				switch line
					case 11
						SE_V_kron(line+1,4) = SE_V_kron(1,4) - Delta_V_kron(4,1);
					case 15
						SE_V_kron(line+1,4) = SE_V_kron(14,4) - Delta_V_kron(4,1);
					case 25
						SE_V_kron(line+1,4) = SE_V_kron(1,4) - Delta_V_kron(4,1);
					case 31
						SE_V_kron(line+1,4) = SE_V_kron(1,4) - Delta_V_kron(4,1);
					case 39
						SE_V_kron(line+1,4) = SE_V_kron(35,4) - Delta_V_kron(4,1);
					case 48
						SE_V_kron(line+1,4) = SE_V_kron(1,4) - Delta_V_kron(4,1);
					case 57
						SE_V_kron(line+1,4) = SE_V_kron(51,4) - Delta_V_kron(4,1);
					otherwise
						SE_V_kron(line+1,4) = SE_V_kron(line,4) - Delta_V_kron(4,1);
				end
            end
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ERROR_METHOD_1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ERROR_METHOD_1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ERROR_METHOD_1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ERROR_METHOD_1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			Vm_error_inf_kron	= Vm_error_inf_kron + max(max( abs(abs(LF_V(:,1:4))- abs(SE_V_kron(:,1:4))) ));
			Vm_error_2_kron		= Vm_error_2_kron + sqrt(sum(sum(abs(abs(LF_V(:,1:4))- abs(SE_V_kron(:,1:4))).^2))/numel(LF_V(:,1:4)));
            
            Im_error_inf_kron	= Im_error_inf_kron + max(max( abs(abs(LF_I(:,1:4))- abs(SE_I_kron(:,1:4))) ));
			Im_error_2_kron 	= Im_error_2_kron + sqrt(sum(sum(abs(abs(LF_I(:,1:4))- abs(SE_I_kron(:,1:4))).^2))/numel(LF_I(:,1:4)));
            
			Vang_error_inf_kron = Vang_error_inf_kron + max(max( abs(angle(LF_V(:,1:4))- angle(SE_V_kron(:,1:4))) ));
			Vang_error_2_kron 	= Vang_error_2_kron + sqrt(sum(sum(abs(angle(LF_V(:,1:4))- angle(SE_V_kron(:,1:4))).^2))/numel(LF_V(:,1:4)));
            
            Iang_error_inf_kron = Iang_error_inf_kron + max(max( abs(angle(LF_I(:,1:4))- angle(SE_I_kron(:,1:4))) ));
			Iang_error_2_kron 	= Iang_error_2_kron + sqrt(sum(sum(abs(angle(LF_I(:,1:4))- angle(SE_I_kron(:,1:4))).^2))/numel(LF_I(:,1:4)));

			
			
			
			%%%%%%%%%%%%%%%%%%%%%%%%%%% STATE ESTIMATION - OUR METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%% STATE ESTIMATION - OUR METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%% STATE ESTIMATION - OUR METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%% STATE ESTIMATION - OUR METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%clc;
			SE_V_our(1,1:3) = LF_V(1,1:3);
			SE_V_our(1,4) = 0;
			
			for line=1:62
				[SE_V_our,Y_red,Y] = SE(SE_V_our,Mes_points(line,:),line,line_length(1,line),Uref,Sigma_P,Sigma_V, 2); %ESTIMATING VOLTAGE MAGNITUDES AND ANGLES
				switch line
					case 11
						SE_I_our(line,1) = conj(S(line,1)/SE_V_our(1,1));
						SE_I_our(line,2) = conj(S(line,2)/SE_V_our(1,2));
						SE_I_our(line,3) = conj(S(line,3)/SE_V_our(1,3));
					case 15
						SE_I_our(line,1) = conj(S(line,1)/SE_V_our(14,1));
						SE_I_our(line,2) = conj(S(line,2)/SE_V_our(14,2));
						SE_I_our(line,3) = conj(S(line,3)/SE_V_our(14,3));
					case 25
						SE_I_our(line,1) = conj(S(line,1)/SE_V_our(1,1));
						SE_I_our(line,2) = conj(S(line,2)/SE_V_our(1,2));
						SE_I_our(line,3) = conj(S(line,3)/SE_V_our(1,3));
					case 31
						SE_I_our(line,1) = conj(S(line,1)/SE_V_our(1,1));
						SE_I_our(line,2) = conj(S(line,2)/SE_V_our(1,2));
						SE_I_our(line,3) = conj(S(line,3)/SE_V_our(1,3));
					case 39
						SE_I_our(line,1) = conj(S(line,1)/SE_V_our(35,1));
						SE_I_our(line,2) = conj(S(line,2)/SE_V_our(35,2));
						SE_I_our(line,3) = conj(S(line,3)/SE_V_our(35,3));
					case 48
						SE_I_our(line,1) = conj(S(line,1)/SE_V_our(1,1));
						SE_I_our(line,2) = conj(S(line,2)/SE_V_our(1,2));
						SE_I_our(line,3) = conj(S(line,3)/SE_V_our(1,3));
					case 57
						SE_I_our(line,1) = conj(S(line,1)/SE_V_our(51,1));
						SE_I_our(line,2) = conj(S(line,2)/SE_V_our(51,2));
						SE_I_our(line,3) = conj(S(line,3)/SE_V_our(51,3));
					otherwise
						SE_I_our(line,1) = conj(S(line,1)/SE_V_our(line,1));
						SE_I_our(line,2) = conj(S(line,2)/SE_V_our(line,2));
						SE_I_our(line,3) = conj(S(line,3)/SE_V_our(line,3));
				end
				
				SE_I_our(line,4) = -1*(SE_I_our(line,1)+SE_I_our(line,2)+SE_I_our(line,3));
				Delta_V_our   = inv(Y)*SE_I_our(line,:)';
				
				switch line
					case 11
						SE_V_our(line+1,4) = SE_V_our(1,4) - Delta_V_our(4,1);
					case 15
						SE_V_our(line+1,4) = SE_V_our(14,4) - Delta_V_our(4,1);
					case 25
						SE_V_our(line+1,4) = SE_V_our(1,4) - Delta_V_our(4,1);
					case 31
						SE_V_our(line+1,4) = SE_V_our(1,4) - Delta_V_our(4,1);
					case 39
						SE_V_our(line+1,4) = SE_V_our(35,4) - Delta_V_our(4,1);
					case 48
						SE_V_our(line+1,4) = SE_V_our(1,4) - Delta_V_our(4,1);
					case 57
						SE_V_our(line+1,4) = SE_V_our(51,4) - Delta_V_our(4,1);
					otherwise
						SE_V_our(line+1,4) = SE_V_our(line,4) - Delta_V_our(4,1);
				end
			end
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ERROR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ERROR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ERROR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ERROR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			Vm_error_inf_our	= Vm_error_inf_our + max(max( abs(abs(LF_V(:,1:4))- abs(SE_V_our(:,1:4))) ));
			Vm_error_2_our		= Vm_error_2_our + sqrt(sum(sum(abs(abs(LF_V(:,1:4))- abs(SE_V_our(:,1:4))).^2))/numel(LF_V(:,1:4)));
            
            Im_error_inf_our 	= Im_error_inf_our + max(max( abs(abs(LF_I(:,1:4))- abs(SE_I_our(:,1:4))) ));
			Im_error_2_our = Im_error_2_our + sqrt(sum(sum(abs(abs(LF_I(:,1:4))- abs(SE_I_our(:,1:4))).^2))/numel(LF_I(:,1:4)));
            
			Vang_error_inf_our = Vang_error_inf_our + max(max( abs(angle(LF_V(:,1:4))- angle(SE_V_our(:,1:4))) ));
			Vang_error_2_our 	= Vang_error_2_our + sqrt(sum(sum(abs(angle(LF_V(:,1:4))- angle(SE_V_our(:,1:4))).^2))/numel(LF_V(:,1:4)));
            
            Iang_error_inf_our = Iang_error_inf_our + max(max( abs(angle(LF_I(:,1:4))- angle(SE_I_our(:,1:4))) ));
			Iang_error_2_our 	= Iang_error_2_our + sqrt(sum(sum(abs(angle(LF_I(:,1:4))- angle(SE_I_our(:,1:4))).^2))/numel(LF_I(:,1:4)));	

			fprintf('Line length case: %d || Loading: %d || MC:%d \n',length_case,Loading,MC);
		end
		
		%Voltage magnitude errors
		Vm_error_avg_inf_kron(length_case,it,1) = Loading;
		Vm_error_avg_inf_kron(length_case,it,2) = sqrt(Vm_error_inf_kron/MC);
		Vm_error_avg_inf_our(length_case,it,1) = Loading;
		Vm_error_avg_inf_our(length_case,it,2) = sqrt(Vm_error_inf_our/MC);
		
		Vm_error_avg_2_kron(length_case,it,1) = Loading;
		Vm_error_avg_2_kron(length_case,it,2) = sqrt(Vm_error_2_kron/MC);
		Vm_error_avg_2_our(length_case,it,1) = Loading;
		Vm_error_avg_2_our(length_case,it,2) = sqrt(Vm_error_2_our/MC);
        
        %Current magnitude errors
        Im_error_avg_inf_kron(length_case,it,1) = Loading;
		Im_error_avg_inf_kron(length_case,it,2) = sqrt(Im_error_inf_kron/MC);
		Im_error_avg_inf_our(length_case,it,1) = Loading;
		Im_error_avg_inf_our(length_case,it,2) = sqrt(Im_error_inf_our/MC);
		
		Im_error_avg_2_kron(length_case,it,1) = Loading;
		Im_error_avg_2_kron(length_case,it,2) = sqrt(Im_error_2_kron/MC);
		Im_error_avg_2_our(length_case,it,1) = Loading;
		Im_error_avg_2_our(length_case,it,2) = sqrt(Im_error_2_our/MC);
        
        %Voltage angle errors
        Vang_error_avg_inf_kron(length_case,it,1) = Loading;
		Vang_error_avg_inf_kron(length_case,it,2) = sqrt(Vang_error_inf_kron/MC);
		Vang_error_avg_inf_our(length_case,it,1) = Loading;
		Vang_error_avg_inf_our(length_case,it,2) = sqrt(Vang_error_inf_our/MC);
		
		Vang_error_avg_2_kron(length_case,it,1) = Loading;
		Vang_error_avg_2_kron(length_case,it,2) = sqrt(Vang_error_2_kron/MC);
		Vang_error_avg_2_our(length_case,it,1) = Loading;
		Vang_error_avg_2_our(length_case,it,2) = sqrt(Vang_error_2_our/MC);
        
        %Current angle errors
        Iang_error_avg_inf_kron(length_case,it,1) = Loading;
		Iang_error_avg_inf_kron(length_case,it,2) = sqrt(Iang_error_inf_kron/MC);
		Iang_error_avg_inf_our(length_case,it,1) = Loading;
		Iang_error_avg_inf_our(length_case,it,2) = sqrt(Iang_error_inf_our/MC);
		
		Iang_error_avg_2_kron(length_case,it,1) = Loading;
		Iang_error_avg_2_kron(length_case,it,2) = sqrt(Iang_error_2_kron/MC);
		Iang_error_avg_2_our(length_case,it,1) = Loading;
		Iang_error_avg_2_our(length_case,it,2) = sqrt(Iang_error_2_our/MC);		
		it = it+1;
	end
	it=1;
save('Error_with_lengthTemp','-append')
end
