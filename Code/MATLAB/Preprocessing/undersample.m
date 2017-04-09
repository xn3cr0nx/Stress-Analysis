function dataset = undersample(dataset)
    dataset = sortrows(dataset, 6); % sort rispetto alle label
    length_dataset = length(dataset);
    
    i = 1;
    while i < length_dataset
        if dataset(i, 6) == 2
            break
        end
        i = i + 1;
    end
    index_first_class = i-1;
    
    while i < length_dataset
        if dataset(i, 6) == 3
            break
        end
        i = i + 1;
    end
    index_second_class = i-1;
    
    data_first_class = dataset(1:index_first_class, :);
    data_second_class = dataset(index_first_class+1:index_second_class, :);
    data_third_class = dataset(index_second_class+1:end, :);
    
    num_first_class = length(data_first_class);
    num_second_class = length(data_second_class);
    num_third_class = length(data_third_class);
    
    final_number = min([num_first_class, num_second_class, num_third_class]);
    
    % Shuffle dei dataset
    data_first_class = data_first_class(randperm(num_first_class), :);
    data_second_class = data_second_class(randperm(num_second_class), :);
    data_third_class = data_third_class(randperm(num_third_class), :);
    
    if num_first_class > final_number
        difference = num_first_class - final_number;
        data_first_class = data_first_class(1:end - difference, :);
    end

    if num_second_class > final_number
        difference = num_second_class - final_number;
        data_second_class = data_second_class(1:end-difference, :);
    end
    
    if num_third_class > final_number
        difference = num_third_class - final_number;
        data_third_class = data_third_class(1:end - difference, :);
    end
    
    dataset = [data_first_class; data_second_class; data_third_class];
    
end