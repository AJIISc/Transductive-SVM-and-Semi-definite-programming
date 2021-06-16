
T= readtable('sonar.csv');
T=table2array(T);

input=T(:,2:61);



input=normalize(input);
output= T(:,62);

