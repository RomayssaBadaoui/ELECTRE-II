function ELECTRE_II (n,m,A,p,c0,c,c1,d1,d2)


[n,m]=size(A); % n : nombre d'actions, m : nombre de critères
cpt=0;
for i=1:m
  cpt=cpt+p(i);
end
if cpt ~= 100
disp('Erreur dans les poids');
end

%Affichage de la matrice 
mat=[A; p]

%Matrice de concordance et de discordance

for i=1:n %pour se déplacer dans les lignes (actions) (se fixer à une action précise)
    for k=1:n %pour pouvoir se déplacer dans les lignes et comparer avec l'action fixée par i
for j=1:m %pour se déplacer dans les colonnes (les critères)
    if i==k %comparer l'action fixée par rapport à toutes les autres
        concord(k,j)=-inf;
    else
        if A(i,j)> A(k,j)
            concord(k,j)=1;
        else if A(i,j)< A(k,j)
            concord(k,j)=0; 
            else
                concord(k,j)=2; %en cas d'égalité (pour avoir J=)
            end
        end
    end
end
    end
    concord; %la matrice de concordance de l'action fixée par rapport aux autres (ex : a1 / ai i=1:nbe d'actions)
   
for k=1:n
 if k>i

J=concord(k,:);
cptC=0; cptD=0;
t=1;
for l=1:m
 if J(l)==1 
     cptC=cptC+p(l);
 else if J(l)==2
         cptC=cptC+p(l);
         cptD=cptD+p(l);
     else
         cptD=cptD+p(l);
     Dis(t)=l; t=t+1;
     end
 end
 IC=cptC/100;
 ID=cptD/100;
end
PPLUS=0; PPMOINS=0;
for l=1:m
    if J(l)==1
        PPLUS=PPLUS+p(l);
    else if J(l)==0
            PPMOINS=PPMOINS+p(l);
        end
    end
end
matpoids(i,k)=PPLUS/PPMOINS;
matconcord(i,k)=IC;
matconcord(k,i)=ID;
Dis;
 end 
if k<i
J=concord(k,:);
PPLUS=0; PPMOINS=0;
for l=1:m
    if J(l)==1
        PPLUS=PPLUS+p(l);
    else if J(l)==0
            PPMOINS=PPMOINS+p(l);
        end
    end
end
matpoids(i,k)=PPLUS/PPMOINS;  
         end
         
    end
    matconcord(i,i)=-inf;
    matpoids(i,i)=-inf;
   % matconcord
   % matpoids


