
# Import parameters
model parameterDefinition.mod;


# Current total number of cover inequalities
param nc default 0;

# Set of arcs for which we have added a cut
set C within A default {};

# Set of demands composing each cover
set K_star{C} within D;


#--------------------------------------------------
#                CR relaxed problem
#--------------------------------------------------

# Routing variables
# xijk = 1 if arc (i,j) is used by demand k
var x_CR{A,D} >=0, <=1;

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

# Constraints for each cover inequality
subject to VI {(i,j) in C}:
	sum {k in K_star[i,j]} x_CR[i,j,k] <= card(K_star[i,j])-1;


#--------------------------------------------------
#                 Separation problem
#--------------------------------------------------

# The separation problem looks for a cover inequality
# violated by the current LP solution

# Fractional solution of current LP
param x_star{D} >= 0, <= 1;

# Binary variable for item in the cover
var u{D} binary;

# Objective function: Find the most violated cover inequality
minimize Violation: 
	sum {k in D} (1 - x_star[k])*u[k];

# Cover condition constraint
subject to CoverCondition:
	sum {k in D} d[k]*u[k] >= uu+1;
	
	
	
	
