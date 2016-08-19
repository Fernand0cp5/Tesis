sys = 'watertank';
load_system(sys)
sys_io(1) = linio('watertank/PID Controller',1,'input');
sys_io(2) = linio('watertank/Water-Tank System',1,'openoutput');
tsnapshot = 20;
linsys = linearize(sys,sys_io,tsnapshot);
bdclose(sys)
bode(linsys)
