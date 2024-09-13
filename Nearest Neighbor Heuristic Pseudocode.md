# Nearest Neighbor Heuristic Pseudocode

```python
begin
  accumulated_time := 0;
  num_points := total_points();
  visited := boolean_array(num_points, false);

  for i := 1 to num_points do
	if demands(i) = 0 then
  	visited(i) := true
	fi
  od;

  while sum(visited) < num_points do
	current_node := 0;
	current_capacity := 0;
	route := [current_node];
	visited(current_node) := true; (* Mark the starting node as visited *)

	do if current_capacity + demands(current_node) > vehicle_capacity then exit fi;
  	actual := last_node(route);
  	nearest := null;
  	min_dist := infinity;

  	for neighbor in not_visited(visited) do
    	if demands(neighbor) + current_capacity <= vehicle_capacity and
       	distance(actual, neighbor) < min_dist then
       	nearest := neighbor;
       	min_dist := distance(actual, neighbor)
    	fi
  	od;

  	if nearest = null then
    	accumulated_time := accumulated_time + distance(actual, 0);
    	break
  	fi;

  	accumulated_time := accumulated_time + (distance(actual, nearest) + 0.06 * demands(nearest));

  	if accumulated_time >= 480 then
    	accumulated_time := 0;
    	break
  	fi;

  	route := route + nearest;
  	visited(nearest) := true;
  	current_capacity := current_capacity + demands(nearest);

	od;

	route := route + 0; (* Return to depot *)
	add_route(routes, route);
  od;

  return routes
end
