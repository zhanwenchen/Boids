%% dBirds takes the current frame birds object
function [d] = dBirds(birds,side_length,max_speed,sky_xlim,sky_ylim,leader_id)
  numBirds = size(birds,1);


  %% Randomization funcs
  rand_sign = @(n) ones(n, 1) - floor(rand(n,1)*2)*2; % pick -1 or 1, n by 1
  rand_speed = @(n) (rand(n,1) - 0.5) * 2 * max_speed; % [-max_speed, max_speed]

  %% Each bird
  for i=1:numBirds

    bird = birds(i,:); % bird = [x, y, v_x, v_y]
    % leader = birds(leader_id,:);
    % leader_id
    % birds(leader_id,:)
    goal = followLeader(bird,birds(leader_id,:),max_speed);
    x = bird(1);
    y = bird(2);
    v_x = bird(3);
    v_y = bird(4);
    % fprintf('calling followLeader([%4.2f], [%4.2f], %4.2f)\n',bird,leader,max_speed);
    % goal = followLeader(bird,leader,max_speed);
    % disp(bird);
    % disp(leader);
    % v_x = goal(1);
    % v_y = goal(2);

    this_left = x - 0.5*side_length;
    this_right = x + 0.5*side_length;
    this_top = y + 0.5*side_length;
    this_bottom = y - 0.5*side_length;

    collide_with_sky_x = @(v_x) (this_right+v_x > sky_xlim) | (this_left+v_x < 0);
    collide_with_sky_y = @(v_y) (this_top+v_y > sky_ylim) | (this_bottom+v_y < 0);

    %% Collision detection and handling with other birds
    for j=[1:(i-1),(i+1):numBirds] % skip j=i without if
      other = birds(j,:);

      other_left = other(1) - 0.5*side_length;
      other_right = other(1) + 0.5*side_length;
      other_top = other(2) + 0.5*side_length;
      other_bottom = other(2) - 0.5*side_length;

      collide_with_other_right = @(v_x) (v_x >= 0)... % moving right
          & (x <= other(1))... % this bird's center is to the left of other
          & ((this_top+v_y) >= other_bottom) & ((this_bottom+v_y) <= other_top)... % this
          & ((this_right+v_x) >= other_left);

      collide_with_other_left = @(v_x) (v_x <= 0)... % moving left
          & (other(1) <= x)... % this bird's center is to the right of other
          & ((this_top+v_y) >= other_bottom) & ((this_bottom+v_y) <= other_top)... % this
          & ((this_left+v_x) <= other_right);

      collide_with_other_top = @(v_y) (v_y >= 0) ... % moving up
          & (y < other(2)) ... % this bird's center is to the bottom of other
          & ((this_left+v_x) <= other_right) & ((this_right+v_x) >= other_left) ... % this
          & ((this_top+v_y) >= other_bottom);

      collide_with_other_bottom = @(v_y) (v_y < 0) ... % moving down
          & (y > other(2)) ... % this bird's center is to the bottom of other
          & ((this_left+v_x) <= other_right) & ((this_right+v_x) >= other_left) ... % this
          & ((this_bottom+v_y) <= other_top);

      % Strict
      % This bird's right border collides with left border of other bird
      while collide_with_sky_x(v_x) | (collide_with_other_right(v_x) | collide_with_other_left(v_x))
        v_x = -(v_x ./ abs(v_x)) * rand_speed(1); % flip sign, rand magnitude
        % fprintf('Collision in x');
        % v_x = v_x * 0.9;
      end

      while collide_with_sky_y(v_y) | (collide_with_other_top(v_y) | collide_with_other_bottom(v_y))
        % fprintf('Collision in y');
        v_y = -(v_y ./ abs(v_y)) * rand_speed(1);
        % v_y = v_y * 0.9;
      end

    end
    d(i,:) = [v_x, v_y, v_x-bird(3), v_y-bird(4)];
  end
end
