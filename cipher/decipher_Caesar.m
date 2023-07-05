function [plain_text] = decipher_Caesar(cipher_text,code_word)


% Remove the Repeating Alphabets in code word

cw = char(unique(uint8(code_word),'stable'));

% Get Alphabets
alphabets = char('A':'Z');
cipher_alphabets_array = uint8(alphabets); % Numerical Array

cipher_length = length(uint8(cw));
cipher = uint8(cw);  % starting with the code word
init = cipher(end);
while cipher_length < 26 % Total Aplphabets 
    if init > uint8('Z')
        init = uint8('A');
        continue;
    end
    if any(init == cipher)
        init = uint8(init) +1;
        continue;
    end
    cipher = [cipher init];
    cipher_length = length(cipher);
end

pt = [];
ct = uint8(cipher_text);
for i = 1:length(ct)
    index = find(cipher_text(i) == cipher);
    pt(i) = cipher_alphabets_array(index);
end
plain_text = char(pt);

end