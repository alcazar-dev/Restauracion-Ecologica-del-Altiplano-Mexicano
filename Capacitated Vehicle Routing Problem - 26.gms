option iterlim = 1000;

$title Random test for Capacitated Vehicle Routing Problem
Set
   i    'nodes'      /depot, K1*K25/
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
         K16   1
         K17   1
         K18   2
         K19   4
         K20   2
         K21   4
         K22   8
         K23   8
         K24   1
         K25   2 /;

Table c(i,j) 'transport costs direct connection node i to node j'
        depot  K1     K2     K3     K4     K5     K6     K7     K8     K9     K10    K11    K12    K13    K14    K15    K16    K17    K18    K19    K20    K21    K22    K23    K24    K25
depot   99.99  5.92   7.59   4.09   6.77   9.99   4.70   8.72   7.96   7.14   8.86   9.51   4.87   5.74   9.37   4.72   4.11   6.42   8.03   1.99   5.25   9.60   6.00   3.38   5.10   2.22
K1      5.92   99.99  8.48   4.99   5.77   5.47   8.23   6.88   6.65   9.44   9.43   6.44   5.51   9.10   8.59   5.83   1.25   6.97   7.66   2.48   7.45   9.17   5.35   6.01   1.99   4.83
K2      7.59   8.48   99.99  4.53   9.50   8.88   6.73   7.35   7.88   4.42   8.42   9.43   6.57   7.21   4.57   6.91   9.68   5.92   3.30   5.66   7.58   1.03   3.11   8.00   7.06   4.21
K3      4.09   4.99   4.53   99.99  7.98   9.65   4.84   6.03   7.24   4.47   5.31   5.80   5.43   6.27   7.73   9.60   3.05   1.86   4.80   8.99   3.42   2.84   4.29   2.06   2.98   1.12
K4      6.77   5.77   9.50   7.98   99.99  5.97   6.56   6.92   7.87   9.54   7.68   6.01   7.83   9.12   7.70   9.55   3.34   6.96   2.83   9.37   6.53   6.79   7.19   1.87   5.52   8.81
K5      9.99   5.47   8.88   9.65   5.97   99.99  5.23   9.94   5.48   6.09   9.62   8.11   4.41   4.58   4.36   4.86   2.83   7.71   6.70   3.52   8.94   4.89   5.12   8.27   7.56   6.30
K6      4.70   8.23   6.73   4.84   6.56   5.23   99.99  6.75   5.74   9.54   7.71   5.84   8.44   8.88   9.89   6.86   5.82   7.15   4.29   6.67   2.18   7.03   5.25   6.63   1.40   2.41
K7      8.72   6.88   7.35   6.03   6.92   9.94   6.75   99.99  8.10   8.50   6.48   5.80   7.23   6.60   5.39   9.98   4.77   8.63   4.17   9.31   6.24   8.18   3.96   8.17   6.88   7.31
K8      7.96   6.65   7.88   7.24   7.87   5.48   5.74   8.10   99.99  9.95   6.28   9.07   5.21   7.26   8.69   6.87   2.79   8.79   7.78   4.31   9.47   5.87   6.88   7.47   5.62   1.77
K9      7.14   9.44   4.42   4.47   9.54   6.09   9.54   8.50   9.95   99.99  7.49   5.29   6.16   7.81   4.24   4.67   7.88   1.23   2.13   6.01   6.70   7.45   6.55   5.45   8.87   5.01
K10     8.86   9.43   8.42   5.31   7.68   9.62   7.71   6.48   6.28   7.49   99.99  7.07   5.74   5.48   9.41   9.79   8.25   7.42   5.34   8.82   4.16   6.14   2.10   4.71   8.76   2.35
K11     9.51   6.44   9.43   5.80   6.01   8.11   5.84   5.80   9.07   5.29   7.07   99.99  4.88   4.33   6.32   4.36   2.75   7.15   1.77   7.93   2.98   8.65   2.86   3.42   6.64   4.09
K12     4.87   5.51   6.57   5.43   7.83   4.41   8.44   7.23   5.21   6.16   5.74   4.88   99.99  7.47   5.68   5.76   6.44   8.42   7.73   6.37   4.18   9.99   5.68   9.99   2.44   5.09
K13     5.74   9.10   7.21   6.27   9.12   4.58   8.88   6.60   7.26   7.81   5.48   4.33   7.47   99.99  9.56   7.22   2.01   4.44   8.88   6.89   2.36   3.31   5.18   2.99   8.23   6.40
K14     9.37   8.59   4.57   7.73   7.70   4.36   9.89   5.39   8.69   4.24   9.41   6.32   5.68   9.56   99.99  7.29   5.42   7.75   8.73   4.50   6.99   7.32   1.85   7.19   3.65   4.67
K15     4.72   5.83   6.91   9.60   9.55   4.86   6.86   9.98   6.87   4.67   9.79   4.36   5.76   7.22   7.29   99.99  3.03   8.25   9.99   6.99   1.64   4.00   4.68   6.96   7.95   7.03
K16     4.11   1.25   9.68   3.05   3.34   2.83   5.82   4.77   2.79   7.88   8.25   2.75   6.44   2.01   5.42   3.03   99.99  2.56   6.58   1.44   4.77   5.01   2.82   6.77   3.36   6.75
K17     6.42   6.97   5.92   1.86   6.96   7.71   7.15   8.63   8.79   1.23   7.42   7.15   8.42   4.44   7.75   8.25   2.56   99.99  7.24   8.57   3.92   7.49   4.70   6.15   4.12   4.89
K18     8.03   7.66   3.30   4.80   2.83   6.70   4.29   4.17   7.78   2.13   5.34   1.77   7.73   8.88   8.73   9.99   6.58   7.24   99.99  6.83   2.18   5.73   6.54   7.10   7.84   2.87
K19     1.99   2.48   5.66   8.99   9.37   3.52   6.67   9.31   4.31   6.01   8.82   7.93   6.37   6.89   4.50   6.99   1.44   8.57   6.83   99.99  3.25   9.14   5.34   4.44   3.57   5.99
K20     5.25   7.45   7.58   3.42   6.53   8.94   2.18   6.24   9.47   6.70   4.16   2.98   4.18   2.36   6.99   1.64   4.77   3.92   2.18   3.25   99.99  7.02   1.76   3.73   6.97   4.90
K21     9.60   9.17   1.03   2.84   6.79   4.89   7.03   8.18   5.87   7.45   6.14   8.65   9.99   3.31   7.32   4.00   5.01   7.49   5.73   9.14   7.02   99.99  2.20   2.83   4.21   5.53
K22     6.00   5.35   3.11   4.29   7.19   5.12   5.25   3.96   6.88   6.55   2.10   2.86   5.68   5.18   1.85   4.68   2.82   4.70   6.54   5.34   1.76   2.20   99.99  1.59   3.19   2.67
K23     3.38   6.01   8.00   2.06   1.87   8.27   6.63   8.17   7.47   5.45   4.71   3.42   9.99   2.99   7.19   6.96   6.77   6.15   7.10   4.44   3.73   2.83   1.59   99.99  2.46   6.90
K24     5.10   1.99   7.06   2.98   5.52   7.56   1.40   6.88   5.62   8.87   8.76   6.64   2.44   8.23   3.65   7.95   3.36   4.12   7.84   3.57   6.97   4.21   3.19   2.46   99.99  1.26
K25     2.22   4.83   4.21   1.12   8.81   6.30   2.41   7.31   1.77   5.01   2.35   4.09   5.09   6.40   4.67   7.03   6.75   4.89   2.87   5.99   4.90   5.53   2.67   6.90   1.26   99.99
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