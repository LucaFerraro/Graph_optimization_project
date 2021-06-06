
# Import parameters
model parameterDefinition.mod;


#--------------------------------------------------
#                Lagrangian Relaxation problem
#--------------------------------------------------

### Parameters of the relaxations
# Lagrangian relaxation multipliers 
param lambda{N} default -100000;
param lambda_old{N} default 1;

# step for updating multipliers
param t default 1;


# Routing variables
# xijk = 1 if arc (i,j) is used by demand k
var x{A,D} binary;

# Activation variables
# yi = 1 if facility is open in node i 
var y{N} binary;

# variables
# zki = 1 if demand k is assigned to facility i
var z{D,N} binary;

# Objective function: minimize total cost
minimize LR_objective_lambda:
	sum {i in N} c[i]*y[i] + sum {k in D, (i,j) in A} x[i,j,k]*g[i,j] + sum {i in N}(lambda[i] *  sum {k in D}(z[k,i]*d[k] - y[i]*cap[i]));

# load_balance constraints 
subject to load_balance {i in N, k in D}:
	sum{(j,i) in A} x[j,i,k] - sum{(i,j) in A} x[i,j,k] = 
				(if i = o[k] then -1
				else z[k,i]);

# arc_capacity constraints
subject to arc_capacity {(i,j) in A}:
	sum {k in D} x[i,j,k]*d[k] <= uu;








