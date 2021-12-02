clear; close all;

%% GUI Component
v = get(0, 'MonitorPositions');
XMIN = v(1, 3)*0.05; YMIN = v(1, 4)*0.1;
WIDTH = v(1, 3)*0.4; HEIGHT = v(1, 4)*0.4;
H.H0 = figure(...
    "Position", [XMIN YMIN WIDTH HEIGHT]);

xm = WIDTH*0.05; ym = HEIGHT - 40;
w = 100; h = 30;
H.B1 = uicontrol(...
    "Style", "togglebutton",...
    "Position", [xm ym w h],...
    "String", "Stop",...
    "FontSize", 14);

%% DSP
Fs = 192000;
fl = 1024;
aDR = audioDeviceReader(...
    'Driver', 'DirectSound',...
    'Device', 'CABLE Output (VB-Audio Virtual Cable)',...
    'SampleRate', Fs,...
    'SamplesPerFrame', fl,...
    'NumChannels', 2);
aDW = audioDeviceWriter(...
    'Driver', 'ASIO',...
    'Device', 'QUAD-CAPTURE',...
    'SampleRate', Fs);

NFFT = 2048;
df = 1/Fs;
freqAxis = 0:df:Fs-df;
freqArray = [25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
NumBands = 8;
while ~H.B1.Value
    sig = aDR();



    underrun = aDW(sig);
    drawnow
end
H.B1.Value = 0;

release(aDR)
release(aDW)