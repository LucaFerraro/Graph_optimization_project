# Source of SP
param s;
param dst;
param demand;

# shortest paths model
var x_SP{A} >= 0;

#objective
minimize SPCost: sum{(i,j) in A} g[i,j]*x_SP[i,j];

#constraints
subject to balance{i in N}:
	sum{(i,j) in A} x_SP[i,j] - sum{ (j,i) in A} x_SP[j,i] = 
				(if i = s then 1
				else if i == dst then -1
				else 0);
