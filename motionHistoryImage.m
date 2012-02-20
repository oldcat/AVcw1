function [motionHistory] = motionHistoryImage(binaries)

	num = size(binaries);
	avg = zeros(num(1),num(2));

	for i = 1:num(3)
		avg = avg + double(binaries(:,:,i));
	end

	motionHistory = avg/num(3);
