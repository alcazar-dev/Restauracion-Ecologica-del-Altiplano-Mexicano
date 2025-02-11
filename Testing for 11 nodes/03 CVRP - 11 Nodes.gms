$title Random test for Capacitated Vehicle Routing Problem

Set
   i    'nodes'      /depot, K1*K10/
   k    'vehicles'   /T1*T7/;

Alias(i,j);

Parameter    
   a(k) 'capacity vehicle k'
        /T1 100
         T2 100
         T3 100
         T4 100
         T5 100
         T6 100
         T7 100/

   b(i) 'demand node i'
        /Depot  0
K1  79
K2  65
K3  62
K4  35
K5  14
K6  77
K7  74
K8  75
K9  93
K10 25

         /;
         
Table c(i,j) 'transport cost matrix'
        depot   K1   K2   K3   K4   K5   K6   K7   K8   K9   K10
depot   9999    139  392  812  880  247  573  478  787  815  911
K1      198     9999 564  713  610  723  119  626  542  690  481
K2      739     972  9999 660  873  544  503  280  159  971  209
K3      939     227  484  9999 257  198  264  624  954  607  231
K4      890     496  711  618  9999 378  688  286  485  165  150
K5      693     162  291  162  959  9999 269  403  381  178  634
K6      738     205  976  933  698  769  9999 765  795  162  196
K7      965     737  568  905  762  840  439  9999 438  641  780
K8      817     549  270  229  968  182  899  427  9999 151  997
K9      705     374  476  845  290  788  718  172  665  9999 778
K10     216     404  606  897  846  470  832  544  142  584  9999
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