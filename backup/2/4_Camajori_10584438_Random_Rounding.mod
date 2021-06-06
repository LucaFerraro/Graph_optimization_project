
# Import parameters
model parameterDefinition.mod;


## Randomized Rounding parameters and sets
# Set of fixed variables xijk, zki
set CX within {A,D}; 
set CZ within {D,N}; 


# Set of fractionary variables xijk, zki
# set PX within {A,D};
# set PZ within {D,N};
set PI within {N} ordered;
set PJ within {N} ordered;
set PD within {D} ordered;



#--------------------------------------------------
#                CR relaxed problem
#--------------------------------------------------

# Routing variables
# xijk = 1 if arc (i,j) is used by demand k
var x_CR{A,D} binary;

# Activation variables
# yi = 1 if facility is open in node i 
var y_CR{N} >=0, <=1;

# variables
# zki = 1 if demand k is assigned to facility i
var z_CR{D,N} >=0, <=1;

# Objective function: minimize total cost
minimize Cost_CR:
	sum {i in N} c[i]*y_CR[i] + sum {k in D, (i,j) in A} x_CR[i,j,k]*g[i,j];

# load_balance constraints 
subject to load_balance_CR {i in N, k in D}:
	sum{(j,i) in A} x_CR[j,i,k] - sum{(i,j) in A} x_CR[i,j,k] = 
				(if i = o[k] then -1
				else z_CR[k,i]);

# node_capacity constraints
subject to node_capacity_CR {i in N}:
	sum {k in D} z_CR[k,i]*d[k] <= cap[i]*y_CR[i];

# arc_capacity constraints
subject to arc_capacity_CR {(i,j) in A}:
	sum {k in D} x_CR[i,j,k]*d[k] <= uu;

# consistency_Z_Y constraints
subject to consistency_Z_Y_CR {i in N, k in D}:
	z_CR[k,i] <= y_CR[i];



