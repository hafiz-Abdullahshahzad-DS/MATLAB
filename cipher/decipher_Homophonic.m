function [plain_text] = decipher_Homophonic(cipher_text,Freq)

% cipher text (This is an array of Number come from the encoding cipher)
ct = cipher_text;

% Get Alphabets
alphabets = char('A':'Z');
plain_alphabets = uint8(alphabets); % Numerical Array

% plain text variable
pt = zeros(1,length(ct));

for i = 1:length(pt)
    % Get the Row containing the
    [row,col] = find(Freq == ct(i));
    pt(i) = plain_alphabets(row);
end
plain_text = char(pt);
end