function [rockProps, paperProps, scissorsProps] = graphIt(props)
    paperProps = [props(:,:,1,1); props(:,:,1,2); props(:,:,1,3); props(:,:,2,2); props(:,:,2,5); props(:,:,3,7);props(:,:,3,8);props(:,:,3,9)]

    rockProps = [props(:,:,1,4); props(:,:,1,5); props(:,:,1,6); props(:,:,2,3); props(:,:,2,6); props(:,:,3,1);props(:,:,3,2);props(:,:,3,3)]

    scissorsProps = [props(:,:,1,7); props(:,:,1,8); props(:,:,1,9); props(:,:,2,1); props(:,:,2,4); props(:,:,3,4);props(:,:,3,5);props(:,:,3,6)]

    figure(1)
    hold on
    scatter3(scissorsProps(:,1),scissorsProps(:,2),scissorsProps(:,3),10,'blue')
    scatter3(rockProps(:,1),rockProps(:,2),rockProps(:,3),10,'red')
    scatter3(paperProps(:,1),paperProps(:,2),paperProps(:,3),10,'green')
    hold off
