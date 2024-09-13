$title Random test for Capacitated Vehicle Routing Problem

Set
   i    'nodes'      /depot, K1*K20/
   k    'vehicles'   /T1*T7/;

Alias(i,j);
Parameter
   a(k) 'capacity of transport vehicle k'
        /T1 15
         T2 15
         T3 15
         T4 15
         T5 15
         T6 15
         T7 15/

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
        depot   K1      K2      K3      K4      K5      K6      K7      K8      K9      K10     K11     K12     K13     K14     K15     K16     K17     K18     K19     K20
depot   9999    487     413     714     993     520     681     826     870     684     676     724     934     627     995     973     917     656     536     607     863
K1      487     9999    823     748     682     986     833     619     773     690     963     837     908     849     726     890     453     494     459     736     563
K2      413     823     9999    700     950     413     934     904     609     855     868     873     972     800     456     680     404     705     743     942     966
K3      714     748     700     9999    811     429     771     902     407     537     776     548     659     526     977     932     724     512     637     760     955
K4      993     682     950     811     9999    739     674     769     626     625     628     769     528     424     692     755     534     403     626     844     817
K5      520     986     413     429     739     9999    597     472     646     535     613     875     723     502     727     995     623     656     747     507     919
K6      681     833     934     771     674     597     9999    489     474     899     743     496     682     432     515     854     828     573     532     841     493
K7      826     619     904     902     769     472     489     9999    898     605     814     765     819     985     618     938     774     422     860     754     451
K8      870     773     609     407     626     646     474     898     9999    569     566     709     994     791     620     514     734     619     646     500     815
K9      684     690     855     537     625     535     899     605     569     9999    721     848     690     403     638     571     982     779     509     729     500
K10     676     963     868     776     628     613     743     814     566     721     9999    800     553     519     785     789     796     746     986     478     984
K11     724     837     873     548     769     875     496     765     709     848     800     9999    417     847     750     725     824     564     970     577     839
K12     934     908     972     659     528     723     682     819     994     690     553     417     9999    964     976     732     985     546     448     476     693
K13     627     849     800     526     424     502     432     985     791     403     519     847     964     9999    932     608     442     898     428     810     580
K14     995     726     456     977     692     727     515     618     620     638     785     750     976     932     9999    706     744     610     984     674     809
K15     973     890     680     932     755     995     854     938     514     571     789     725     732     608     706     9999    625     518     945     551     438
K16     917     453     404     724     534     623     828     774     734     982     796     824     985     442     744     625     9999    732     959     988     520
K17     656     494     705     512     403     656     573     422     619     779     746     564     546     898     610     518     732     9999    608     688     462
K18     536     459     743     637     626     747     532     860     646     509     986     970     448     428     984     945     959     608     9999     973    723
K19     607     736     942     760     844     507     841     754     500     729     478     577     476     810     674     551     988     688     973     9999    555
K20     863     563     966     955     817     919     493     451     815     500     984     839     693     580     809     438     520     462     723     555     9999

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