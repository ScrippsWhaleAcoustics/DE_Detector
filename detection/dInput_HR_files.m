function [clkAnnotH,hdr,channel,labelFile] = dInput_HR_files(fullFiles,fullLabels,viewPath,p)

% Source files we expect to see in the list of viewpath'd directories
% or directly present.
dataFile = ioSearchViewpath(fullFiles, viewPath);  % source audio

% break up data file name
[~, dataFileInfo] = fileattrib(dataFile);

% Strip out extension
[pathStr, baseName, ext] = fileparts(dataFileInfo.Name);

[fileTypes, fileExtensions] = ioGetFileType(fullFiles);
% Matlab extension may not be correct due to files with multiple dots
% in the extension (e.g. .x.wav).  Strip out based upon known extension
% baseName = [baseName, ext];
% if fileTypes(1) == 2; % won't work if mixed types
%     baseName(end-length(fileExtensions{1})+1:end) = [];
% end
% Determine output file names
[~, labelFile] = ioSearchViewpath(fullLabels, viewPath);  % metadata

% Retrieve header information for this file
if fileTypes == 1
    hdr = ioReadWavHeader(dataFile, p.DateRE);
else
    hdr = ioReadXWAVHeader(dataFile, 'ftype', fileTypes);
end

if ~ isfield(hdr, 'fs')
    fprintf('Skipping bad file %s', fullFiles);
    clkAnnotH = []; 
else
    % Open annotation file
    clkAnnotH = openAnnot(pathStr, baseName,'', p.clickAnnotExt, viewPath);
end

% Determine channel based on file characteristics
channel = p.chan;