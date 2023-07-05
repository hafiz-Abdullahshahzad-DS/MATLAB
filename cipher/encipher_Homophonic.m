function [cipher_text,Freq] = encipher_Homophonic(plain_text)
% Convert plain text to Ascii
pt = uint8(plain_text);

% Get Alphabets
alphabets = char('A':'Z');
plain_alphabets = uint8(alphabets); % Numerical Array

ct = zeros(1,length(pt));
[Freq,p] = homophonic_alp();

for i =1 :length(ct)
    % get the corresponding row from the freq matrix by pt letter
   
    % Row Selection
    freq_row = Freq(pt(i)-64,:);

    % get the available options
    available_option = freq_row(freq_row ~= 0);
    
    % Randomly Select from available options and assign to value that will
    % be replaced
    ct(i) = available_option(randi(length(available_option)));

end    

cipher_text = ct;


function [Freq,p] = homophonic_alp()

p = [8 2 3 4 12 2 2 6 6 1 1 4 2 6 7 2 1 6 6 9 3 1 2 1 2 1]';
Freq = zeros(26,12);
r = randperm(100)';

for i = 1:length(p)
    Freq(i,1:p(i)) = r(1:p(i));
    r(1:p(i)) = [];
end
    
end
end