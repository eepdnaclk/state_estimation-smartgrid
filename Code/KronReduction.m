%Author: Chaminda Bandara
%Descrption: Function uses Kron Reduction to reomove a column
%Input:Y==> Matrix to be reduced, p==> Row and Colum to be removed
%OutPut: Reduced Matrix
function Y_Reduced = KronReduction(Y,p,reduction_type)
[row,col]=size(Y);
Y_new=zeros(row,col);  %Produces 4 by 4 matrixes of zeros
%In this loop all p colum and row is replaced by 0 and other by respective
%value
for k=1 :row
    for l=1 : col
        if k==p || l==p
            Y_new(k,l)=0;
        else
           Y_new(k,l)=Y(k,l)-((Y(k,p)*Y(p,l))/(Y(p,p)));
        end
    end
end
% To remove p row and colum
Y_new(:, p) = [];
Y_new(p, :) = [];
%Y_Reduced=Y_new;

if reduction_type==1
	Y_Reduced=Y_new;
end

if reduction_type==2
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%% Modified Kron's Reduction%%%%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	Y_scaled = [ (1+(Y(1,4)/Y(4,4))), Y(1,4)/Y(4,4), Y(1,4)/Y(4,4);
                Y(2,4)/Y(4,4), (1+(Y(2,4)/Y(4,4))), Y(2,4)/Y(4,4);
                Y(3,4)/Y(4,4), Y(3,4)/Y(4,4), (1+(Y(3,4)/Y(4,4)))];
	Y_Reduced = inv(Y_scaled)*Y_new;
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
end