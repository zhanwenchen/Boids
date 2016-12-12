%% viz(birds, interval)
% --------------------
% Input: birds, a
function [] = viz(birdsList,interval,side_length)

numBirds = size(birdsList{1},1);

% Check number of inputs.
% if nargin == 1
%     interval = 1;
%     side_length = 2;
% end

  for i=1:interval:length(birdsList)
    %% draw all birds in frame i
    for j=1:numBirds
      h = rectangle('Position',...
                [birdsList{i}(j,1) - 0.5 * side_length,...
                 birdsList{i}(j,2) - 0.5 * side_length,...
                 side_length,...
                 side_length]);
      h.FaceColor = [j/numBirds j/numBirds j/numBirds];

    end
    title(sprintf('Frame: %d',i));
    xlim([0,200]);
    ylim([0,200]);
    % axis equal;

    % fprintf('Waiting for any key to be pressed\n');
    w = waitforbuttonpress;
    clf;
  end
end
