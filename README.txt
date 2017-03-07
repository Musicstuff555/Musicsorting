id3parse function was taken from https://www.mathworks.com/matlabcentral/fileexchange/25190-read-id3--version-2-only--from-an-mp3-file

getAllFiles function was taken from http://stackoverflow.com/questions/2652630/how-to-get-all-files-under-a-specific-directory-in-matlab

Because id3parse reads the low level data, it was only written to be able to handle id3 2.0. This only pertains to data about the track
number and the album name. All other data is completely consistent. Also because id3parse reads the low level data, occasionally, 
instead of failing to read the data at all, it instead returns nonsense characters. This was a bug that we were unable to fix by the
deadline we thank you for your understanding.

Script is only capable of handling .mp3 files instead of all music files.

