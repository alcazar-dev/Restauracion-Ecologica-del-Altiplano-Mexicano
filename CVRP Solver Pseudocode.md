# CVRP Solver Pseudocode

```python
begin
	data := create_data_model();
    
	manager := create_routing_index_manager(number_of_locations, number_of_vehicles, depot);
    
	routing := create_routing_model(manager);
    
	distance_callback(from_index, to_index) ≡
    	from_node := manager.IndexToNode(from_index);
    	to_node := manager.IndexToNode(to_index);
    	return distance_between(from_node, to_node);
    
	transit_callback_index := routing.RegisterTransitCallback(distance_callback);
    
	routing.SetArcCostEvaluatorOfAllVehicles(transit_callback_index);
    
	demand_callback(from_index) ≡
    	from_node := manager.IndexToNode(from_index);
    	return demand_of(from_node);
    
	demand_callback_index := routing.RegisterUnaryTransitCallback(demand_callback);
    
	routing.AddDimensionWithVehicleCapacity(
    	demand_callback_index,
    	no_slack,
    	vehicle_max_capacities,
    	start_from_zero,
    	"Capacity"
	);
    
	search_parameters := set_default_routing_search_parameters();
	search_parameters.first_solution_strategy := PATH_CHEAPEST_ARC;
	search_parameters.local_search_metaheuristic := GUIDED_LOCAL_SEARCH;
	search_parameters.time_limit := set_time_limit_in_seconds();
    
	solution := routing.SolveWithParameters(search_parameters);
    
	if solution exists then
    	print_solution(data, manager, routing, solution);
	fi
end


proc print_solution(data, manager, routing, solution) ≡
	print total_objective_value();
    
	total_time := 0;
	total_load := 0;
    
	for each vehicle do
    	route := get_route_for_vehicle(vehicle);
    	route_time := 0;
    	route_load := 0;
   	 
    	while route_not_complete() do
        	node := get_next_node(route);
        	route_load := route_load + demand_of(node);
        	route_time := route_time + travel_time_between(previous_node, node);
    	od;
   	 
    	print_route(route, route_load, route_time);
    	total_time := total_time + route_time;
    	total_load := total_load + route_load;
	od;
    
	print total_time_and_load(total_time, total_load);
end
