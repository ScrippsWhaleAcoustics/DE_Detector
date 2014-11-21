function [clkStart,clkEnd]= dProcess_valid_clicks(clicks,clickInd,startsK,hdr,...
    clkAnnotH,wideBandFilter)


clkStart = nan(length(clickInd),1);
clkEnd = nan(length(clickInd),1);

for c = 1:length(clickInd)
    cI = clickInd(c);
    currentClickStart = startsK + clicks(cI,1)/hdr.fs; % start time
    currentClickEnd = startsK + clicks(cI,2)/hdr.fs;
    if ~isempty(currentClickEnd)
        if clkAnnotH ~= -1
            % If true write individual click annotations to .ctg file
            fprintf(clkAnnotH, '%f %f\n', ...
                currentClickStart + length(wideBandFilter)/2/hdr.fs, ...
                currentClickEnd + length(wideBandFilter)/2/hdr.fs);
        end
        
        % Compute parameters of click frames
        clkStart(c,1) = currentClickStart;
        clkEnd(c,1) = currentClickEnd;
    end
end
