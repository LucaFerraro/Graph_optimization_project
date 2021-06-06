# shortest paths model
var x_SPT{A} >= 0;


#objective
minimize SPTCost: sum{(i,j) in A} g[i,j]*x_SPT[i,j];


#constraints
subject to balance{i in N, k in D_uncovered}:
	sum{(i,j) in A} x[i,j] - sum{ (k,i) in A} x_SPT[k,i] = 
				(if i = o[k] then nb_n-1
				else -1);