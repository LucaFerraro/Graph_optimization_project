# Nodes
param nb_n; #number of nodes
set N := 1..nb_n; # nodes

# Arcs
set A within N cross N;
param uu; #arc capacity

# Requests
param nb_d; # number of requests
set D := 1..nb_d; # requests
param o{D} symbolic in N; # origin of each request
param d{D}; # amount of demand of each request
param c{N} default 1;
param g{A} default 0;
param cap{N} default 100000;