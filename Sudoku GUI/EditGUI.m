function EditGUI(userGrid,computerGrid,answerGrid)
f = figure('Name','Sudoku UITable');
cellGrid = cellfun(@(x)x(logical(x)),num2cell(userGrid + computerGrid),'uni',false);
t = uitable('Parent',f,'Data',cellGrid,'Position',[0 0 300 300],'FontName','Arial','FontSize',20,'FontUnits','points','ColumnEditable',true,'ColumnWidth',{40 40 40 40 40 40 40 40 40}, 'Rowstriping', 'off', 'CellEditCallback',@enterNumber);
ext = get(t, 'Extent');
set(t, 'Position', [0 0 ext(3:4)]);

    function enterNumber(hObject,callbackdata)
        
        % if input is not a number, change input to -10, which will trigger
        % the integer 0-9 warning below
        if isnan(callbackdata.NewData)
            v = -10;
        else
            v = eval(callbackdata.EditData);
            clc;
        end
        i = callbackdata.Indices(1);
        j = callbackdata.Indices(2);
        idx = sub2ind(size(computerGrid),i,j);
        whoops = 0;
        
        % program will not let you change a number that was given in the
        % original puzzle
        if computerGrid(i,j) ~= 0
            clc; disp(' '); warning('Cannot change an original number.'); 
            whoops = 1;
            data = get(t,'data');
            data(idx) = cellGrid(i,j);
            set(t,'data',data)
        end
        
        %program will only allow integers 0-9 as input
        if v > 9 || v < 0 || floor(v) ~= v
            clc; disp(' ');warning('Must be a number 0 - 9.');
            hObject.Data(i,j) = 0;
            ConvertGrid(1:i,1:j) = hObject.Data;
            userGrid(i,j) = ConvertGrid(i,j);
            whoops = 1;
            data = get(t,'data');
            data(idx) = cellGrid(i,j);
            set(t,'data',data)
        end
        
        % if the input cell and value are allowed values, enter the number
        % into the table
        if whoops == 0
            % you can reset a value you've already entered by putting in 0,
            % and the program will change it back to a blank space
            if callbackdata.NewData == 0 
                clc;
                hObject.Data(i,j) = v;
                ConvertGrid(1:i,1:j) = hObject.Data;
                userGrid(i,j) = ConvertGrid(i,j);
                data = get(t,'data');
                data(idx) = cellfun(@(x)x(logical(x)),num2cell(0),'uni',false);
                set(t,'data',data)
            % otherwise, it's an integer 1-9, put it in the grid!    
            else
                v = cellfun(@(x)x(logical(x)),num2cell(v),'uni',false);
                hObject.Data(i,j) = cell2mat(v);
                ConvertGrid(1:i,1:j) = hObject.Data;
                userGrid(i,j) = ConvertGrid(i,j);
            end
        end
        
        % determines if the puzzle is all filled in and correct.
        
        if length(find(userGrid+computerGrid)) == 81
            if answerGrid(:,:,1) - userGrid - computerGrid == 0
                clc; disp(' ');display('All done! You''re awesome!');
            else
                clc; disp(' ');display('Everything is filled in, but something is still wrong');
            end
        end
        
    end
end