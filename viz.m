function [] = viz(birds,interval)

side_length = 1;

  for i=1:interval:length(birds)

    rectangle('Position',...
              [birds{i}(1)-0.5*side_length,
               birds{i}(2)-0.5*side_length,
               side_length]);
               side_length,
  end

  xlim([-10,10]);
  ylim([-10,10]);

end
