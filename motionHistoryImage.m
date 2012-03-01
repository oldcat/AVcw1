function [motionHistory] = motionHistoryImage(binaries)

	num = size(binaries);
	avg = double(binaries(:,:,1));

    total = num(3);

	for i = 2:num(3)
	    if ((i <= 3) & ~sum(sum(avg & binaries(:,:,i))))
    	    avg = double(binaries(:,:,i));
    	    total = total-i+1;
        elseif ((i >= num-3) & ~sum(sum(avg & binaries(:,:,i))))
            total = total - (num-i+1);
            break;
        else
       		avg = avg + double(binaries(:,:,i));
        end
	end

	motionHistory = avg/total;
