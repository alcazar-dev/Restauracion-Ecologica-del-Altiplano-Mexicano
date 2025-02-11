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
        /Depot  0
K1  55
K2  54
K3  71
K4  66
K5  19
K6  37
K7  25
K8  35
K9  86
K10 32

         /;
         
Table c(i,j) 'transport cost matrix'
        depot   K1   K2   K3   K4   K5   K6   K7   K8   K9   K10
depot   9999    518  632  654  818  982  219  280  488  330  396
K1      129     9999 330  219  682  109  202  260  893  626  805
K2      410     810  9999 749  487  705  514  884  807  786  433
K3      466     175  446  9999 961  389  732  262  214  623  171
K4      702     196  376  422  9999 210  740  941  396  135  452
K5      495     198  588  587  295  9999 293  233  364  865  353
K6      895     150  144  789  936  796  9999 546  826  138  856
K7      830     811  854  964  769  930  436  9999 478  950  582
K8      745     564  704  921  653  254  338  595  9999 566  913
K9      854     800  454  731  939  959  855  144  384  9999 261
K10     109     328  114  693  871  718  762  669  656  388  9999 
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