end
matconcord
matpoids
  %Les matrice de discordance de chaque critère
  matfinale=zeros(n);
  matfinale1=zeros(n);
 
  for i=1:m %on travaille sur un critère à la fois
      
      for j=1:n %on sélectionne une action
          t=1;
          for k=1:n %on compare l'action sélectionnée aux autres actions
              if j~= k
                  if A(j,i)>=A(k,i)
                      tab(t)=1;
                      matcondis(k,j)=tab(t);
                      t=t+1;
                  else 
                      tab(t)=0;
                      matcondis(k,j)=tab(t);
                      t=t+1;
                  end
              else
                  tab(t)=-inf;
                  matcondis(k,j)=tab(t);
              end
              
          end
      
         
      end
       matcondis;
       for j=1:n
           for k=1:n
               if matcondis(j,k)==1
                   %%%%%%%%%%%%%%%%%%%%%%%%%%% 
                   matcondis(j,k)=A(k,i)-A(j,i);
               end
           end
       end
       matcondis; %pour chaque critère on a les valeurs gj(ak)-gj(ai)
  
    %On détermine les deux matrice par rapport à d1 et d2 (pour les utiliser dans les tests de surclassement)
    matfin=zeros(n); matfin1=zeros(n);
    
    for j=1:n
        for k=1:n
            if matcondis(j,k)<=d1(i)
                matfin(j,k)=matfin(j,k)+1;
            end
        if matcondis(j,k)<=d2(i)
            matfin1(j,k)=matfin1(j,k)+1;
        end
    end
    end
    matfin;
    matfin1;
    matfinale=matfinale+matfin;
    matfinale1=matfinale1+matfin1;
  end
  matfinale;
  matfinale1;
    
  
  
  %Hypothèses de surclassement 
  for i=1:n
      for j=1:n
          if i~=j
              if matpoids(i,j)>=1
                  if matfinale(i,j)==m
                      if matconcord(i,j)>= c0
                          if matconcord(i,j)>=c
                              if matconcord(i,j)>=c1
                                  solution(i,j)=2;
                              else
                                  if matfinale1(i,j)==m
                                      solution(i,j)=2;
                                  else
                                      solution(i,j)=1;
                                  end
                              end
                          else
                              solution(i,j)=1;
                          end
                      else
                          solution(i,j)=0;
                      end
                  else
                      solution(i,j)=0;
                  end
              else
                  solution(i,j)=0;
              end
          else
              solution(i,j)=-inf;
          end
          
      end
      
  end
  solution
  for i=1:n
      for j=1:n
          if i==j
            SurFort(i,j)=-inf;
            SurFaible(i,j)=-inf;
          else
              if solution(i,j)==2
                  SurFort(i,j)=1;
              else if solution(i,j)==1
                      SurFaible(i,j)=1;
                  else
                      SurFort(i,j)=0;
                      SurFaible(i,j)=0;
              end
          end
      end
      end
  end
  SurFort;
  SurFaible;

   for i=1:n
       SurFort(i,i)=0;
       SurFaible(i,i)=0;
   end
   SurFort
   SurFaible
   
  cycleFort=TrouverCircuits(SurFort,n);
  cycleFaible=TrouverCircuits(SurFaible,n);
   
  cycleFortfinal=cycles(cycleFort,n);
  cycleFaiblefinal=cycles(cycleFaible,n);
   
 %Supprimer les sommets appartenant à un cycle et avoir la matrice finale
 %Construction d'un stable
 
 MatFort=TrouverMatriceSansCycles(SurFort,cycleFortfinal,n);
 MatFaible=TrouverMatriceSansCycles(SurFaible,cycleFaiblefinal,n);
 
 %Construction du premier préordre complet 
 Classement=PremierPreordreComplet(MatFort,MatFaible,n);
 tab=[];
 tab=[tab,Classement(:,2),Classement(:,1)];
 Classement=tab
 
 %Construction du second préordre complet
 
 %On inverse les relations des matrices
 MatFortInv=InverserLesRelations(MatFort,n);
 MatFaibleInv=InverserLesRelations(MatFaible,n);
 ClassementInv=PremierPreordreComplet(MatFortInv,MatFaibleInv,n);
 %Réajuster le classement
 
% %  [a,b]=size(ClassementInv);
% %  resultat=zeros(a,1);
% %  max=ClassementInv(a,2);
% %  for i=1:a
% %      resultat(i,1)=1+max-ClassementInv(i,2);
% %  end
% %  ClassementInv=[ClassementInv,resultat];
% %  ClassementInv(:,2)=[];
% %  ClassementInv;
 %Mettre en ordre le classement inverse
 %Mettre en ordre le classement inverse
 
 [a,b]=size(ClassementInv);
 tab=zeros(a,b); k=a; r_max=ClassementInv(a,2);
 for i=1:a
     
         tab(i,2)=1+r_max-ClassementInv(k,2);
         tab(i,1)=ClassementInv(k,1);
     
     k=k-1;
 end

 ClassementInv=tab;
 tab=[];
 tab=[tab,ClassementInv(:,2),ClassementInv(:,1)];
 ClassementInv=tab;
 %%%% Construction de préordre partiel final
 MatPref=MatricePreference(Classement,n);
 MatPrefInv=MatricePreference(ClassementInv,n);
 MatPreordreFinal=PreordrePartielFinal(MatPref,MatPrefInv,n);
 for i=1:n
     MatPreordreFinal(i,i)=0;
 end
 mat=MatPreordreFinal;
 %Solution=Classement(MatPreordreFinal,n)
 %%%%%%%%%%%%% %%%%%%%%%%%%%%%%
 %%%%%%%%%%
 %
  Class=[];
resultat=zeros(n,1);
for i=1:n
     for j=1:n
         if i~=j
             if mat(i,j)==2
           resultat(i,1)=resultat(i,1)+1;  
             end
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
Class=[Class,ordre,tab]
Incomparabilite=[];
Equivalence=[];
for i=1:n
    for j=i+1:n
        if i~=j
            if mat(i,j)==-1
                Incomparabilite=[Incomparabilite;i,j];
            end
            if mat(i,j)==1
                Equivalence=[Equivalence;i,j];
            end
        end
    end
end
Incomparabilite
Equivalence
  end
  
  
  
