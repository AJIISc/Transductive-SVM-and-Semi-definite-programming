
close all
clear
data_cancer;

DataX=input;
DataY=output;


X_l= DataX (1:500,:);
X_u= DataX (500:569,:);
Y_l= DataY(1:500);
Y_u= DataY(500:569);


Kernel_Cell={'linear';'polynomial';'RBF';'Sigmoid'};


global poly gamma kappa1 kappa2 tol C1 C2
global tolerence


poly=2;

gamma=0.02;

kappa1=0.1;kappa2=0.2;

tol=1e-5;
C1=100;C2=1;

tolerence=1e-4;

X=[X_l;X_u];

%SVM
kernel=char(Kernel_Cell(2));

[alpha,Ker,BB]=SVMT(X_l,Y_l,kernel);
Weight=X_l'*(alpha.*Y_l);

W=sum(((Ker.*alpha).*Y_l),2);
b= sum(Y_l-W)/500;



Y_pred=zeros(size(X_u(:,1)));
switch kernel
    case 'linear'
        Kerr=Ker_Linear(X_l,X_u);
    case 'polynomial'
        Kerr=Ker_Polynomial(X_l,X_u);
    case 'RBF'
        Kerr=Ker_RBF(X_l,X_u);
    case 'Sigmoid'
        Kerr=Ker_Sigmoid(X_l,X_u);
end

LOL=sum(((Kerr.*alpha).*Y_l),1);
Y_pr=LOL+b;
Y_pr=Y_pr.';


for i=1:size(Y_pr)
    
    if    Y_pr(i)>=0
        Y_pred(i)=1;
    else  
        Y_pred(i)=-1;
    end
end
flag=0;
for i=1:size(Y_pr)
     if Y_pred(i)==Y_u(i)
         flag=flag+1;
     end    

end 



Accuracy=flag/69;


%TSVM
z1=z_1(X_l,X_u,Y_l,Weight,BB);

z2=z_2(X_l,X_u,Weight,BB);

z=z1-z2;
ini_z=0;



X_l= DataX (1:500,:);
X_u= DataX (500:569,:);
Y_l= DataY(1:500);
Y_u= DataY(500:569);

while (abs(z-ini_z)>tolerence )
    
    ini_z=z;
   
    %TSVM
    [alphat,beta_kp1,Ker_kp1,beta0_kp1]=TSVM(X_l,X_u,Y_l,kernel,Weight,BB);
    Weight=beta_kp1;
    BB=beta0_kp1;
 
    z1=z_1(X_l,X_u,Y_l,Weight,BB);
    z2=z_2(X_l,X_u,Weight,BB);
    z=z1-z2;
   
    disp('Diffrence='),disp(z-ini_z);
    
    
    
end

alphat=alphat(1:500);
W=sum(((Ker.*alphat).*Y_l),2);
b= sum(Y_l-W)/500;


Y_pred=zeros(size(X_u(:,1)));
Kerr=Ker_RBF(X_l,X_u);
LOL=sum(((Kerr.*alphat).*Y_l),1);
Y_pr=LOL+b;
Y_pr=Y_pr.';


for i=1:size(Y_pr)
    
    if    Y_pr(i)>=0
        Y_pred(i)=1;
    else  
        Y_pred(i)=-1;
    end
end
flag=0;
for i=1:size(Y_pr)
     if Y_pred(i)==Y_u(i)
         flag=flag+1;
     end    

end 
Accuracyt=flag/69;


disp('SVM='),disp(Accuracy)
disp('TSVM='),disp(Accuracyt)
kl1=char(Kernel_Cell(3));
kl2=char(Kernel_Cell(2));
kl3=char(Kernel_Cell(1));
[alpha,Ker,beta0]=SVMTSDP(X,X_l,Y_l,kl1,kl2,kl3);

