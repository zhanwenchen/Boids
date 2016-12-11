%% viz(birds, interval)
% --------------------
% Input: birds, a
function [] = viz(birdsList,interval)

% Check number of inputs.
if nargin == 1
    interval = 1;
end

side_length = 1;

  for i=1:interval:length(birdsList)
    %% draw all birds in frame i
    for j=1:length(birdsList{i})
      fprintf('Drawing \n')
      rectangle('Position',...
                [birdsList{i}(j,1),...
                 birdsList{i}(j,2),...
                 side_length,...
                 side_length]);
    end
    title(sprintf('Frame: %d',i));
    xlim([0,200]);
    ylim([0,200]);

    fprintf('Waiting for any key to be pressed\n');
    w = waitforbuttonpress;
    clf;
  end
end
