%% A : matrice de surclassement fort
%% M : matrice de surclassement faible
%% n : nombre d'actions

function Classement=PremierPreordreComplet(A,M,n)
Classement=[];
M;
D=[];
Y=ones(1,n);
compteur=n;
iteration=1;
while compteur~=0
    
    D=[];
for i=1:n
    cpt=0;
    if Y(i)==1
    for j=1:n
        if A(j,i)==0
            cpt=cpt+1;
        end
    end
    end
   
    if cpt==n
        D(i)=1;
    else
        D(i)=0;  %%%%%%%%%%%%%%%%%%%%%%%
    end
end

D;

%%%%%%%%% Les sommets ayant une relation dans le graphe de surclassement
%%%%%%%%% faible
vect=[];
cpt=0;
for i=1:n
    if D(i)==1
        cpt=cpt+1;
        vect(cpt)=i;
    end
end
vect;
[a,b]=size(vect);
cpt=0; U=[];
for i=1:b%b-1
    for j=i+1:b
       if i~=j
        if M(vect(i),vect(j))==1 || M(vect(j),vect(i))==1
            cpt=cpt+1;
            U(cpt)=vect(i);
            cpt=cpt+1;
            U(cpt)=vect(j);
        end
        end
    end
end
U;
%%%% Supprimer les répetitions
[a,b]=size(U);
cpt=0;
vect=[];
for i=1:b-1
    for j=i+1:b;
    if U(i)==U(j)
            cpt=cpt+1;
            vect(cpt)=j;
            
        else
          
        end
        %[a,b]=size(tab);
    end
end
U;
vect;
U(vect)=[];
U;
[a,b]=size(U);
B=[];
M;
Y;
A;
cpt1=0;
for i=1:b
    cpt=0; 
    for j=1:n
       % if Y(U(i))==1 %%%%%%%%
       if M(j,U(i))==0
            cpt=cpt+1;
       end
       % end        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    if cpt==n
        cpt1=cpt1+1;
        B(cpt1)=U(i);
    end
end
B;

%%%%%% D-U union B
[a,b]=size(D);
cpt=0;
tab=[];

D;%%%%%%%%%%%%%%%% %%%%%%%%%%%%%% %%%%%%%%%
for i=1:b
   if D(i)==1
        cpt=cpt+1;
        tab(cpt)=i;
    end
end
D=tab;
D;

tab=[D,U];
[a,b]=size(tab);

vect;
vect=[]; 
    cpt=0;
    for i=1:b-1
        for j=i+1:b
            if tab(i)==tab(j)
                cpt=cpt+1;
                vect(cpt)=i;
                cpt=cpt+1;
                vect(cpt)=j;
            end
            
        end
        vect;
    end
    vect
    tab
    tab(vect)=[];
    
    tab=[tab,B];
    
    tab %solution
    Class=[];
    [a,b]=size(tab);
    for i=1:b
        M(:,tab(i))=zeros(n,1);
        M(tab(i),:)=zeros(1,n);
        A(:,tab(i))=zeros(n,1);
        A(tab(i),:)=zeros(1,n);
        Y(tab(i))=0;
        Class(i,1)=tab(i);
        Class(i,2)=iteration;
    end
    Class;
    Y
    compteur=0;
    for i=1:n
        if Y(i)==1
            compteur=compteur+1;
        end
    end
    compteur
    M;
    iteration=iteration+1;
    Classement=[Classement;Class];
end
Classement;
end







