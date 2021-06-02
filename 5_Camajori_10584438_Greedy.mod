#------------------------------------------------------
# Auxiliary data for the greedy algorithm
#------------------------------------------------------

# Set of opened facilities in the current solution
set Y within N;

# Set of pair demand-facility_destination in the solution
set Z within {D,N};

# Set of arc-demands in the solution
set X within {A,D};



# Set of Closes Facilities
set Y_closed := N diff Y;

# Set of covered Demands
set D_covered := setof{(k,i) in Z} k;

# Set of Uncovered Demands
set D_uncovered := D diff D_covered;

# Auxiliary Set of Destinations 
set Dest within N ordered;

# Set of spare capacity for each node
param C_spare{N};

# Set of spare capacity for each arc
param C_spare_arc{A} default uu;

