function [matrix] = findpieces(img_name)
% img_name = input('Enter connect Four Image','s');
image = imread(img_name);
binary = imbinarize(rgb2gray(image), 'adaptive', 'ForegroundPolarity', 'dark', 'Sensitivity', 0.4);
connectedComponents = bwlabel(~binary);
props = regionprops(connectedComponents, 'BoundingBox');
rectangles = [];
for i = 1:numel(props)
    bbox = props(i).BoundingBox;
    area = bbox(3) * bbox(4);
    aspectRatio = bbox(3) / bbox(4);
    if aspectRatio > 0.8 && aspectRatio < 1.2
        if area >627425 & area<629425
            rectangles = bbox;
        end
    end
end
cropped_image = imcrop(binary,rectangles);
cropper_color_image = imcrop(image,rectangles);
tats = regionprops('table',cropped_image,'Centroid','MajorAxisLength','MinorAxisLength');
centers = tats.Centroid;
radii = mean([tats.MajorAxisLength tats.MinorAxisLength],2)./2;
index = radii>20 & radii<55;
centers = centers(index,:);
radii = radii(index);
centers = sortrows(centers,1);
matrix_loc_x = reshape(centers(:,1),[6,7]);
matrix_loc_y = reshape(centers(:,2),[6,7]);
matrix_loc_y = sort(matrix_loc_y);
for i = 1:6 % first row
    
    for j = 1:7
        X = round(matrix_loc_x(i,j));
        Y = round(matrix_loc_y(i,j));
        color = cropper_color_image(Y, X, :);
        color = reshape(color,[1,3]);
        if all(color>=200)
            matrix(i,j) = 0;
        elseif all(color(1:2) >= 200) & color(3)<= 50
            matrix(i,j) = 1;
        elseif all(color(2:3) >= 150) & color(1)<= 50
            matrix(i,j) = 2;
        end
    end
end      
end