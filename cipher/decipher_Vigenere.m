function [plain_text] = decipher_Vigenere(cipher_text,code_word)

% Remove the Repeating Alphabets in code word and convert it into Ascii
cw = unique(uint8(code_word),'stable');

% Convert Cipher Text to Ascii
ct = uint8(cipher_text);

% Get Alphabets
alphabets = char('A':'Z');
cipher_alphabets_array = uint8(alphabets); % Numerical Array

% initialize pt 
pt = zeros(1,length(ct));

% Create a Vigenere Matrix

%starting row
alphabet = ['B':'Z' 'A'] ;

% Initialize the matrix
Vigenere_square = repmat(alphabet, 26, 1);

% Rotate each row
for i = 2:26
    Vigenere_square(i, :) = circshift(Vigenere_square(i-1, :), [0, -1]);
end
Vigenere_square = uint8(Vigenere_square);

% Seperate the first column element to choose Row for Encoding
first_column_elements =  Vigenere_square(:,1)';

cw_length=length(cw);

for i = 1:length(ct)
    % letter Selection
    if mod(i,cw_length) ~= 0
    letter_selection = uint8(cw(mod(i,cw_length)));
    else
    letter_selection = uint8(cw(cw_length));
    end
    index = find(first_column_elements == letter_selection);
    % Row Selection
    cipher_words_array = Vigenere_square(index,:);
    % Replace the alphabet
    ind = find(ct(i) == cipher_words_array);
    ind
    pt(i) = cipher_alphabets_array(ind);
end
plain_text = char(pt);

end