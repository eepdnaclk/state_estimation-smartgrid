
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