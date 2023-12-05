function column_pixels = draw_column(pixels, x, height, color)

     x = max(1, min(size(pixels, 2), x));

    height = min(size(pixels, 1), height);

    offset = max(1, floor((size(pixels, 1) - height) / 2));

    column_pixels = pixels;

    for y = offset:offset + height - 1
        column_pixels(y, x, 1) = color(1); % Red channel
        column_pixels(y, x, 2) = color(2); % Green channel
        column_pixels(y, x, 3) = color(3); % Blue channel
    end
end
