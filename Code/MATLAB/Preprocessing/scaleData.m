% INPUT: colonna di dati
% OUTPUT: colonna di dati con valori tra 0 e 1.
% Implementa una formula matematica, nulla di più
function data_column = scaleData(data_column)
    min_value = min(data_column);
    max_value = max(data_column);
    interval = max_value - min_value;
    
    for i=1:length(data_column)
        data_column(i,1) = (data_column(i,1) - min_value) / interval;
    end
end
