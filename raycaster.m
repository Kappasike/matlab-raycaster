global player_x;
global player_y;
global player_dir;
global plane_x;
global plane_y;
global ROT_SPEED;
global MOVEMENT_SPEED;
global map;

ROT_SPEED = 0.14;
MOVEMENT_SPEED = 0.06;
player_x = 4.0;
player_y = 3.5;
player_dir = -3.14159;
plane_x = 0.0;
plane_y = 0.66;

map = [...
    1 1 1 1 1 1 1 1;
    1 0 0 1 1 0 0 1;
    1 0 0 0 0 0 0 1;
    1 1 0 0 0 0 0 1;
    1 0 0 0 0 1 0 1;
    1 0 1 1 1 1 0 1;
    1 0 1 0 0 0 0 1;
    1 1 1 1 1 1 1 1;
];

fig = figure;

set(fig, 'KeyPressFcn', @(src, event) keyPressCallback(event));

while ishandle(fig)
    pixels = ones(512, 512, 3) * 0.3;
    pixels(1:256, :, :) = repmat(reshape([0.6, 0.8, 1], [1, 1, 3]), 256, 512);
    pixels = render(pixels, map, player_x, player_y, player_dir, plane_x, plane_y);
    
    imshow(pixels);
    drawnow;
end

function keyPressCallback(event)
    global player_x;
    global player_y;
    global player_dir;
    global plane_x;
    global plane_y;
    global ROT_SPEED;
    global MOVEMENT_SPEED;
    global map;

    keyPressed = event.Key;

    switch keyPressed
        case 'w'
            new_x = player_x+cos(player_dir) * MOVEMENT_SPEED;
            new_y = player_y+sin(player_dir) * MOVEMENT_SPEED;
            if map(floor(new_x), floor(new_y)) == 0
                player_x = new_x;
                player_y = new_y;
            end
        case 's'
            new_x = player_x-cos(player_dir) * MOVEMENT_SPEED;
            new_y = player_y-sin(player_dir) * MOVEMENT_SPEED;
            if map(floor(new_x), floor(new_y)) == 0
                player_x = new_x;
                player_y = new_y;
            end
        case 'a'
            new_x = player_x+cos(player_dir+1.5708) * MOVEMENT_SPEED;
            new_y = player_y+sin(player_dir+1.5708) * MOVEMENT_SPEED;
            if map(floor(new_x), floor(new_y)) == 0
                player_x = new_x;
                player_y = new_y;
            end
        case 'd'
            new_x = player_x-cos(player_dir+1.5708) * MOVEMENT_SPEED;
            new_y = player_y-sin(player_dir+1.5708) * MOVEMENT_SPEED;
            if map(floor(new_x), floor(new_y)) == 0
                player_x = new_x;
                player_y = new_y;
            end
        case 'q'
            player_dir = player_dir + ROT_SPEED;
            new_plane_x = plane_x * cos(ROT_SPEED) - plane_y * sin(ROT_SPEED);
            new_plane_y = plane_x * sin(ROT_SPEED) + plane_y * cos(ROT_SPEED);
            plane_x = new_plane_x;
            plane_y = new_plane_y;
        case 'e'
            player_dir = player_dir - ROT_SPEED;
            new_plane_x = plane_x * cos(-ROT_SPEED) - plane_y * sin(-ROT_SPEED);
            new_plane_y = plane_x * sin(-ROT_SPEED) + plane_y * cos(-ROT_SPEED);
            plane_x = new_plane_x;
            plane_y = new_plane_y;
    end
end

