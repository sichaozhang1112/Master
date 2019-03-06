%% 
[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);
Color = 'r';

%%
fid = figure;
hold on
% xlim([0.8 1.8]);

writerObj = VideoWriter('out.avi'); % Name it.
writerObj.FrameRate = 1; % How many frames per second.
open(writerObj); 
lin = linspace(0,1,10);
for ii=1:10:3000   
    clf
    % We just use pause but pretend you have some really complicated thing here...
%     pause(0.1);
    figure(fid); % Makes sure you use your desired frame.
    plot(lin*8,zeros(10,1),'k')
    hold on
    axis equal
    axis([0,8,-0.05,1.8]);
    lin = linspace(0,1,10);
    scatter(head(ii,1),head(ii,2),'k');
    hold on;
    scatter(waist(ii,1),waist(ii,2),'k');
    hold on;
    scatter(hip(ii,1),hip(ii,2),'k');
    hold on;
    scatter(knee_right(ii,1),knee_right(ii,2),'k');
    hold on;
    scatter(ankle_right(ii,1),ankle_right(ii,2),'k');
    hold on;
    scatter(knee_left(ii,1),knee_left(ii,2),'k');
    hold on;
    scatter(ankle_left(ii,1),ankle_left(ii,2),'k');
    hold on;
    plot(waist(ii,1)+(head(ii,1)-waist(ii,1))*lin,waist(ii,2)+(head(ii,2)-waist(ii,2))*lin,Color);
    hold on;
    plot(hip(ii,1)+(waist(ii,1)-hip(ii,1))*lin,hip(ii,2)+(waist(ii,2)-hip(ii,2))*lin,Color);
    hold on;
    plot(knee_right(ii,1)+(hip(ii,1)-knee_right(ii,1))*lin,knee_right(ii,2)+(hip(ii,2)-knee_right(ii,2))*lin,Color);
    hold on;
    plot(ankle_right(ii,1)+(knee_right(ii,1)-ankle_right(ii,1))*lin,ankle_right(ii,2)+(knee_right(ii,2)-ankle_right(ii,2))*lin,Color);
    hold on;
    plot(toe_right(ii,1)+(ankle_right(ii,1)-toe_right(ii,1))*lin,toe_right(ii,2)+(ankle_right(ii,2)-toe_right(ii,2))*lin,Color);
    hold on;
    plot(heel_right(ii,1)+(ankle_right(ii,1)-heel_right(ii,1))*lin,heel_right(ii,2)+(ankle_right(ii,2)-heel_right(ii,2))*lin,Color);
    hold on;
    plot(toe_right(ii,1)+(heel_right(ii,1)-toe_right(ii,1))*lin,toe_right(ii,2)+(heel_right(ii,2)-toe_right(ii,2))*lin,Color);
    hold on;
    plot(knee_left(ii,1)+(hip(ii,1)-knee_left(ii,1))*lin,knee_left(ii,2)+(hip(ii,2)-knee_left(ii,2))*lin,Color);
    hold on;
    plot(ankle_left(ii,1)+(knee_left(ii,1)-ankle_left(ii,1))*lin,ankle_left(ii,2)+(knee_left(ii,2)-ankle_left(ii,2))*lin,Color);
    hold on;
    plot(toe_left(ii,1)+(ankle_left(ii,1)-toe_left(ii,1))*lin,toe_left(ii,2)+(ankle_left(ii,2)-toe_left(ii,2))*lin,Color);
    hold on;
    plot(heel_left(ii,1)+(ankle_left(ii,1)-heel_left(ii,1))*lin,heel_left(ii,2)+(ankle_left(ii,2)-heel_left(ii,2))*lin,Color);
    hold on;
    plot(toe_left(ii,1)+(heel_left(ii,1)-toe_left(ii,1))*lin,toe_left(ii,2)+(heel_left(ii,2)-toe_left(ii,2))*lin,Color);
    hold on;

    frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
    writeVideo(writerObj, frame);
    %end
end
hold off
close(writerObj); % Saves the movie.