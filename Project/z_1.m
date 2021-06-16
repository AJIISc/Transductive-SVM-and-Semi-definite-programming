function fx=z_1(X_l,X_u,Y,Weight,BB)
global C1 C2 
N_l=size(X_l,1);
N_u=size(X_u,1);
N=N_l+N_u;
X=[X_l;X_u];
fx1=0;fx2=0;
for i=1:N_l
    fx1=fx1+C1*(max(1-(Y(i)*(X(i,:)*Weight*BB)),0));
end
for j=N_l+1:N
    fx2=fx2+C2*max(abs((X(j,:)*Weight*BB)),0);
end
fx=fx1+fx2+0.5*norm(Weight)^2;
return