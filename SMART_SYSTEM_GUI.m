function SMART_SYSTEM_GUI()
    % List of Python programming questions
    questions = {
        'If statement checks what?';
        'What is a function?';
        'Equality operator symbol?';
        'Variable assignment uses what';
        'Data type for decimal?'
    };

    % Create GUI figure
    f = figure('Name', 'Python Programming Exam', ...
               'Position', [500 400 350 250], ...
               'MenuBar', 'none', ...
               'NumberTitle', 'off', ...
               'Resize', 'off');

    % Listbox to show questions
    uicontrol('Style', 'listbox', ...
              'String', questions, ...
              'FontSize', 11, ...
              'Position', [50 80 250 120], ...
              'Tag', 'questionList');

    % Button to play selected question
    uicontrol('Style', 'pushbutton', ...
              'String', 'Play Question', ...
              'FontSize', 12, ...
              'Position', [100 30 150 35], ...
              'Callback', @playSelectedQuestion);
end

function playSelectedQuestion(~, ~)
    % Get handle to listbox
    listBox = findobj('Tag', 'questionList');
    
    % Get selected index
    selectedIdx = listBox.Value;
    
    % Get all questions
    allQuestions = listBox.String;

    % Extract selected question
    selectedQuestion = allQuestions{selectedIdx};

    % Use TTS to speak question
    tts(selectedQuestion);
 run('audio_processing_system.m');
end
