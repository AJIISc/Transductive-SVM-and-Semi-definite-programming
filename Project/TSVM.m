
function [alpha,w_temp,Ker_temp,b_temp]=TSVM(X_l,X_u,Y_l,kernel,beta,b)

global  tol C1 C2
N_l=size(X_l,1);
N_u=size(X_u,1);
N=N_l+N_u;
X=[X_l;X_u];

switch kernel
    case 'linear'
        Ker=Ker_Linear(X,X);
    case 'polynomial'
        Ker=Ker_Polynomial(X,X);
    case 'RBF'
        Ker=Ker_RBF(X,X);
    case 'Sigmoid'
        Ker=Ker_Sigmoid(X,X);
end
%Delta
Delta1=zeros(N_l,1);
Delta2=C2*sign(X_u*beta+b);
Delta=[Delta1;Delta2];

%Quadprog

T_11=diag(Y_l);
T_12=[diag(-ones(N_u,1)),diag(ones(N_u,1))];
T_1=blkdiag(T_11,T_12);

T_21=diag(ones(N_l,1));
T_22=[diag(-ones(N_u,1)),diag(-ones(N_u,1))];
T_2=blkdiag(T_21,T_22);

H=T_1'*Ker*T_1;

f=(Ker*Delta)'*T_1-ones(N,1)'*T_2;


Aeq=ones(N,1)'*T_1;

beq=-Delta2'*ones(N_u,1);


A_1=[diag(ones(N_l,1));diag(-ones(N_l,1))];
A_2=diag(-ones(2*N_u,1));
A_31=diag(-ones(N_u,1));
A_32=diag(ones(N_u,1));
A_3=[A_31,A_31;A_32,A_32];
A_23=[A_2;A_3];
A=blkdiag(A_1,A_23);


b_1=repmat(C1,N_l,1);
b_2=zeros(N_l+3*N_u,1);
b_3=repmat(C2,N_u,1);
b=[b_1
    b_2
    b_3];


alpha=quadprog(H,f,A,b,Aeq,beq);
% quadprog

w_temp=(((T_1*alpha)'+Delta')*X)';

index=(1:N_l)';
sv=index(alpha(1:N_l)>tol&alpha(1:N_l)<C1);


if size(sv,1)~=0
   
    disp('KKT condition is satisfied!');
    temp_b=0;
    for i=1:size(sv,1)
        temp_b=temp_b+Y_l(sv(i))-X_l(sv(i),:)*w_temp;
    end
    b_temp=temp_b/size(sv,1);
else
    
    disp('KKT condition is NOT satisfied!');
    f_LP=Delta2'*ones(N_u,1)+sum(T_1*alpha);
    A_LP=Y_l;
    b_LP=ones(N_l,1)-Y_l.*(X_l*w_temp);
   
    b_temp=linprog(f_LP,A_LP,b_LP);
    
end

Ker_temp=Ker;
return










