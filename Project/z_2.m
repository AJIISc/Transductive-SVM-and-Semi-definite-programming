function fx=z_2(X_l,X_u,beta,beta0)
global C2 
N_l=size(X_l,1);
N_u=size(X_u,1);
N=N_l+N_u;
X=[X_l;X_u];
fx=0;
for j=N_l+1:N
    fx=fx+C2*(abs((X(j,:)*beta*beta0))-1);
end

return