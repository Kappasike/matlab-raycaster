function [pixel_output] = render(pixels, map, player_x, player_y, player_dir, plane_x, plane_y)
    % does the raycast calculations
    player_dir_x = cos(player_dir);
    player_dir_y = sin(player_dir);
    for x=1:512
        map_x = floor(player_x);
        map_y = floor(player_y);

        camera_pos = 2.0 * x / 512.0 - 1.0;
        ray_angle_x = player_dir_x + plane_x * camera_pos;
        ray_angle_y = player_dir_y + plane_y * camera_pos;

        delta_dist_x = abs(1/ray_angle_x);
        delta_dist_y = abs(1/ray_angle_y);

        step_x = 0;
        step_y = 0;

        hit = 0;
        is_side = false;

        if ray_angle_x<0
            step_x = -1;
            side_dist_x = (player_x - map_x) * delta_dist_x;
        else
            step_x = 1;
            side_dist_x = (map_x + 1.0 - player_x) * delta_dist_x;
        end

        if ray_angle_y<0
            step_y = -1;
            side_dist_y = (player_y - map_y) * delta_dist_y;
        else
            step_y = 1;
            side_dist_y = (map_y + 1.0 - player_y) * delta_dist_y;
        end

        color = [1, 0, 0];

        while ~hit
            if side_dist_x < side_dist_y
                side_dist_x = side_dist_x + delta_dist_x;
                map_x = map_x + step_x;
                is_side = false;
            else
                side_dist_y = side_dist_y + delta_dist_y;
                map_y = map_y + step_y;
                is_side = true;
            end
            if map_x >= 1 && map_x <= size(map, 2) && map_y >= 1 && map_y <= size(map, 1)
                hit = map(map_y, map_x) ~= 0;
            end
        end

        dist_to_wall = side_dist_x - delta_dist_x;

        if is_side
            color = [0.5, 0, 0];
            dist_to_wall = side_dist_y - delta_dist_y;
        end
        
        height = floor(512/dist_to_wall);
        
        pixels = draw_column(pixels, x, height, color);

        %pixels(:,x,:) = repmat(color, 512, 1);
    end
    pixel_output = pixels;
end