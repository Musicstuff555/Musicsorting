%Music sort master script


'Please note: files with id3 tag other than 2.0, are often not read properly.'

valid_direct=false;
while valid_direct==false
    Mus_dir=input('please enter the directory of your music library: ','s');
    list=getAllFiles(Mus_dir);%make a list of all the music in the directory
    if max(size(list))>1
        valid_direct=true;
    else
        'That is not a valid directory or therer is nothing stored there.'
    end
end
%ask for music directory


%once we've gotten a valid directory

real_item=0;
%^^^a variable to keep track of the number of music files instead of the number of total loops
for item =1:length(list)%iterate through the list
    song=char(list(item));%variable that can be read by later reading funcs
    [loc,name,extension]=fileparts(song);%parse the items
    if strcmp(extension,'.mp3')%if its a music file
        real_item=real_item+1;%add 1 to number of music files
        %^^^ the structure that is changed several times and indexed in the loop
        temp=struct(id3parse(song));
            %^^ some tracks return 1 of 10 instead of just a number
            %extractBefore removes this issue
        try
            fin_struct(real_item).Track=extractBefore(temp.Track,' ');
            %^^ some tracks return 1 of 10 instead of just a number
            %extractBefore removes this issue
            
        catch
            fin_struct(real_item).Track='unknown';
        end
        try
            fin_struct(real_item).Album=temp.Album;
            %^^Test album for the same shit
        catch
            fin_struct(real_item).Album='unknown';
        end
        temp=audioinfo(song);
        fin_struct(real_item).Artist=temp.Artist;
        fin_struct(real_item).Title=temp.Title;
        fin_struct(real_item).File=temp.Filename;
        %^^^ add filename, song name + artist to our temporary cell list
        %fin_list(real_item)=fin_struct;%fin_list is an array of strucutres
        %^^ indexed in all of the file refferencing
    end
end
fin_struct(10)
if real_item==0
    'There are no .mp3 files in this directory'
    return
end
%^^ If directory contained no .mp3 files

%%%THE MAINLOOP%%%

%state='ask_all';
%^keep track of user inputs

%while true
%    if strcmp(state,'ask_all')
%        qu = char(lower(input('Album or artist? ','s')));
%        %^ask user how to devide music
%        if strcmp(qu,'album')%if user input album
%            'This is what we were abble to read.'
%            for item = 1:length(fin_struct)
%                if ismember(fin_struct(item).Album,misc_list)==0
%                    %^^if album hasn't made the list yet
%                    misc_list_len=misc_list_len+1;%update length
%                    misc_list(misc_list_len)=fin_struct(item).Album;
%                    %^^append album list
%                    
%                end
%            end
%            
%            state=char('album');%change state
%        elseif strcmp(qu,'artist')%if user input artist
%            'This is what we were abble to read.'
%            for item = 1:length(fin_struct)
%                if ismember(fin_struct(item).Artist,misc_list)==0
%                   misc_list_len=misc_list_len+1;
%                   misc_list(misc_list_len)=fin_struct(item).Artist;
%                end
%            end
%            state=char('artist');%change state
%        else%if user is a moron
%            'That is not a valid input'
%        end
%    end
%    if strcmp(state,'ask_all')==0%
%        test=0;
%        while test==0
%            qu=char(input('Which? ','s'));%ask which album or artist selected
%            if ismember(qu,misc_list)%if it's one of the items listed
%                
%                test=1;
%                misc_list=strings(1,real_item);
%                for item=1:length(fin_struct)
%                    %^^iterate through all the songs found
%                    if strcmp(state,'album')%if user said album earlier
%                        if strcmp(fin_struct(item).Album,qu)
%                            %^^if album name matches
%                            fin_struct(item).Title%display song title
%                            misc_list(item)=fin_struct(item).Title;
%                        end
%                    elseif strcmp(state,'artist')%if user said artist
%                        if strcmp(fin_struct(item).Artist,qu)
%                            %^^if artist matches
%                            fin_struct(item).Title%display song title
%                            misc_list(item)=fin_struct(item).Title;
%                        end
%                    end
%                end
%                state=char('Song');%change state
%            else
%                'That is not a listed album or artist.'
%            