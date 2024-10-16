$title Random test for Capacitated Vehicle Routing Problem

Set
   i    'nodes'      /depot, K1*K15/
   k    'vehicles'   /T1*T4/;

Alias(i,j);

Parameter
   a(k) 'capacity of transport vehicle k'
        /T1 15
         T2 15
         T3 15
         T4 15/

   b(i) 'demand of node i'
        /Depot 0
         K1    1
         K2    1
         K3    2
         K4    4
         K5    2
         K6    4
         K7    8
         K8    8
         K9    1
         K10   2
         K11   1
         K12   2
         K13   4
         K14   4
         K15   8/;

Table c(i,j) 'transport costs direct connection node i to node j'
        depot    K1       K2       K3       K4       K5       K6       K7       K8       K9       K10      K11      K12      K13      K14      K15
depot   99.99    5.92     7.59     4.09     6.77     9.99     4.70     8.72     7.96     7.14     8.86     9.51     4.87     5.74     9.37     4.72
K1      5.92     99.99    8.48     4.99     5.77     5.47     8.23     6.88     6.65     9.44     9.43     6.44     5.51     9.10     8.59     5.83
K2      7.59     8.48     99.99    4.53     9.50     8.88     6.73     7.35     7.88     4.42     8.42     9.43     6.57     7.21     4.57     6.91
K3      4.09     4.99     4.53     99.99    7.98     9.65     4.84     6.03     7.24     4.47     5.31     5.80     5.43     6.27     7.73     9.60
K4      6.77     5.77     9.50     7.98     99.99    5.97     6.56     6.92     7.87     9.54     7.68     6.01     7.83     9.12     7.70     9.55
K5      9.99     5.47     8.88     9.65     5.97     99.99    5.23     9.94     5.48     6.09     9.62     8.11     4.41     4.58     4.36     4.86
K6      4.70     8.23     6.73     4.84     6.56     5.23     99.99    6.75     5.74     9.54     7.71     5.84     8.44     8.88     9.89     6.86
K7      8.72     6.88     7.35     6.03     6.92     9.94     6.75     99.99    8.10     8.50     6.48     5.80     7.23     6.60     5.39     9.98
K8      7.96     6.65     7.88     7.24     7.87     5.48     5.74     8.10     99.99    9.95     6.28     9.07     5.21     7.26     8.69     6.87
K9      7.14     9.44     4.42     4.47     9.54     6.09     9.54     8.50     9.95     99.99    7.49     5.29     6.16     7.81     4.24     4.67
K10     8.86     9.43     8.42     5.31     7.68     9.62     7.71     6.48     6.28     7.49     99.99    7.07     5.74     5.48     9.41     9.79
K11     9.51     6.44     9.43     5.80     6.01     8.11     5.84     5.80     9.07     5.29     7.07     99.99    4.88     4.33     6.32     4.36
K12     4.87     5.51     6.57     5.43     7.83     4.41     8.44     7.23     5.21     6.16     5.74     4.88     99.99    7.47     5.68     5.76
K13     5.74     9.10     7.21     6.27     9.12     4.58     8.88     6.60     7.26     7.81     5.48     4.33     7.47     99.99    9.56     7.22
K14     9.37     8.59     4.57     7.73     7.70     4.36     9.89     5.39     8.69     4.24     9.41     6.32     5.68     9.56     99.99    7.29
K15     4.72     5.83     6.91     9.60     9.55     4.86     6.86     9.98     6.87     4.67     9.79     4.36     5.76     7.22     7.29     99.99
;

Binary Variables
   x(i,j,k) '1 if transport vehicle k drives directly from node i to node j, otherwise 0'
   y(i,k)   '1 if customer i is fully supplied by transport vehicle k, otherwise 0';
   
Integer Variable
    u(i,k)  'Additional variable for subtour elimination';
    
Variables
    Z      'target value as total sum of transport costs';

Equations
    target_function                     'target function'
    demand_capa_constr(k)               'demands assigned to a transport vehicle correspond to max. vehicle capacity'
    depot_constr(i)                     'tours include depot as start and end'
    cust_vehicle_constr(i)              'customer is assigned to exactly one transport vehicle'
    node_after_constr(i,k)              'each node has one node afterwards'
    node_before_const(j,k)              'each node has one node before'
    subtour_elimination_constr(i,j,k)   'avoid subtours without depot'
    lower_bound_subtour_constr(i,k)     'lower bound to avoid subtours without depot'   
    upper_bound_subtour_constr(i,k)     'upper bound to avoid subtours without depot';
      
target_function..                                                                                       Z =e= sum((i,j,k), c(i,j)*x(i,j,k))+sum(i,b(i)/a('T1')*30);
demand_capa_constr(k)..                                                                                 sum(i, b(i)*y(i,k)) =l= a(k);
depot_constr(i)$((ord(i)=1))..                                                                          sum(k, y(i,k)) =e= card(k);
cust_vehicle_constr(i)$((ord(i)<>1))..                                                                  sum(k, y(i,k)) =e= 1;
node_after_constr(i,k)..                                                                                sum(j, x(i,j,k)) =e= y(i,k);
node_before_const(j,k)..                                                                                sum(i, x(i,j,k)) =e= y(j,k);
subtour_elimination_constr(i,j,k)$(not sameAs(i,j)and(ord(i)<>1)and(ord(j)<>1)and(b(i)+b(j)<=a(k)))..   u(i,k)-u(j,k)+a(k)*x(i,j,k) =l= a(k)-b(j);             
lower_bound_subtour_constr(i,k)..                                                                       b(i)=l=u(i,k);
upper_bound_subtour_constr(i,k)..                                                                       u(i,k)=l=a(k) ;

Model CVRP /all/;

Solve CVRP using MIP minimizing Z;