$title Random test for Capacitated Vehicle Routing Problem

Set
   i    'nodes'      /depot, K1*K10/
   k    'vehicles'   /T1*T6/;

Alias(i,j);

Parameter    
   a(k) 'capacity vehicle k'
        /T1 100
         T2 100
         T3 100
         T4 100
         T5 100
         T6 100/

   b(i) 'demand node i'
        /Depot 0
         K1    40
         K2    56
         K3    64
         K4    11
         K5    92
         K6    38
         K7    53
         K8    64
         K9    5
         K10   75/;
         
Table c(i,j) 'transport cost matrix'
          depot   K1       K2     K3      K4      K5      K6      K7      K8      K9      K10 
depot     99.00   8.077   6.542   2.750   1.341   3.568   5.447   2.363   1.229   4.843   6.451
K1        8.077   99.00   1.559   7.236   7.519   8.596   9.600   8.698   8.488   10.359  12.075
K2        6.542   1.559   99.00   5.710   5.960   7.104   8.542   7.312   7.014   8.888   10.628
K3        2.750   7.236   5.710   99.00   1.410   1.509   7.961   5.035   3.961   3.312   5.105
K4        1.341   7.519   5.960   1.410   99.00   2.419   6.635   3.643   2.553   3.964   5.701
K5        3.568   8.596   7.104   1.509   2.419   99.00   9.003   5.929   4.779   1.812   3.601
K6        5.447   9.600   8.542   7.961   6.635   9.003   99.00   3.135   4.288   10.234  11.715
K7        2.363   8.698   7.312   5.035   3.643   5.929   3.135   99.00   1.160   7.100   8.591
K8        1.229   8.488   7.014   3.961   2.553   4.779   4.288   1.160   99.00   5.946   7.464
K9        4.843   10.359  8.888   3.312   3.964   1.812   10.234  7.100   5.946   99.00   1.794
K10       6.451   12.075  10.628  5.105   5.701   3.601   11.715  8.591   7.464   1.794   99.00
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