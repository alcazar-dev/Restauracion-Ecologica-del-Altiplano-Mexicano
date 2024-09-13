```python
begin
	mark_nodes_with_zero_demand_as_visited();
    
	while there_are_unvisited_nodes() do
    	route := [0];  (* Start route from the depot *)
    	current_capacity := 0;
   	 
    	do if current_capacity + demand_exceeds_capacity() then exit fi;
        	neighbor := find_closest_unvisited_neighbor();
       	 
        	if neighbor = None then
            	return_to_depot();
            	break;
        	fi;
       	 
        	if accumulated_time >= 480 then  (* 8-hour limit *)
            	break;
        	fi;
       	 
        	add_to_route(neighbor);
        	update_capacity_and_accumulated_time(neighbor);
        	mark_as_visited(neighbor);
       	 
    	od;
   	 
    	return_to_depot();
    	save_route(route);
   	 
	od;
    
	return routes;
end
