function BodyPlot(t,D,n,tt,h)
% BodyPlot(t,D,n,tt,h)
% t  = array with time
% D  = data to be plotted (columns)
% n  = number of bodies
% tt = string to subscript - usually '' or 'd' or 'dd'
% h  = handle for the window

figure(h)
for i=1:n
    subplot(2,n,i)
    hold on
        plot(t,D(:,i*3-2),'b-')
        plot(t,D(:,i*3-1),'r-')
    hold off
    grid on
    box on
    legend(['x_{',num2str(i),',',tt,'}'], ['y_{',num2str(i),',',tt,'}'])

    subplot(2,n,i+n)
    hold on
        plot(t,D(:,i*3),'m-')
    hold off
    grid on
    box on
    legend(['\phi_{',num2str(i),',',tt,'}'])
end
    