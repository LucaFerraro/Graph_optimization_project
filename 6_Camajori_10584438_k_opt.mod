#--------------------------------------------------
#                k_opt problem
#--------------------------------------------------

# Routing variables
# xijk = 1 if arc (i,j) is used by demand k
var x_kopt{A,D} binary;

# Activation variables
# yi = 1 if facility is open in node i 
var y_kopt{N} binary;

# variables
# zki = 1 if demand k is assigned to facility i
var z_kopt{D,N} binary;

# Objective function: minimize total cost
minimize Cost_kopt:
	sum {i in N} c[i]*y_kopt[i] + sum {k in D, (i,j) in A} x_kopt[i,j,k]*g[i,j];

# load_balance constraints 
subject to load_balance_kopt {i in N, k in D}:
	sum{(j,i) in A} x_kopt[j,i,k] - sum{(i,j) in A} x_kopt[i,j,k] = 
				(if i = o[k] then -1
				else z_kopt[k,i]);

# node_capacity constraints
subject to node_capacity_kopt {i in N}:
	sum {k in D} z_kopt[k,i]*d[k] <= cap[i]*y_kopt[i];

# arc_capacity constraints
subject to arc_capacity_kopt {(i,j) in A}:
	sum {k in D} x_kopt[i,j,k]*d[k] <= uu;

# k-opt constraint
s.t. k_opt_constraint: 
 sum{i in N diff Y} y_kopt[i]                   + sum{i in Y}(1-y_kopt[i])            + 
 sum{(i,j,k) in A cross D diff X} x_kopt[i,j,k] + sum{(i,j,k) in X} (1-x_kopt[i,j,k]) + 
 sum{(k,i) in D cross N diff Z} z_kopt[k,i]     + sum{(k,i) in Z} (1-z_kopt[k,i])
 <= k_param;











