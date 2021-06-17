%June11,2016
%SVM
function [alpha,Ker1,BB]=SVMTSDP(XX,X,Y,kl1,kl2,kl3)
% X is N*p, Y is N*1,{-1,1}
% Constant=Inf for Hard Margin
global   C1
c=100;

switch kl1
    case 'linear'
        Ker1=Ker_Linear(X,X);
    case 'ploynomial'
        Ker1=Ker_Polynomial(X,X);
    case 'RBF'
        Ker1=Ker_RBF(X,X);
    case 'Sigmoid'
        Ker1=Ker_Sigmoid(X_l,X_u);
end

switch kl2
    case 'linear'
        Ker2=Ker_Linear(X,X);
    case 'ploynomial'
        Ker2=Ker_Polynomial(X,X);
    case 'RBF'
        Ker2=Ker_RBF(X,X);
   case 'Sigmoid'
        Ker2=Ker_Sigmoid(X_l,X_u);
end

switch kl3
    case 'linear'
        Ker3=Ker_Linear(X,X);
    case 'ploynomial'
        Ker3=Ker_Polynomial(X,X);
    case 'RBF'
        Ker3=Ker_RBF(X,X);
    case 'Sigmoid'
        Ker3=Ker_Sigmoid(X_l,X_u);
end

switch kl1
    case 'linear'
        K1=Ker_Linear(XX,XX);
    case 'ploynomial'
        K1=Ker_Polynomial(XX,XX);
    case 'RBF'
        K1=Ker_RBF(XX,XX);
    case 'Sigmoid'
        Kerr=Ker_Sigmoid(X_l,X_u);
end

switch kl2
    case 'linear'
        K2=Ker_Linear(XX,XX);
    case 'ploynomial'
        K2=Ker_Polynomial(XX,XX);
    case 'RBF'
        K2=Ker_RBF(XX,XX);
    case 'Sigmoid'
        Kerr=Ker_Sigmoid(X_l,X_u);
end

switch kl3
    case 'linear'
        K3=Ker_Linear(XX,XX);
    case 'ploynomial'
        K3=Ker_Polynomial(XX,XX);
    case 'RBF'
        K3=Ker_RBF(XX,XX);
   case 'Sigmoid'
        Kerr=Ker_Sigmoid(X_l,X_u);
end
H1=Kernel_Embedding(Y,Y).*Ker1;
H2=Kernel_Embedding(Y,Y).*Ker2;
H3=Kernel_Embedding(Y,Y).*Ker3;

T=length(Y);
e=ones(T,1);
I=eye(T,T);
tau=1/C1;
cvx_begin sdp
variable mu(3);

variable nu(T);
variable del(T);
variable lambda;
variable t;

minimize(t);

trace(mu(1)*K1+mu(2)*K2+mu(3)*K3) == c;
mu(1)*K1+mu(2)*K2+mu(3)*K3 >=0;
nu>=0;
del>=0;
[(mu(1)*Ker1+mu(2)*Ker2+mu(3)*Ker3)+tau*I     e-nu-del+lambda*Y;
 (e-nu-del+lambda*Y).'                  t-(2*C1*del.'*e)  
                                                             ] >=0;

  

cvx_end


alpha=0;
BB=0;
return










