function audio_processing_system()
    % Create the main figure window
    fig = figure('Name', 'Audio Processing System', ...
                'Position', [100, 100, 900, 700], ...
                'NumberTitle', 'off', ...
                'MenuBar', 'none', ...
                'ToolBar', 'none');
    
    % Create UI controls
    uicontrol('Style', 'pushbutton', ...
              'String', 'Record Audio', ...
              'Position', [50, 620, 150, 40], ...
              'Callback', @record_audio, ...
              'FontSize', 12);
    
    uicontrol('Style', 'pushbutton', ...
              'String', 'Load Audio', ...
              'Position', [250, 620, 150, 40], ...
              'Callback', @load_audio, ...
              'FontSize', 12);
    
    uicontrol('Style', 'pushbutton', ...
              'String', 'Play Audio', ...
              'Position', [450, 620, 150, 40], ...
              'Callback', @play_audio, ...
              'FontSize', 12, ...
              'Enable', 'off');
    
    uicontrol('Style', 'pushbutton', ...
              'String', 'Analyze Audio', ...
              'Position', [650, 620, 150, 40], ...
              'Callback', @analyze_audio, ...
              'FontSize', 12, ...
              'Enable', 'off');
    
    uicontrol('Style', 'pushbutton', ...
              'String', 'Transcribe', ...
              'Position', [50, 560, 150, 40], ...
              'Callback', @transcribe_audio, ...
              'FontSize', 12, ...
              'Enable', 'off');
    
    uicontrol('Style', 'pushbutton', ...
              'String', 'Save Audio', ...
              'Position', [250, 560, 150, 40], ...
              'Callback', @save_audio, ...
              'FontSize', 12, ...
              'Enable', 'off');
    
    uicontrol('Style', 'pushbutton', ...
              'String', 'Save Text', ...
              'Position', [450, 560, 150, 40], ...
              'Callback', @save_text, ...
              'FontSize', 12, ...
              'Enable', 'off');
    
    % Create axes for plots
    time_ax = axes('Parent', fig, 'Position', [0.1, 0.45, 0.8, 0.2]);
    freq_ax = axes('Parent', fig, 'Position', [0.1, 0.2, 0.8, 0.2]);
    
    % Create text area for transcription results
    transcription_box = uicontrol('Style', 'edit', ...
                                 'String', '', ...
                                 'Position', [190, 50, 620, 30], ...
                                 'FontSize', 12, ...
                                 'Max', 10, ...
                                 'Min', 1, ...
                                 'HorizontalAlignment', 'left', ...
                                 'Enable', 'inactive');
    
    % Status label
    status_label = uicontrol('Style', 'text', ...
                            'String', 'Answer', ...
                            'Position', [50, 50, 100,60], ...
                            'FontSize', 12, ...
                            'HorizontalAlignment', 'left');
    
    % Initialize variables
    Fs = 44100; % Higher sampling rate for better quality
    recorder = [];
    audio_data = [];
    filename = '';
    transcription = '';
    
    % Callback functions
    function record_audio(~, ~)
        % Disable buttons during recording
        toggle_buttons('off');
        set(status_label, 'String', 'Recording... Speak now (5 seconds)');
        
        % Create recorder object
        recorder = audiorecorder(Fs, 16, 1); % 16-bit, mono
        
        % Record for 5 seconds
        recordblocking(recorder, 5);
        
        % Get audio data
        audio_data = getaudiodata(recorder);
        filename = 'recording.wav';
        
        % Enable appropriate buttons
        set(findobj(fig, 'String', 'Play Audio'), 'Enable', 'on');
        set(findobj(fig, 'String', 'Analyze Audio'), 'Enable', 'on');
        set(findobj(fig, 'String', 'Transcribe'), 'Enable', 'on');
        set(findobj(fig, 'String', 'Save Audio'), 'Enable', 'on');
        
        set(status_label, 'String', 'Recording complete. Ready for analysis.');
    end

    function load_audio(~, ~)
        [file, path] = uigetfile({'*.wav;*.mp3;*.ogg', 'Audio Files (*.wav, *.mp3, *.ogg)'}, ...
                                 'Select Audio File');
        if isequal(file, 0)
            set(status_label, 'String', 'File selection cancelled.');
            return;
        end
        
        filename = fullfile(path, file);
        try
            [audio_data, Fs] = audioread(filename);
            
            % Convert stereo to mono if needed
            if size(audio_data, 2) == 2
                audio_data = mean(audio_data, 2);
            end
            
            % Enable appropriate buttons
            set(findobj(fig, 'String', 'Play Audio'), 'Enable', 'on');
            set(findobj(fig, 'String', 'Analyze Audio'), 'Enable', 'on');
            set(findobj(fig, 'String', 'Transcribe'), 'Enable', 'on');
            set(findobj(fig, 'String', 'Save Audio'), 'Enable', 'on');
            
            set(status_label, 'String', ['Loaded: ' file]);
        catch ME
            set(status_label, 'String', ['Error loading file: ' ME.message]);
        end
    end

    function play_audio(~, ~)
        if ~isempty(audio_data)
            sound(audio_data, Fs);
            set(status_label, 'String', 'Playing audio...');
        else
            set(status_label, 'String', 'No audio data to play.');
        end
    end

    function analyze_audio(~, ~)
        if isempty(audio_data)
            set(status_label, 'String', 'No audio data to analyze.');
            return;
        end
        
        % Time domain plot
        axes(time_ax);
        cla(time_ax);
        t = (0:length(audio_data)-1)/Fs;
        plot(time_ax, t, audio_data);
        xlabel(time_ax, 'Time (s)');
        ylabel(time_ax, 'Amplitude');
        title(time_ax, 'Time Domain Signal');
        grid(time_ax, 'on');
        
        % Frequency domain plot
        axes(freq_ax);
        cla(freq_ax);
        N = length(audio_data);
        f = (0:N-1)*(Fs/N);
        fft_data = abs(fft(audio_data));
        plot(freq_ax, f(1:N/2), fft_data(1:N/2));
        xlabel(freq_ax, 'Frequency (Hz)');
        ylabel(freq_ax, 'Magnitude');
        title(freq_ax, 'Frequency Spectrum');
        grid(freq_ax, 'on');
        
        set(status_label, 'String', 'Audio analysis complete.');
    end

    function transcribe_audio(~, ~)
        if isempty(audio_data)
            set(status_label, 'String', 'No audio data to transcribe.');
            return;
        end
        
        set(status_label, 'String', 'Transcribing... Please wait.');
        set(transcription_box, 'String', 'Processing...');
        drawnow;
        
        try
            % Initialize speech recognition
            transcriber = speechClient("wav2vec2.0");
            
            % Perform speech-to-text
            recognizedTable = speech2text(transcriber, audio_data, Fs);
            
            % Extract recognized text
            if ~isempty(recognizedTable)
                colName = recognizedTable.Properties.VariableNames{1};
                recognizedText = recognizedTable.(colName){1};
                
                % Process the text
                processedText = process_text(recognizedText);
                
                % Display results
                set(transcription_box, 'String', processedText);
                transcription = processedText;
                
                % Enable save text button
                set(findobj(fig, 'String', 'Save Text'), 'Enable', 'on');
                
                set(status_label, 'String', 'Transcription complete.');
            else
                set(transcription_box, 'String', 'No speech detected.');
                set(status_label, 'String', 'Transcription failed - no speech detected.');
            end
        catch ME
            set(transcription_box, 'String', ['Error: ' ME.message]);
            set(status_label, 'String', 'Transcription failed.');
        end
    end

    function save_audio(~, ~)
        if isempty(audio_data)
            set(status_label, 'String', 'No audio data to save.');
            return;
        end
        
        [file, path] = uiputfile('*.wav', 'Save Audio File', 'recording.wav');
        if isequal(file, 0)
            set(status_label, 'String', 'Save cancelled.');
        else
            filename = fullfile(path, file);
            audiowrite(filename, audio_data, Fs);
            set(status_label, 'String', ['Audio saved to: ' filename]);
        end
    end

    function save_text(~, ~)
        if isempty(transcription)
            set(status_label, 'String', 'No transcription to save.');
            return;
        end
        
        [file, path] = uiputfile('*.txt', 'Save Text File', 'transcription.txt');
        if isequal(file, 0)
            set(status_label, 'String', 'Save cancelled.');
        else
            filename = fullfile(path, file);
            fid = fopen(filename, 'w');
            fprintf(fid, '%s\n', transcription);
            fclose(fid);
            set(status_label, 'String', ['Transcription saved to: ' filename]);
        end
    end

    function toggle_buttons(state)
        % Helper function to enable/disable buttons
        set(findobj(fig, 'String', 'Record Audio'), 'Enable', state);
        set(findobj(fig, 'String', 'Load Audio'), 'Enable', state);
        set(findobj(fig, 'String', 'Play Audio'), 'Enable', state);
        set(findobj(fig, 'String', 'Analyze Audio'), 'Enable', state);
        set(findobj(fig, 'String', 'Transcribe'), 'Enable', state);
        set(findobj(fig, 'String', 'Save Audio'), 'Enable', state);
        set(findobj(fig, 'String', 'Save Text'), 'Enable', state);
    end

    function processedText = process_text(rawText)
        % Convert to lowercase
        processedText = lower(rawText);
        
        % Remove non-letter characters (retain spaces and basic punctuation)
        processedText = regexprep(processedText, '[^a-zA-Z .,!?]', '');
        
        % Remove extra spaces
        processedText = strtrim(regexprep(processedText, '\s+', ' '));
        
        % Split into sentences
        sentenceEnds = [regexp(processedText, '[.!?]'), length(processedText)];
        startIdx = 1;
        sentences = {};
        
        for i = 1:length(sentenceEnds)
            endIdx = sentenceEnds(i);
            sentence = strtrim(processedText(startIdx:endIdx));
            if ~isempty(sentence)
                % Capitalize first letter
                if ~isempty(sentence)
                    sentence(1) = upper(sentence(1));
                end
                sentences{end+1} = sentence;
            end
            startIdx = endIdx + 1;
        end
        
        % Rejoin sentences with spaces
        processedText = strjoin(sentences, ' ');
    end
end