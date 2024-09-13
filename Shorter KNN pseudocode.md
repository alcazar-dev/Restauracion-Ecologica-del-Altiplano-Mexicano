\# Shorter Nearest Neighbor Heuristic Pseudocode

\`\`\`python  
begin  
	mark\_nodes\_with\_zero\_demand\_as\_visited();  
      
	while there\_are\_unvisited\_nodes() do  
    	route := \[0\];  (\* Start route from the depot \*)  
    	current\_capacity := 0;  
   	   
    	do if current\_capacity \+ demand\_exceeds\_capacity() then exit fi;  
        	neighbor := find\_closest\_unvisited\_neighbor();  
       	   
        	if neighbor \= None then  
            	return\_to\_depot();  
            	break;  
        	fi;  
       	   
        	if accumulated\_time \>= 480 then  (\* 8-hour limit \*)  
            	break;  
        	fi;  
       	   
        	add\_to\_route(neighbor);  
        	update\_capacity\_and\_accumulated\_time(neighbor);  
        	mark\_as\_visited(neighbor);  
       	   
    	od;  
   	   
    	return\_to\_depot();  
    	save\_route(route);  
   	   
	od;  
      
	return routes;  
end

