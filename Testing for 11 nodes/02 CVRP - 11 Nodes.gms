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
K1  52
K2  52
K3  11
K4  54
K5  23
K6  31
K7  10
K8  30
K9  62
K10 66
         /;
         
Table c(i,j) 'transport cost matrix'
        depot   K1   K2   K3   K4   K5   K6   K7   K8   K9   K10
depot   9999    754  214  125  859  381  350  328  242  854  204
K1      792     9999 858  658  189  704  532  132  130  195  323
K2      338     617  9999 716  127  674  303  833  765  818  658
K3      529     325  559  9999 703  384  928  990  106  877  925
K4      263     814  532  448  9999 384  259  320  881  444  204
K5      194     489  199  467  967  9999 452  718  370  926  144
K6      847     570  649  227  487  180  9999 665  400  949  743
K7      733     982  470  691  296  821  171  9999 146  777  333
K8      891     396  181  975  338  987  203  489  9999 384  564
K9      750     954  473  266  479  463  314  786  373  9999 818
K10     799     763  173  723  750  275  646  846  350  267  9999

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