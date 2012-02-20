function [motionHistory] = motionHistoryImage(binaries)

	num = size(binaries)
	avg = image(size(binaries(1))

	for i = 1:num
		avg = avg + binaries(i)
	end

	motionHistory = avg/num
