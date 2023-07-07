function [score] = ScoreLayout(matrix,pnum)
    % Initialize scores
    score = [0,0];
    % Check rows
    for i=1:6
        for j=1:4
            if matrix(i,j) == matrix(i,j+1) && matrix(i,j+1) == matrix(i,j+2) && matrix(i,j+2) == matrix(i,j+3)
                if matrix(i,j) == 1
                    score(1) = score(1)+100;
                elseif matrix(i,j) == 2
                    score(2) = score(2)+100;
                end
            end
        end
    end

    % Check columns
    for i=1:3
        for j=1:7
            if matrix(i,j) == matrix(i+1,j) && matrix(i+1,j) == matrix(i+2,j) && matrix(i+2,j) == matrix(i+3,j)
                if matrix(i,j) == 1
                    score(1) = score(1)+100;
                elseif matrix(i,j) == 2
                    score(2) = score(2)+100;
                end
            end
        end
    end

    % Check diagonals (left to right)
    for i=1:3
        for j=1:4
            if matrix(i,j) == matrix(i+1,j+1) && matrix(i+1,j+1) == matrix(i+2,j+2) && matrix(i+2,j+2) == matrix(i+3,j+3)
                if matrix(i,j) == 1
                    score(1) = score(1)+100;
                elseif matrix(i,j) == 2
                    score(2) = score(2)+100;
                end
            end
        end
    end

    % Check diagonals (right to left)
    for i=4:6
        for j=1:4
            if matrix(i,j) == matrix(i-1,j+1) && matrix(i-1,j+1) == matrix(i-2,j+2) && matrix(i-2,j+2) == matrix(i-3,j+3)
                if matrix(i,j) == 1
                    score(1) = score(1)+100;
                elseif matrix(i,j) == 2
                    score(2) = score(2)+100;
                end
            end
        end
    end
if pnum == 1
    score = score(1);
elseif pnum == 2
    score = score(2);
end


end