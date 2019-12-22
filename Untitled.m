% Example how to create and use this class:

  % load a predefined track called track01:
      [trackdata, x0, th0, w] = RaceTrack2.loadTrack_01();

  % init object:
%       track = RaceTrack2(trackdata, x0, th0, w);
trackr = RaceTrack2(trackdata, x0, th0, w);
  % plot track:
      track.plotTrack()

  % what is the coordinate of the track centerline, track radius and 
  % tangent angle for a centerline distance of 1000 meters ?
      [pos_c, psi_c, R_c] = track.getTrackInfo(1000)

  % lets say the vehicle is at position [10 1]' (in inertial coordinates)
      vehicle_pos = [35 -15]';

  % How far has the vehicle traveled along the centerline if the vehicle
  % position is [10 1]' ? (the reference used is the closest point in the track to the vehicle)
      vehicle_dist = track.getTrackDistance(vehicle_pos)

  % what is the lag and contour error for 2 meters ahead (along the track centerline)?
      targetTrackDist = vehicle_dist + 10;
      [lag_error, countour_error, offroad_error] = track.getVehicleDeviation(vehicle_pos, targetTrackDist)

  % lets verify visually if the calculation is correct!!
      track.plotTrack();
      hold on;
      sc1 = scatter(vehicle_pos(1), vehicle_pos(2), 50, 'filled', 'DisplayName','vehicle pos')
      [pos_c, psi_c, R_c] = track.getTrackInfo(vehicle_dist);
      sc2 = scatter(pos_c(1),pos_c(2), 50, 'filled', 'DisplayName','closest track point')
      [pos_cT, psi_cT, R_cT] = track.getTrackInfo(targetTrackDist);
      sc3 = scatter(pos_cT(1),pos_cT(2), 50, 'filled', 'DisplayName','target track point')
      legend([sc1,sc2,sc3])
 
      figure
      
for i=    100:1:187  
vehicle_pos=trackr.track_c(:,i);      
vehicle_dist = trackr.getTrackDistance(vehicle_pos);
[lag_error, countour_error, offroad_error] = trackr.getVehicleDeviation(vehicle_pos, vehicle_dist)
targetTrackDist = vehicle_dist +2;
[lag_error2, countour_error2, offroad_error2] = trackr.getVehicleDeviation(vehicle_pos, targetTrackDist);
[pos_c, psi_c, R_c] = trackr.getTrackInfo(targetTrackDist);
plot(i,lag_error2,'.')
hold on
end

 A_TI = [ cos(0)  -sin(0);    
                     sin(0)   cos(0)];
 A_TI = [ cos(pi)  -sin(pi);    
                     sin(pi)   cos(pi)];    
                 
                 figure
                 plot(trackr.dist)
                 
                 b = mod(90,90)
                 newpsi_c=track.dist(1:100); 
          for i =1:length(newpsi_c)
                     if rem(newpsi_c(i)/(pi/2),2)>0.0001 & mod(newpsi_c(i),pi/2)<0.0001
                        newpsi_c(i)=pi/2;
                     else
                         newpsi_c(i) = mod(newpsi_c(i),pi/2);
                     end
          end
                 
          a=trackr.track_c(:,180:250);
          for i=1:length(a)
          vehicle_dist = trackr.getTrackDistance(a(:,i));
          b=vehicle_dist+2
          [lag_error2, countour_error2, offroad_error2] = trackr.getVehicleDeviation(a(:,i), b);
          lag(i)=lag_error2;
          end