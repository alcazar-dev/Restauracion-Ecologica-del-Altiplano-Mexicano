$title Random test for Capacitated Vehicle Routing Problem

Set
   i    'nodes'      /depot, K1*K10/
   k    'vehicles'   /T1*T5/;

Alias(i,j);

Parameter    
   a(k) 'capacity vehicle k'
        /T1 100
         T2 100
         T3 100
         T4 100
         T5 100/

   b(i) 'demand node i'
        /Depot  0
K1  85
K2  12
K3  46
K4  13
K5  6
K6  83
K7  6
K8  70
K9  69
K10 25
         /;
         
Table c(i,j) 'transport cost matrix'
        depot   K1   K2   K3   K4   K5   K6   K7   K8   K9   K10
depot   9999    378  527  599  363  183  410  446  122  174  595
K1      111     9999 217  390  927  220  418  975  861  764  136
K2      739     168  9999 238  378  914  854  257  316  968  878
K3      834     538  176  9999 727  517  246  817  158  132  276
K4      428     357  465  893  9999 842  427  196  521  191  121
K5      869     436  424  902  496  9999 815  997  863  643  776
K6      649     988  747  849  735  929  9999 819  758  360  707
K7      779     161  604  482  314  459  259  9999 741  907  117
K8      355     611  828  738  534  400  314  524  9999 494  955
K9      489     246  698  566  667  188  673  493  163  9999 627
K10     727     129  739  979  656  774  745  633  890  395  9999
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