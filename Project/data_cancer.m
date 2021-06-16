
T= readtable('data.csv');
T=table2array(T);

input=T(:,4:33);



input=normalize(input);
output= T(:,3);

