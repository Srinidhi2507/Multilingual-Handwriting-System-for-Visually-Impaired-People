
% === Optional Utility Function ===
function output = eraseDuplicates(inputText)
    words = split(inputText);
    outputWords = unique(words, 'stable');
    output = strjoin(outputWords, ' ');
end
