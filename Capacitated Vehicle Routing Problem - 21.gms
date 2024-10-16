$title Random test for Capacitated Vehicle Routing Problem

Set
   i    'nodes'      /depot, K1*K20/
   k    'vehicles'   /T1*T6/;

Alias(i,j);
Parameter
   a(k) 'capacity of transport vehicle k'
        /T1 15
         T2 15
         T3 15
         T4 15
         T5 15
         T6 15/

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
         K15   8
         K16   8
         K17   7
         K18   6
         K19   5
         K20   8/;

Table c(i,j) 'transport costs direct connection node i to node j'
        depot     K1        K2        K3        K4        K5        K6        K7        K8        K9        K10       K11       K12       K13       K14       K15       K16       K17       K18       K19       K20
depot   99.99     4.87      4.13      7.14      9.93      5.20      6.81      8.26      8.70      6.84      6.76      7.24      9.34      6.27      9.95      9.73      9.17      6.56      5.36      6.07      8.63
K1      4.87      99.99     8.23      7.48      6.82      9.86      8.33      6.19      7.73      6.90      9.63      8.37      9.08      8.49      7.26      8.90      4.53      4.94      4.59      7.36      5.63
K2      4.13      8.23      99.99     7.00      9.50      4.13      9.34      9.04      6.09      8.55      8.68      8.73      9.72      8.00      4.56      6.80      4.04      7.05      7.43      9.42      9.66
K3      7.14      7.48      7.00      99.99     8.11      4.29      7.71      9.02      4.07      5.37      7.76      5.48      6.59      5.26      9.77      9.32      7.24      5.12      6.37      7.60      9.55
K4      9.93      6.82      9.50      8.11      99.99     7.39      6.74      7.69      6.26      6.25      6.28      7.69      5.28      4.24      6.92      7.55      5.34      4.03      6.26      8.44      8.17
K5      5.20      9.86      4.13      4.29      7.39      99.99     5.97      4.72      6.46      5.35      6.13      8.75      7.23      5.02      7.27      9.95      6.23      6.56      7.47      5.07      9.19
K6      6.81      8.33      9.34      7.71      6.74      5.97      99.99     4.89      4.74      8.99      7.43      4.96      6.82      4.32      5.15      8.54      8.28      5.73      5.32      8.41      4.93
K7      8.26      6.19      9.04      9.02      7.69      4.72      4.89      99.99     8.98      6.05      8.14      7.65      8.19      9.85      6.18      9.38      7.74      4.22      8.60      7.54      4.51
K8      8.70      7.73      6.09      4.07      6.26      6.46      4.74      8.98      99.99     5.69      5.66      7.09      9.94      7.91      6.20      5.14      7.34      6.19      6.46      5.00      8.15
K9      6.84      6.90      8.55      5.37      6.25      5.35      8.99      6.05      5.69      99.99     7.21      8.48      6.90      4.03      6.38      5.71      9.82      7.79      5.09      7.29      5.00
K10     6.76      9.63      8.68      7.76      6.28      6.13      7.43      8.14      5.66      7.21      99.99     8.00      5.53      5.19      7.85      7.89      7.96      7.46      9.86      4.78      9.84
K11     7.24      8.37      8.73      5.48      7.69      8.75      4.96      7.65      7.09      8.48      8.00      99.99     4.17      8.47      7.50      7.25      8.24      5.64      9.70      5.77      8.39
K12     9.34      9.08      9.72      6.59      5.28      7.23      6.82      8.19      9.94      6.90      5.53      4.17      99.99     9.64      9.76      7.32      9.85      5.46      4.48      4.76      6.93
K13     6.27      8.49      8.00      5.26      4.24      5.02      4.32      9.85      7.91      4.03      5.19      8.47      9.64      99.99     9.32      6.08      4.42      8.98      4.28      8.10      5.80
K14     9.95      7.26      4.56      9.77      6.92      7.27      5.15      6.18      6.20      6.38      7.85      7.50      9.76      9.32      99.99     7.06      7.44      6.10      9.84      6.74      8.09
K15     9.73      8.90      6.80      9.32      7.55      9.95      8.54      9.38      5.14      5.71      7.89      7.25      7.32      6.08      7.06      99.99     6.25      5.18      9.45      5.51      4.38
K16     9.17      4.53      4.04      7.24      5.34      6.23      8.28      7.74      7.34      9.82      7.96      8.24      9.85      4.42      7.44      6.25      99.99     7.32      9.59      9.88      5.20
K17     6.56      4.94      7.05      5.12      4.03      6.56      5.73      4.22      6.19      7.79      7.46      5.64      5.46      8.98      6.10      5.18      7.32      99.99     6.08      6.88      4.62
K18     5.36      4.59      7.43      6.37      6.26      7.47      5.32      8.60      6.46      5.09      9.86      9.70      4.48      4.28      9.84      9.45      9.59      6.08      99.99     9.73      7.23
K19     6.07      7.36      9.42      7.60      8.44      5.07      8.41      7.54      5.00      7.29      4.78      5.77      4.76      8.10      6.74      5.51      9.88      6.88      9.73      99.99     5.55
K20     8.63      5.63      9.66      9.55      8.17      9.19      4.93      4.51      8.15      5.00      9.84      8.39      6.93      5.80      8.09      4.38      5.20      4.62      7.23      5.55      99.99
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