clear

Si=1; O=2;

x(1).x = load('/home/jason/disorder/si/amor/init216.xyz.matlab');
x(2).x = load('/home/jason/disorder/si/amor/a288.xyz.matlab');

plot3(...
    x(1).x(:,2),x(1).x(:,3),x(1).x(:,4),'.',...
    x(2).x(:,2),x(2).x(:,3),x(2).x(:,4),'.'...
    )
pause
[I(1).I I(1).J] = find(...
    x(1).x(:,2) < max(x(1).x(:,2))/1.5 &...
    x(1).x(:,3) < max(x(1).x(:,3))/1.5 &...
    x(1).x(:,4) < max(x(1).x(:,4))/3.0) ;

plot3(...
    x(1).x(I(1).I,2),x(1).x(I(1).I,3),x(1).x(I(1).I,4),'.')
pause
[I(2).I I(2).J] = find(...
    x(2).x(:,2) < max(x(2).x(:,2))/1.5 &...
    x(2).x(:,3) < max(x(2).x(:,3))/1.5 &...
    x(2).x(:,4) < max(x(2).x(:,4))/3.5) ;

plot3(...
    x(2).x(I(2).I,2),x(2).x(I(2).I,3),x(2).x(I(2).I,4),'.')


