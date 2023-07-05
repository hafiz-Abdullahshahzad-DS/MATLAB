%starting row
alphabet = ['B':'Z' 'A'] ;

% Initialize the matrix
rotatedMatrix = repmat(alphabet, 26, 1);

% Rotate each row
for i = 2:26
    rotatedMatrix(i, :) = circshift(rotatedMatrix(i-1, :), [0, -1]);
end

% Display the rotated matrix
disp(rotatedMatrix);
