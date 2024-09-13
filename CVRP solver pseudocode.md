\# CVRP Solver Pseudocode

\`\`\`python  
begin  
	data := create\_data\_model();  
      
	manager := create\_routing\_index\_manager(number\_of\_locations, number\_of\_vehicles, depot);  
      
	routing := create\_routing\_model(manager);  
      
	distance\_callback(from\_index, to\_index) ≡  
    	from\_node := manager.IndexToNode(from\_index);  
    	to\_node := manager.IndexToNode(to\_index);  
    	return distance\_between(from\_node, to\_node);  
      
	transit\_callback\_index := routing.RegisterTransitCallback(distance\_callback);  
      
	routing.SetArcCostEvaluatorOfAllVehicles(transit\_callback\_index);  
      
	demand\_callback(from\_index) ≡  
    	from\_node := manager.IndexToNode(from\_index);  
    	return demand\_of(from\_node);  
      
	demand\_callback\_index := routing.RegisterUnaryTransitCallback(demand\_callback);  
      
	routing.AddDimensionWithVehicleCapacity(  
    	demand\_callback\_index,  
    	no\_slack,  
    	vehicle\_max\_capacities,  
    	start\_from\_zero,  
    	"Capacity"  
	);  
      
	search\_parameters := set\_default\_routing\_search\_parameters();  
	search\_parameters.first\_solution\_strategy := PATH\_CHEAPEST\_ARC;  
	search\_parameters.local\_search\_metaheuristic := GUIDED\_LOCAL\_SEARCH;  
	search\_parameters.time\_limit := set\_time\_limit\_in\_seconds();  
      
	solution := routing.SolveWithParameters(search\_parameters);  
      
	if solution exists then  
    	print\_solution(data, manager, routing, solution);  
	fi  
end

proc print\_solution(data, manager, routing, solution) ≡  
	print total\_objective\_value();  
      
	total\_time := 0;  
	total\_load := 0;  
      
	for each vehicle do  
    	route := get\_route\_for\_vehicle(vehicle);  
    	route\_time := 0;  
    	route\_load := 0;  
   	   
    	while route\_not\_complete() do  
        	node := get\_next\_node(route);  
        	route\_load := route\_load \+ demand\_of(node);  
        	route\_time := route\_time \+ travel\_time\_between(previous\_node, node);  
    	od;  
   	   
    	print\_route(route, route\_load, route\_time);  
    	total\_time := total\_time \+ route\_time;  
    	total\_load := total\_load \+ route\_load;  
	od;  
      
	print total\_time\_and\_load(total\_time, total\_load);  
end

