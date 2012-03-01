function [motionHistory] = motionHistoryImage(binaries)

	num = size(binaries);
	avg = double(binaries(:,:,1))

    total = num(3);

    fail = 0;
    failEnd = 0;

	for i = 2:num(3)
	    if ((i <= 4) & ~sum(sum(avg & binaries(:,:,i))))
    	    avg = double(binaries(:,:,i));
    	    total = total-(i-1-fail);
    	    fail = i-1;
        elseif ((i >= num-2) & sum(sum(avg & binaries(:,:,i))))
       		avg = avg + double(binaries(:,:,i));
        elseif ((i >= num-2) & ~sum(sum(avg & binaries(:,:,i))))
            total = total - (num(3)-i+1);
            break;
        elseif (i < num-2);
       		avg = avg + double(binaries(:,:,i));
        end
	end

	motionHistory = avg/total;
