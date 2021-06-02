# Source of SP
param s_SP;
param dst_SP;
param demand_SP;
param arc_cap_SP{A};

# shortest paths model
var x_SP{A} >= 0;

#objective
minimize SPCost: sum{(i,j) in A} g[i,j]*x_SP[i,j];

# FLow balance constraint:
subject to balance{i in N}:
	sum{(i,j) in A} x_SP[i,j] - sum{ (j,i) in A} x_SP[j,i] = 
				(if i = s_SP then 1
				else if i == dst_SP then -1
				else 0);
				
# Arc capacity constraint:		
subject to arc_capacity{(i,j) in A}:
	x_SP[i,j]*demand_SP <= arc_cap_SP[i,j];