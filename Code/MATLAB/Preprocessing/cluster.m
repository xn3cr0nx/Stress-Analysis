function value = cluster(stress_value)
    if stress_value < 5
        value = 1;
    elseif stress_value < 8
        value = 2;
    else 
        value = 3;
    end
end