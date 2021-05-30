
# Import parameters
model parameterDefinition.mod;


## Randomized Rounding parameters and sets
# Set of opened facilities yi
set CY within N; 

# Set of partially open facilities with 0 < yi < 1
set PY within N ordered;


#--------------------------------------------------
#                CR relaxed problem
#--------------------------------------------------

# Routing variables
# xijk = 1 if arc (i,j) is used by demand k
var x{A,D} binary;

# Activation variables
# yi = 1 if facility is open in node i 
var y_CR{N} >=0, <=1;

# variables
# zki = 1 if demand k is assigned to facility i
var z_CR{D,N} >=0, <=1;

# Objective function: minimize total cost
minimize Cost_CR:
	sum {i in N} c[i]*y_CR[i] + sum {k in D, (i,j) in A} x[i,j,k]*g[i,j];

# load_balance constraints 
subject to load_balance_CR {i in N, k in D}:
	sum{(j,i) in A} x[j,i,k] - sum{(i,j) in A} x[i,j,k] = 
				(if i = o[k] then -1
				else z_CR[k,i]);

# node_capacity constraints
subject to node_capacity_CR {i in N}:
	sum {k in D} z_CR[k,i]*d[k] <= cap[i]*y_CR[i];

# arc_capacity constraints
subject to arc_capacity_CR {(i,j) in A}:
	sum {k in D} x[i,j,k]*d[k] <= uu;

# demand_assignement constraints
subject to demand_assignement_CR {k in D}:
	sum {i in N} z_CR[k,i] = 1;




