function [Tableau]=rep(tab)
[a,b]=size(tab);
cpt=0;
vect=[];
for i=1:b-1
    for j=i+1:b;
    if tab(i)==tab(j)
            cpt=cpt+1;
            vect(cpt)=j;
            
        else
          
        end
        %[a,b]=size(tab);
    end
end
tab;
vect;
tab(vect)=[];
tab;
end