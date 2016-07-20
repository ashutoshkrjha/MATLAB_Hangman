%Reading from text file
fileID=fopen('words.txt','r');
W=textscan(fileID,'%s');
W=W{1,1};
fclose(fileID);
count=0; %Number of iterations

%Input the secret word
secword=input('Give a word: ','s');
test = length(secword);

misleft=6; %Number of mistakes left
T=[]; %Stores present status of word
for i=1:test
    T(end+1)='_';
end
T=char(T);


for i=length(W):-1:1
    if (length(W{i}) ~= test)
        W(i)=[];
    end
end

V=[]; %Matrix of visited alphabets
M=[]; %Matrix of missed alphabets(only printing purposes)

% fileID=fopen('answers.txt','w'); %Opening the output buffer

while(misleft ~= 0 && count<30)
    
    C=strjoin(W,''); %Concatenating all the words to count the frequency
    A=zeros(1,26); %Matrix to store the frequency of each alphabet
    
    for i=1:length(C)
        A(C(i)-'a'+1) = A(C(i)-'a'+1)+1;
    end
    
    [sortedValues,sortIndex] = sort(A(:),'descend');
    % maxIndex = sortIndex(1:6);  %This gives the indices of the six most frequently occuring characters
    freqchar=char(sortIndex+'a'-1); %most freq occuring chars array (For top 6 uncomment the above line. But starts malfunc for some words e.g. agronomical)
    
    %Choosing a guess
    for j=length(freqchar):-1:1
        if(isempty(find(V==freqchar(j))) ~= 0)
            guess=freqchar(j);
        end
    end
    
    V(end+1)=guess;
    V=char(V);
    
    k=strfind(secword,guess); %Stores the positions of guessed letter
    x=isempty(k);
    
    if (x==0)
        T(k)=guess;
        char(T);
        for i=length(W):-1:1 
            P=strfind(W{i},guess);
            if (isequal(P,k) ~= 1)
                W(i)=[];
            end
        end
    else
        M(end+1)=guess;
        misleft=misleft-1;
    end
    
    fprintf('guess: %c\n',guess);
    
    for i=1:length(T)
        fprintf('%c ',T(i));
    end
    
    fprintf(' missed: ')
    
    z=length(M);
    if (length(M)==1)
        fprintf('%c\n\n',M(1));
    else
        if(length(M)==0) 
            fprintf('\n\n');
        else
            for i=1:length(M)-1
                fprintf('%c,',M(i));
            end
            fprintf('%c\n\n',M(z));
        end
    end
    if(isequal(T,secword))
        break;
    end
    
    %Uncomment below iff you use the top 6 freqchar
    
%     if(isequal(size(W),[1 1]))
%         T=W{1};
%         break;
%     end

    count=count+1;
end