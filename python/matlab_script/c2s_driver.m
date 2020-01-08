function c2s_driver
    YourData = imread('cameraman.tif');
      cmatrix = contour(YourData);
      shapedata = contour2shape(cmatrix);
      shapewrite(shapedata, 'camera_contours.shp');
  end
