function EditGUI(UserGrid,ComputerGrid,AnswerGrid)
f = figure('Name','Sudoku UITable');
CellGrid = cellfun(@(x)x(logical(x)),num2cell(UserGrid + ComputerGrid),'uni',false);
t = uitable('Parent',f,'Data',CellGrid,'Position',[0 0 300 300],'ColumnEditable',true,'ColumnWidth',{20 20 20 20 20 20 20 20 20},'CellEditCallback',@enterNumber);
%set(t,'Position(3)','Extent(3)');
    function enterNumber(hObject,callbackdata)
        if isnan(callbackdata.NewData)
            v = -10;
        else
            v = eval(callbackdata.EditData);
        end
        i = callbackdata.Indices(1);
        j = callbackdata.Indices(2);
        idx = sub2ind(size(ComputerGrid),i,j);
        whoops = 0;
        if ComputerGrid(i,j) ~= 0
            disp(' '); disp('Cannot change an original number.'); disp(' ');
            whoops = 1;
            data = get(t,'data');
            data(idx) = CellGrid(i,j);
            set(t,'data',data)
        end
        if v > 9 || v < 0 || floor(v) ~= v
            disp(' ');disp('Must be a number 0 - 9.');disp(' ');
            whoops = 1;
            data = get(t,'data');
            data(idx) = CellGrid(i,j);
            set(t,'data',data)
        end
        if whoops == 0
            if callbackdata.NewData == 0
                UserGrid(i,j) = v;
                data = get(t,'data');
                data(idx) = cellfun(@(x)x(logical(x)),num2cell([0]),'uni',false);
                set(t,'data',data)
            else
                UserGrid(i,j) = v;
                v = cellfun(@(x)x(logical(x)),num2cell(v),'uni',false);
                hObject.Data{i,j} = v;
                CellGrid = cellfun(@(x)x(logical(x)),num2cell(UserGrid+ComputerGrid),'uni',false);
                %data(idx) = CellGrid(i,j);
                %set(t,'data',data)
            end
        end
    end
E = AnswerGrid(:,:,1) - ComputerGrid(:,:) - UserGrid(:,:);
%if find(E) > 0
%    disp('You lose! Good day sir!'); disp(' '); disp('(Sorry, something is wrong. Keep trying.)'); disp(' ');
%else
%    disp('Huzzah! You rock!'); disp(' '); disp('<fireworks>'); disp(' ');
%end
end