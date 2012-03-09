% Creates a motion history image in 1 of 4 forms
%
%   1.  Last image is brightest
%   2.  Last image is brightest max value is 1 (means it shows up in image)
%   3.  Images are all averaged
%   4.  Normal distribution over images that are used
%   5.  Normal distribution over all images using only certain ones
%
% First 3 and last 3 images may be cut if there is no overlap with next or previous images.
% This is in part to keep out noise and also because these images are less likely to be
% important to the sequence as we go forwards.
%

function [mhi] = mhiImage(binaries, form)

    if nargin == 1
        form = 3;
    end

    num = size(binaries);
    
    if (form == 1) | (form == 2);
        mhi = double(binaries(:,:,1))/num(3);
        %i = 1;
        %figure(i);
        %imshow(mhi);

        total = num(3);

        fail = 0;
        failEnd = 0;


        for i = 2:num(3)
            if ((i <= 4) & ~sum(sum(mhi & binaries(:,:,i))))
                total = total-(i-1-fail);
                fail = i-1;
                mhi = double(binaries(:,:,i))/(total);
            elseif ((i >= num(3)-2) & ~sum(sum(mhi & binaries(:,:,i))))
                mhi = mhi*(total-i+fail)+2;
                total = total - (num(3)-i+1);
                mhi = mhi/total;
                break;
            elseif (i < num(3)-2);
                   mhi = mhi + double(binaries(:,:,i))/(total-(i-fail)+1);
            end
        end
        
        if(form == 2)
            mhi = mhi/max(max(mhi));
        end

    elseif form == 3;
        mhi = double(binaries(:,:,1));

        total = num(3);

        fail = 0;
        failEnd = 0;

        for i = 2:num(3)
            if ((i <= 4) & ~sum(sum(mhi & binaries(:,:,i))))
                mhi = double(binaries(:,:,i));
                total = total-(i-1-fail);
                fail = i-1;
            elseif ((i >= num(3)-2) & ~sum(sum(mhi & binaries(:,:,i))))
                total = total - (num(3)-i+1);
                break;
            elseif (i < num(3)-2);
                   mhi = mhi + double(binaries(:,:,i));
            end
        end

        mhi = mhi/total;
    elseif (form == 4)
        mhi = double(binaries(:,:,1));       
        total = num(3);
        fail = 0;
        failEnd = 0;

        for i = 2:num(3)
            if ((i <= 4) & ~sum(sum((mhi>0) & binaries(:,:,i))))
                mhi = double(binaries(:,:,i));
                total = total-(i-1-fail);
                fail = i-1;
            elseif ((i >= num(3)-2) & ~sum(sum((mhi>0) & binaries(:,:,i))))
                total = total - (num(3)-i+1);
                break;
            elseif (i < num(3)-2);
                mhi = mhi + double(binaries(:,:,i));
            end
        end
        
        mi = fail+1;
        ma = fail+total-1;
        
        mean = (mi+ma)/2;
        sd = (ma-mi)/2;
        
        mhi = zeros(num(1),num(2));
        for i = mi:ma
            coeff = gaussValue(mean, sd, i); 
            mhi = mhi + coeff*double(binaries(:,:,i));
        end
    elseif (form == 5)
        total = num(3);
        mean = (1+total)/2;
        sd = (total-1)/4;
        coeff = gaussValue(mean, sd, 1); 
        mhi = coeff*double(binaries(:,:,1));

        fail = 0;
        failEnd = 0;

        for i = 2:num(3)
            if ((i <= 4) & ~sum(sum((mhi>0) & binaries(:,:,i))))
                coeff = gaussValue(mean, sd, i); 
                mhi = coeff*double(binaries(:,:,i));
                total = total-(i-1-fail);
                fail = i-1;
            elseif ((i >= num(3)-2) & ~sum(sum((mhi>0) & binaries(:,:,i))))
                total = total - (num(3)-i+1);
                break;
            elseif (i < num(3)-2);
               coeff = gaussValue(mean, sd, i); 
               mhi = mhi + coeff*double(binaries(:,:,i));
            end
        end
    end
    
