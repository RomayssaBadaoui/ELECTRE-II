function [MAT]=InverserLesRelations(A,n)
Mat=zeros(n,n);
for i=1:n
    for j=1:n
        if A(i,j)==1
            MAT(j,i)=1;
        else
            MAT(j,i)=0;
        end
    end
end
MAT;
end