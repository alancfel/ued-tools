function IMG_out = processImagesInDirectory2018_general(dataDir, string2match, filterOptions)
    % Reads images in folder containing [string2match],
    % removes outliers from z-stack and averages remaining pixels
    % (not sums or differences)

    % dataLocation;
    files = dir(fullfile(dataDir, string2match));
    num_imgs = length(files);
    fname = files(1).name;
    testimg = double(DataIOLibrary.DataIO.ReadSpe(fullfile(dataDir,fname)));
    [NY,NX] = size(testimg); 
    IMGs = zeros(NY,NX,num_imgs);
    %IMG_BG = zeros(NY,NX);
    for indx  = 1:num_imgs
        fname = files(indx).name;
        IMGs(:,:,indx) = double(DataIOLibrary.DataIO.ReadSpe(fullfile(dataDir,fname)));
    end

    IMGs = outlierFilterGeneral(IMGs,filterOptions);

    IMG_out = mean(IMGs,3);

end