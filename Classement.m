%%% mat : matrice issu du préordre partiel final
%%% n : nombre d'action

function [Class]=Classement(mat,n)
Class=[];
resultat=zeros(n,1);
for i=1:n
     for j=1:n
         if i~=j
           resultat(i,1)=resultat(i,1)+mat(i,j);
         end
     end
 end
 resultat;
 D=sort(resultat,'descend');
 resultat1=resultat;
 tab=zeros(n,1);
 cpt=0;
 for i=1:n
     for j=1:n
         if D(i,1)==resultat1(j,1)
             cpt=j;
             
         end
     end
     tab(i,1)=cpt;
     resultat1(cpt,1)=-inf;
     resultat1;
 end
 tab;

 ordre=zeros(n,1);
 cpt=1; ordre(1,1)=cpt;
for i=1:n-1
    j=i+1;
    if D(i)~= D(j)
        cpt=cpt+1;
    end
    ordre(j,1)=cpt;
end
ordre;
Class=[Class,ordre,tab];
end