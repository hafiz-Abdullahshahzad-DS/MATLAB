function [decrypted] = columnar(encrypted,key,code)
c=1;
b=[];
% Add Space at the End
encrypted=[encrypted ' '];
% Find the index of spaces
find(encrypted==' ');
for i=1:length(ans)
    %Convert the encryption into matrix
    b(:,i)=encrypted(c:ans(i)-1)';
    c=ans(i)+1;
end
ddd=b;
%Convert the key into number
key=double(key);
es=key;
%sort the key so that it will be used furthur
key=sort(key);
a=[];
for i=1:length(key)
    % Giving number based on there preference that which letter comes first
    index=find(es==key(i));
    a(index)=i;
end
decry=[];
for i=1:6
    %Start the decryption by rearranging the matrix
    decry(:,i)=b(:,a(i));
end

num2cell(char(decry));
B=ans';
B=B(:)'; %Convert the matrix into array for getting characters as an input
B=char(B);
B=double(B);
B=B';
% Adding the spaces at the output of decryption
cum_code=cumsum(code);
arri=[0 1 2 3 4 5 6 7];
cum_code=arri+cum_code;
 for i=1:length(cum_code)
    
     B=[B(1:cum_code(i)),32,B(cum_code(i)+1:end)];
 end
 %Remove the redundant part from the end
B(end-4:end)=[];
decrypted=char(B);
end

