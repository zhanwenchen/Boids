%% followLeader takes the current bird object and the leader bird
%  and returns goal velocity [vx vy]
function [goal] = followLeader(bird,leader,max_speed)

  dx = leader(1) - bird(1);
  dy = leader(2) - bird(2);
  ds = sqrt(dx^2 + dy^2); % distance
  vx = dx / ds * max_speed; % vx takes the same sign as dx
  vy = dy / ds * max_speed; % vy takes the same sign as dy
  goal = [vx vy];
end
