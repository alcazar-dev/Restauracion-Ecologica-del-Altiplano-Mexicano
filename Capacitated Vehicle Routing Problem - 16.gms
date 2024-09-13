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
        depot   K1      K2      K3      K4      K5      K6      K7      K8      K9      K10     K11     K12     K13     K14     K15
depot   9999    592     759     409     677     999     470     872     796     714     886     951     487     574     937     472
K1      592     9999    848     499     577     547     823     688     665     944     943     644     551     910     859     583
K2      759     848     9999    453     950     888     673     735     788     442     842     943     657     721     457     691
K3      409     499     453     9999    798     965     484     603     724     447     531     580     543     627     773     960
K4      677     577     950     798     9999    597     656     692     787     954     768     601     783     912     770     955
K5      999     547     888     965     597     9999    523     994     548     609     962     811     441     458     436     486
K6      470     823     673     484     656     523     9999    675     574     954     771     584     844     888     989     686
K7      872     688     735     603     692     994     675     9999    810     850     648     580     723     660     539     998
K8      796     665     788     724     787     548     574     810     9999    995     628     907     521     726     869     687
K9      714     944     442     447     954     609     954     850     995     9999    749     529     616     781     424     467
K10     886     943     842     531     768     962     771     648     628     749     9999    707     574     548     941     979
K11     951     644     943     580     601     811     584     580     907     529     707     9999    488     433     632     436
K12     487     551     657     543     783     441     844     723     521     616     574     488     9999    747     568     576
K13     574     910     721     627     912     458     888     660     726     781     548     433     747     9999    956     722
K14     937     859     457     773     770     436     989     539     869     424     941     632     568     956     9999    729
K15     472     583     691     960     955     486     686     998     687     467     979     436     576     722     729     9999;

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
      
target_function..                                                                                       Z =e= sum((i,j,k), c(i,j)*x(i,j,k));
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