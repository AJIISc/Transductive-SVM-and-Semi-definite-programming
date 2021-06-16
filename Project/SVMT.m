
function [alpha,Ker,BB]=SVMT(X,Y,kernel)
global  tol C1

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

H=Kernel_Embedding(Y,Y).*Ker;
f=-1*ones(size(X,1),1);
Aeq=Y';
beq=0;
A_1=diag(ones(size(X,1),1));
A_2=diag(-1*ones(size(X,1),1));
A=[A_1
    A_2];
b_1=repmat(C1,size(X,1),1);
b_2=zeros(size(X,1),1);

b=[b_1
    b_2];
alpha=quadprog(H,f,A,b,Aeq,beq);



index=(1:size(X,1))';
sv=index(alpha>tol&alpha<C1);

temp_b=0;
for i=1:size(sv,1)
    temp_b=temp_b+Y(sv(i));
    temp_b=temp_b-sum(alpha(sv(i))*Y(sv(i))*Ker(sv,sv(i)));
end
BB=temp_b/size(sv,1);

alpha(alpha>C1-0.0000001) =0;

return










