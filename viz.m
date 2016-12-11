%% viz(birds, interval)
% --------------------
% Input: birds, a
function [] = viz(birdsList,interval)

side_length = 1;

  for i=1:interval:length(birdsList)

    for j=1:length(birdsList{i})
      rectangle('Position',...
                [birdsList{i}(j,1),...
                 birdsList{i}(j,2),...
                 side_length,...
                 side_length]);
    end

     xlim([0,100]);
     ylim([0,100]);

     w = waitforbuttonpress;
  end
end
