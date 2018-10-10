function varargout = Blur_kernel_1(varargin)
% BLUR_KERNEL_1 MATLAB code for Blur_kernel_1.fig
%      BLUR_KERNEL_1, by itself, creates a new BLUR_KERNEL_1 or raises the existing
%      singleton*.
%
%      H = BLUR_KERNEL_1 returns the handle to a new BLUR_KERNEL_1 or the handle to
%      the existing singleton*.
%
%      BLUR_KERNEL_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BLUR_KERNEL_1.M with the given input arguments.
%
%      BLUR_KERNEL_1('Property','Value',...) creates a new BLUR_KERNEL_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Blur_kernel_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Blur_kernel_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Blur_kernel_1

% Last Modified by GUIDE v2.5 10-Oct-2018 10:28:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Blur_kernel_1_OpeningFcn, ...
                   'gui_OutputFcn',  @Blur_kernel_1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Blur_kernel_1 is made visible.
function Blur_kernel_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Blur_kernel_1 (see VARARGIN)

% Choose default command line output for Blur_kernel_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Blur_kernel_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Blur_kernel_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in blur1.
function blur1_Callback(hObject, eventdata, handles)
% hObject    handle to blur1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img imgBlur_1 blur_1 redBlur_1 greenBlur_1 blueBlur_1 redChannel greenChannel blueChannel blur_1_ft;

redChannel = img(:,:,1);
greenChannel = img(:,:,2);
blueChannel = img(:,:,3);

blur_1 = imread('Kernel1G.png');
blur_1 = double(blur_1);
blur_1 = blur_1(30:48,26:44);

[h, w] = size(redChannel);
blur_1_big = zeros(h, w);
blur_1_big(1:19, 1:19) = blur_1;
blur_1_ft = fft2(blur_1_big);

redBlur_1_ft = fft2(double(redChannel)) .* blur_1_ft;
greenBlur_1_ft = fft2(double(greenChannel)) .* blur_1_ft;
blueBlur_1_ft = fft2(double(blueChannel)) .* blur_1_ft;

redBlur_1 = ifft2(redBlur_1_ft);
greenBlur_1 = ifft2(greenBlur_1_ft);
blueBlur_1 = ifft2(blueBlur_1_ft);

redBlur_1 = ((255/max(redBlur_1(:))).*(redBlur_1));
greenBlur_1 = ((255/max(greenBlur_1(:))).*(greenBlur_1));
blueBlur_1 = ((255/max(blueBlur_1(:))).*(blueBlur_1));

imgBlur_1 = cat(3, uint8(redBlur_1), uint8(greenBlur_1), uint8(blueBlur_1));

imgBlur_1 = imnoise(imgBlur_1, 'gaussian');

redBlur_1 = imgBlur_1(:,:,1);
greenBlur_1 = imgBlur_1(:,:,2);
blueBlur_1 = imgBlur_1(:,:,3);

axes(handles.axes2);
imshow(imgBlur_1);
imwrite(imgBlur_1, 'blur_1.png');
psnr_val = psnr(imgBlur_1, img);
set(handles.blur_psnr, 'String', num2str(psnr_val));
ssim_val = ssim(imgBlur_1(100:400, 150:600), img(100:400, 150:600));
set(handles.blur_ssim, 'String', num2str(ssim_val));

% --- Executes on button press in blur2.
function blur2_Callback(hObject, eventdata, handles)
% hObject    handle to blur2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img imgBlur_2 blur_2 redBlur_2 greenBlur_2 blueBlur_2 blur_2_ft;

redChannel = img(:,:,1);
greenChannel = img(:,:,2);
blueChannel = img(:,:,3);

blur_2 = imread('Kernel2G.png');
blur_2 = double(blur_2);
blur_2 = blur_2(21:35,27:41);

[h, w] = size(redChannel);
blur_2_big = zeros(h, w);
blur_2_big(1:15, 1:15) = blur_2;
blur_2_ft = fft2(blur_2_big);

redBlur_2_ft = fft2(double(redChannel)) .* blur_2_ft;
greenBlur_2_ft = fft2(double(greenChannel)) .* blur_2_ft;
blueBlur_2_ft = fft2(double(blueChannel)) .* blur_2_ft;

redBlur_2 = ifft2(redBlur_2_ft);
greenBlur_2 = ifft2(greenBlur_2_ft);
blueBlur_2 = ifft2(blueBlur_2_ft);

redBlur_2 = ((255/max(redBlur_2(:))).*(redBlur_2));
greenBlur_2 = ((255/max(greenBlur_2(:))).*(greenBlur_2));
blueBlur_2 = ((255/max(blueBlur_2(:))).*(blueBlur_2));

imgBlur_2 = cat(3, uint8(redBlur_2), uint8(greenBlur_2), uint8(blueBlur_2));

imgBlur_2 = imnoise(imgBlur_2, 'gaussian');

redBlur_2 = imgBlur_2(:,:,1);
greenBlur_2 = imgBlur_2(:,:,2);
blueBlur_2 = imgBlur_2(:,:,3);

axes(handles.axes2);
imshow(imgBlur_2);
imwrite(imgBlur_2, 'blur_2.png');
psnr_val = psnr(imgBlur_2, img);
set(handles.blur_psnr, 'String', num2str(psnr_val));
ssim_val = ssim(imgBlur_2(100:400, 150:600), img(100:400, 150:600));
set(handles.blur_ssim, 'String', num2str(ssim_val));


% --- Executes on button press in blur3.
function blur3_Callback(hObject, eventdata, handles)
% hObject    handle to blur3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img imgBlur_3 blur_3 redBlur_3 greenBlur_3 blueBlur_3 blur_3_ft;

redChannel = img(:,:,1);
greenChannel = img(:,:,2);
blueChannel = img(:,:,3);

blur_3 = imread('Kernel3G.png');
blur_3 = double(blur_3);
blur_3 = blur_3(25:35,34:44);

[h, w] = size(redChannel);
blur_3_big = zeros(h, w);
blur_3_big(1:11, 1:11) = blur_3;
blur_3_ft = fft2(blur_3_big);

redBlur_3_ft = fft2(double(redChannel)) .* blur_3_ft;
greenBlur_3_ft = fft2(double(greenChannel)) .* blur_3_ft;
blueBlur_3_ft = fft2(double(blueChannel)) .* blur_3_ft;

redBlur_3 = ifft2(redBlur_3_ft);
greenBlur_3 = ifft2(greenBlur_3_ft);
blueBlur_3 = ifft2(blueBlur_3_ft);

redBlur_3 = ((255/max(redBlur_3(:))).*(redBlur_3));
greenBlur_3 = ((255/max(greenBlur_3(:))).*(greenBlur_3));
blueBlur_3 = ((255/max(blueBlur_3(:))).*(blueBlur_3));

imgBlur_3 = cat(3, uint8(redBlur_3), uint8(greenBlur_3), uint8(blueBlur_3));

imgBlur_3 = imnoise(imgBlur_3, 'gaussian');

redBlur_3 = imgBlur_3(:,:,1);
greenBlur_3 = imgBlur_3(:,:,2);
blueBlur_3 = imgBlur_3(:,:,3);

axes(handles.axes2);
imshow(imgBlur_3);
imwrite(imgBlur_3, 'blur_3.png');
psnr_val = psnr(imgBlur_3, img);
set(handles.blur_psnr, 'String', num2str(psnr_val));
ssim_val = ssim(imgBlur_3(100:400, 150:600), img(100:400, 150:600));
set(handles.blur_ssim, 'String', num2str(ssim_val));



% --- Executes on button press in blur4.
function blur4_Callback(hObject, eventdata, handles)
% hObject    handle to blur4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img imgBlur_4 blur_4 redBlur_4 greenBlur_4 blueBlur_4 blur_4_ft;

redChannel = img(:,:,1);
greenChannel = img(:,:,2);
blueChannel = img(:,:,3);

blur_4 = imread('Kernel4G.png');
blur_4 = double(blur_4);
blur_4 = blur_4(24:36,34:46);

[h, w] = size(redChannel);
blur_4_big = zeros(h, w);
blur_4_big(1:13, 1:13) = blur_4;
blur_4_ft = fft2(blur_4_big);

redBlur_4_ft = fft2(double(redChannel)) .* blur_4_ft;
greenBlur_4_ft = fft2(double(greenChannel)) .* blur_4_ft;
blueBlur_4_ft = fft2(double(blueChannel)) .* blur_4_ft;

redBlur_4 = ifft2(redBlur_4_ft);
greenBlur_4 = ifft2(greenBlur_4_ft);
blueBlur_4 = ifft2(blueBlur_4_ft);

redBlur_4 = ((255/max(redBlur_4(:))).*(redBlur_4));
greenBlur_4 = ((255/max(greenBlur_4(:))).*(greenBlur_4));
blueBlur_4 = ((255/max(blueBlur_4(:))).*(blueBlur_4));

imgBlur_4 = cat(3, uint8(redBlur_4), uint8(greenBlur_4), uint8(blueBlur_4));
imgBlur_4 = imnoise(imgBlur_4, 'gaussian');

redBlur_4 = imgBlur_4(:,:,1);
greenBlur_4 = imgBlur_4(:,:,2);
blueBlur_4 = imgBlur_4(:,:,3);

axes(handles.axes2);
imshow(imgBlur_4);
imwrite(imgBlur_4, 'blur_4.png');
psnr_val = psnr(imgBlur_4, img);
set(handles.blur_psnr, 'String', num2str(psnr_val));
ssim_val = ssim(imgBlur_4(100:400, 150:600), img(100:400, 150:600));
set(handles.blur_ssim, 'String', num2str(ssim_val));



% --- Executes on button press in loadbutton.
function loadbutton_Callback(hObject, eventdata, handles)
% hObject    handle to loadbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
image_file = imgetfile();
img = imread(image_file);
redChannel = img(:,:,1);
greenChannel = img(:,:,2);
blueChannel = img(:,:,3);

redChannel = ((255/max(redChannel(:))).*(redChannel));
greenChannel = ((255/max(greenChannel(:))).*(greenChannel));
blueChannel = ((255/max(blueChannel(:))).*(blueChannel));

img = cat(3, uint8(redChannel), uint8(greenChannel), uint8(blueChannel));

axes(handles.axes1);
imshow(img);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

image_file = get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function loadbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in invblur1.
function invblur1_Callback(hObject, eventdata, handles)
% hObject    handle to invblur1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blur_1_ft inv_blur_1_ft imgDeblur_1 redBlur_1 greenBlur_1 blueBlur_1 imgDeblur redChannel;

[h, w] = size(redChannel);
inv_blur_1_ft = zeros(h, w);
for i=1:h
    for j=1:w
        if abs(blur_1_ft(i,j)) > 0
            inv_blur_1_ft(i,j) = 1/(blur_1_ft(i,j));
        else
            inv_blur_1_ft(i,j) = 0;
        end
    end
end

redDeblur_1_ft = fft2(redBlur_1) .* inv_blur_1_ft;
greenDeblur_1_ft = fft2(greenBlur_1) .* inv_blur_1_ft;
blueDeblur_1_ft = fft2(blueBlur_1) .* inv_blur_1_ft;

redDeblur_1 = ifft2(redDeblur_1_ft);
greenDeblur_1 = ifft2(greenDeblur_1_ft);
blueDeblur_1 = ifft2(blueDeblur_1_ft);

redDeblur_1 = (255/max(redDeblur_1(:))).* redDeblur_1;
greenDeblur_1 = (255/max(greenDeblur_1(:))).* greenDeblur_1;
blueDeblur_1 = (255/max(blueDeblur_1(:))).* blueDeblur_1;

imgDeblur_1 = cat(3, uint8(redDeblur_1), uint8(greenDeblur_1), uint8(blueDeblur_1));
imgDeblur = imgDeblur_1;
axes(handles.axes3);
imshow(imgDeblur_1);
imwrite(imgDeblur_1, 'fullinv_1.png');



% --- Executes on button press in invblur2.
function invblur2_Callback(hObject, eventdata, handles)
% hObject    handle to invblur2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blur_2_ft inv_blur_2_ft imgDeblur_2 redBlur_2 greenBlur_2 blueBlur_2 imgDeblur redChannel;

[h, w] = size(redChannel);
inv_blur_2_ft = zeros(h, w);

for i=1:h
    for j=1:w
        if abs(blur_2_ft(i,j)) > 0
            inv_blur_2_ft(i,j) = 1/(blur_2_ft(i,j));
        else
            inv_blur_2_ft(i,j) = 0;
        end
    end
end

redDeblur_2_ft = fft2(redBlur_2) .* inv_blur_2_ft;
greenDeblur_2_ft = fft2(greenBlur_2) .* inv_blur_2_ft;
blueDeblur_2_ft = fft2(blueBlur_2) .* inv_blur_2_ft;

redDeblur_2 = ifft2(redDeblur_2_ft);
greenDeblur_2 = ifft2(greenDeblur_2_ft);
blueDeblur_2 = ifft2(blueDeblur_2_ft);

redDeblur_2 = (255/max(redDeblur_2(:))).* redDeblur_2;
greenDeblur_2 = (255/max(greenDeblur_2(:))).* greenDeblur_2;
blueDeblur_2 = (255/max(blueDeblur_2(:))).* blueDeblur_2;

imgDeblur_2 = cat(3, uint8(redDeblur_2), uint8(greenDeblur_2), uint8(blueDeblur_2));
imgDeblur = imgDeblur_2;
axes(handles.axes3);
imshow(imgDeblur_2);
imwrite(imgDeblur_2, 'fullinv_2.png');




% --- Executes on button press in invblur3.
function invblur3_Callback(hObject, eventdata, handles)
% hObject    handle to invblur3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blur_3_ft inv_blur_3_ft imgDeblur_3 redBlur_3 greenBlur_3 blueBlur_3 imgDeblur redChannel;

[h, w] = size(redChannel);
inv_blur_3_ft = zeros(h, w);

for i=1:h
    for j=1:w
        if abs(blur_3_ft(i,j)) > 0
            inv_blur_3_ft(i,j) = 1/(blur_3_ft(i,j));
        else
            inv_blur_3_ft(i,j) = 0;
        end
    end
end

redDeblur_3_ft = fft2(redBlur_3) .* inv_blur_3_ft;
greenDeblur_3_ft = fft2(greenBlur_3) .* inv_blur_3_ft;
blueDeblur_3_ft = fft2(blueBlur_3) .* inv_blur_3_ft;

redDeblur_3 = ifft2(redDeblur_3_ft);
greenDeblur_3 = ifft2(greenDeblur_3_ft);
blueDeblur_3 = ifft2(blueDeblur_3_ft);

redDeblur_3 = (255/max(redDeblur_3(:))).* redDeblur_3;
greenDeblur_3 = (255/max(greenDeblur_3(:))).* greenDeblur_3;
blueDeblur_3 = (255/max(blueDeblur_3(:))).* blueDeblur_3;

imgDeblur_3 = cat(3, uint8(redDeblur_3), uint8(greenDeblur_3), uint8(blueDeblur_3));
imgDeblur = imgDeblur_3;
axes(handles.axes3);
imshow(imgDeblur_3);
imwrite(imgDeblur_3, 'fullinv_3.png');



% --- Executes on button press in invblur4.
function invblur4_Callback(hObject, eventdata, handles)
% hObject    handle to invblur4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blur_4_ft inv_blur_4_ft redChannel imgDeblur_4 redBlur_4 greenBlur_4 blueBlur_4 imgDeblur;

[h, w] = size(redChannel);
inv_blur_4_ft = zeros(h, w);

for i=1:h
    for j=1:w
        if abs(blur_4_ft(i,j)) > 0
            inv_blur_4_ft(i,j) = 1/(blur_4_ft(i,j));
        else
            inv_blur_4_ft(i,j) = 0;
        end
    end
end

redDeblur_4_ft = fft2(redBlur_4) .* inv_blur_4_ft;
greenDeblur_4_ft = fft2(greenBlur_4) .* inv_blur_4_ft;
blueDeblur_4_ft = fft2(blueBlur_4) .* inv_blur_4_ft;

redDeblur_4 = ifft2(redDeblur_4_ft);
greenDeblur_4 = ifft2(greenDeblur_4_ft);
blueDeblur_4 = ifft2(blueDeblur_4_ft);

redDeblur_4 = (255/max(redDeblur_4(:))).* redDeblur_4;
greenDeblur_4 = (255/max(greenDeblur_4(:))).* greenDeblur_4;
blueDeblur_4 = (255/max(blueDeblur_4(:))).* blueDeblur_4;

imgDeblur_4 = cat(3, uint8(redDeblur_4), uint8(greenDeblur_4), uint8(blueDeblur_4));
imgDeblur = imgDeblur_4;
axes(handles.axes3);
imshow(imgDeblur_4);
imwrite(imgDeblur_4, 'fullinv_4.png');


% --- Executes on button press in trunc1.
function trunc1_Callback(hObject, eventdata, handles)
% hObject    handle to trunc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blur_1_ft inv_blur_1_ft redChannel imgDeblur_1 redBlur_1 greenBlur_1 blueBlur_1 slider1 imgDeblur;

[h, w] = size(redChannel);
inv_blur_1_ft = zeros(h, w);

for i=1:h
    for j=1:w
        if abs(blur_1_ft(i,j)) > slider1
            inv_blur_1_ft(i,j) = 1/(blur_1_ft(i,j));
        else
            inv_blur_1_ft(i,j) = 0;
        end
    end
end

redDeblur_1_ft = fft2(redBlur_1) .* inv_blur_1_ft;
greenDeblur_1_ft = fft2(greenBlur_1) .* inv_blur_1_ft;
blueDeblur_1_ft = fft2(blueBlur_1) .* inv_blur_1_ft;

redDeblur_1 = ifft2(redDeblur_1_ft);
greenDeblur_1 = ifft2(greenDeblur_1_ft);
blueDeblur_1 = ifft2(blueDeblur_1_ft);

redDeblur_1 = (255/max(redDeblur_1(:))).* redDeblur_1;
greenDeblur_1 = (255/max(greenDeblur_1(:))).* greenDeblur_1;
blueDeblur_1 = (255/max(blueDeblur_1(:))).* blueDeblur_1;

imgDeblur_1 = cat(3, uint8(redDeblur_1), uint8(greenDeblur_1), uint8(blueDeblur_1));
imgDeblur = imgDeblur_1;
axes(handles.axes3);
imshow(imgDeblur_1);
imwrite(imgDeblur_1, 'truncinv_1.png');



% --- Executes on button press in trunc2.
function trunc2_Callback(hObject, eventdata, handles)
% hObject    handle to trunc2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blur_2_ft inv_blur_2_ft redChannel imgDeblur_2 redBlur_2 greenBlur_2 blueBlur_2 slider2 imgDeblur;

[h, w] = size(redChannel);
inv_blur_2_ft = zeros(h, w);

for i=1:h
    for j=1:w
        if abs(blur_2_ft(i,j)) > slider2
            inv_blur_2_ft(i,j) = 1/(blur_2_ft(i,j));
        else
            inv_blur_2_ft(i,j) = 0;
        end
    end
end

redDeblur_2_ft = fft2(redBlur_2) .* inv_blur_2_ft;
greenDeblur_2_ft = fft2(greenBlur_2) .* inv_blur_2_ft;
blueDeblur_2_ft = fft2(blueBlur_2) .* inv_blur_2_ft;

redDeblur_2 = ifft2(redDeblur_2_ft);
greenDeblur_2 = ifft2(greenDeblur_2_ft);
blueDeblur_2 = ifft2(blueDeblur_2_ft);

redDeblur_2 = (255/max(redDeblur_2(:))).* redDeblur_2;
greenDeblur_2 = (255/max(greenDeblur_2(:))).* greenDeblur_2;
blueDeblur_2 = (255/max(blueDeblur_2(:))).* blueDeblur_2;

imgDeblur_2 = cat(3, uint8(redDeblur_2), uint8(greenDeblur_2), uint8(blueDeblur_2));
imgDeblur = imgDeblur_2;
axes(handles.axes3);
imshow(imgDeblur_2);
imwrite(imgDeblur_2, 'truncinv_2.png');



% --- Executes on button press in trunc3.
function trunc3_Callback(hObject, eventdata, handles)
% hObject    handle to trunc3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blur_3_ft inv_blur_3_ft redChannel imgDeblur_3 redBlur_3 greenBlur_3 blueBlur_3 slider3 imgDeblur;

[h, w] = size(redChannel);
inv_blur_3_ft = zeros(h, w);

for i=1:h
    for j=1:w
        if abs(blur_3_ft(i,j)) > slider3
            inv_blur_3_ft(i,j) = 1/(blur_3_ft(i,j));
        else
            inv_blur_3_ft(i,j) = 0;
        end
    end
end

redDeblur_3_ft = fft2(redBlur_3) .* inv_blur_3_ft;
greenDeblur_3_ft = fft2(greenBlur_3) .* inv_blur_3_ft;
blueDeblur_3_ft = fft2(blueBlur_3) .* inv_blur_3_ft;

redDeblur_3 = ifft2(redDeblur_3_ft);
greenDeblur_3 = ifft2(greenDeblur_3_ft);
blueDeblur_3 = ifft2(blueDeblur_3_ft);

redDeblur_3 = (255/max(redDeblur_3(:))).* redDeblur_3;
greenDeblur_3 = (255/max(greenDeblur_3(:))).* greenDeblur_3;
blueDeblur_3 = (255/max(blueDeblur_3(:))).* blueDeblur_3;

imgDeblur_3 = cat(3, uint8(redDeblur_3), uint8(greenDeblur_3), uint8(blueDeblur_3));
imgDeblur = imgDeblur_3;
axes(handles.axes3);
imshow(imgDeblur_3);
imwrite(imgDeblur_3, 'truncinv_3.png');



% --- Executes on button press in trunc4.
function trunc4_Callback(hObject, eventdata, handles)
% hObject    handle to trunc4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blur_4_ft inv_blur_4_ft redChannel imgDeblur_4 redBlur_4 greenBlur_4 blueBlur_4 slider4 imgDeblur;

[h, w] = size(redChannel);
inv_blur_4_ft = zeros(h, w);
for i=1:h
    for j=1:w
        if abs(blur_4_ft(i,j)) > slider4
            inv_blur_4_ft(i,j) = 1/(blur_4_ft(i,j));
        else
            inv_blur_4_ft(i,j) = 0;
        end
    end
end

redDeblur_4_ft = fft2(redBlur_4) .* inv_blur_4_ft;
greenDeblur_4_ft = fft2(greenBlur_4) .* inv_blur_4_ft;
blueDeblur_4_ft = fft2(blueBlur_4) .* inv_blur_4_ft;

redDeblur_4 = ifft2(redDeblur_4_ft);
greenDeblur_4 = ifft2(greenDeblur_4_ft);
blueDeblur_4 = ifft2(blueDeblur_4_ft);

redDeblur_4 = (255/max(redDeblur_4(:))).* redDeblur_4;
greenDeblur_4 = (255/max(greenDeblur_4(:))).* greenDeblur_4;
blueDeblur_4 = (255/max(blueDeblur_4(:))).* blueDeblur_4;

imgDeblur_4 = cat(3, uint8(redDeblur_4), uint8(greenDeblur_4), uint8(blueDeblur_4));
imgDeblur = imgDeblur_4;
axes(handles.axes3);
imshow(imgDeblur_4);
imwrite(imgDeblur_4, 'truncinv_4.png');



% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global slider1;
slider1 = get(hObject,'Value');
set(handles.trunc1_val, 'String', num2str(slider1));


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global slider2;
slider2 = get(hObject,'Value');
set(handles.trunc2_val, 'String', num2str(slider2));


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global slider3;
slider3 = get(hObject,'Value');
set(handles.trunc3_val, 'String', num2str(slider3));


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global slider4;
slider4 = get(hObject,'Value');
set(handles.trunc4_val, 'String', num2str(slider4));


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function blur1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blur2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function blur2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blur2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function trunc1_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trunc1_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function trunc1_val_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to trunc1_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function trunc1_val_Callback(hObject, eventdata, handles)
% hObject    handle to trunc1_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trunc1_val as text
%        str2double(get(hObject,'String')) returns contents of trunc1_val as a double



function trunc4_val_Callback(hObject, eventdata, handles)
% hObject    handle to trunc4_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trunc4_val as text
%        str2double(get(hObject,'String')) returns contents of trunc4_val as a double


% --- Executes during object creation, after setting all properties.
function trunc4_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trunc4_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function trunc3_val_Callback(hObject, eventdata, handles)
% hObject    handle to trunc3_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trunc3_val as text
%        str2double(get(hObject,'String')) returns contents of trunc3_val as a double


% --- Executes during object creation, after setting all properties.
function trunc3_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trunc3_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function trunc2_val_Callback(hObject, eventdata, handles)
% hObject    handle to trunc2_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trunc2_val as text
%        str2double(get(hObject,'String')) returns contents of trunc2_val as a double


% --- Executes during object creation, after setting all properties.
function trunc2_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trunc2_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function psnr_val_Callback(hObject, eventdata, handles)
% hObject    handle to psnr_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of psnr_val as text
%        str2double(get(hObject,'String')) returns contents of psnr_val as a double
global imgDeblur psnr_val img;
psnr_val = psnr(imgDeblur, img);
set(handles.psnr, 'String', num2str(psnr_val));


% --- Executes during object creation, after setting all properties.
function psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to psnr_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ssim_val_Callback(hObject, eventdata, handles)
% hObject    handle to ssim_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ssim_val as text
%        str2double(get(hObject,'String')) returns contents of ssim_val as a double
global imgDeblur ssim_val img;
ssim_val = ssim(imgDeblur(100:400, 150:600), img(100:400, 150:600));
set(handles.ssim, 'String', num2str(ssim_val));


% --- Executes during object creation, after setting all properties.
function ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ssim_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in weiner_1.
function weiner_1_Callback(hObject, eventdata, handles)
% hObject    handle to weiner_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blur_1_ft redChannel redBlur_1 greenBlur_1 blueBlur_1 imgDeblur_1 imgDeblur;

[h, w] = size(redChannel);
redDeblur_1_ft = zeros(h, w);
greenDeblur_1_ft = zeros(h, w);
blueDeblur_1_ft = zeros(h, w);
redBlur_1_ft = fft2(redBlur_1);
greenBlur_1_ft = fft2(greenBlur_1);
blueBlur_1_ft = fft2(blueBlur_1);

K = str2double(get(handles.k_1, 'String'));

for i=1:h
    for j=1:w
        redDeblur_1_ft(i,j) = (redBlur_1_ft(i,j)*((abs(blur_1_ft(i,j)))^2))/((blur_1_ft(i,j))*(((abs(blur_1_ft(i,j)))^2) + K));
        greenDeblur_1_ft(i,j) = (greenBlur_1_ft(i,j)*((abs(blur_1_ft(i,j)))^2))/((blur_1_ft(i,j))*(((abs(blur_1_ft(i,j)))^2) + K));
        blueDeblur_1_ft(i,j) = (blueBlur_1_ft(i,j)*((abs(blur_1_ft(i,j)))^2))/((blur_1_ft(i,j))*(((abs(blur_1_ft(i,j)))^2) + K));
    end
end

redDeblur_1 = ifft2(redDeblur_1_ft);
greenDeblur_1 = ifft2(greenDeblur_1_ft);
blueDeblur_1 = ifft2(blueDeblur_1_ft);

redDeblur_1 = (255/max(redDeblur_1(:))).* redDeblur_1;
greenDeblur_1 = (255/max(greenDeblur_1(:))).* greenDeblur_1;
blueDeblur_1 = (255/max(blueDeblur_1(:))).* blueDeblur_1;

imgDeblur_1 = cat(3, uint8(redDeblur_1), uint8(greenDeblur_1), uint8(blueDeblur_1));
imgDeblur = imgDeblur_1;
axes(handles.axes3);
imshow(imgDeblur_1);
imwrite(imgDeblur_1, 'weiner_1.png');




% --- Executes on button press in weiner_2.
function weiner_2_Callback(hObject, eventdata, handles)
% hObject    handle to weiner_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blur_2_ft redChannel redBlur_2 greenBlur_2 blueBlur_2 imgDeblur_2 imgDeblur;

[h, w] = size(redChannel);
redDeblur_2_ft = zeros(h, w);
greenDeblur_2_ft = zeros(h, w);
blueDeblur_2_ft = zeros(h, w);
redBlur_2_ft = fft2(redBlur_2);
greenBlur_2_ft = fft2(greenBlur_2);
blueBlur_2_ft = fft2(blueBlur_2);

K = str2double(get(handles.k_2, 'String'));

for i=1:h
    for j=1:w
        redDeblur_2_ft(i,j) = (redBlur_2_ft(i,j)*((abs(blur_2_ft(i,j)))^2))/((blur_2_ft(i,j))*(((abs(blur_2_ft(i,j)))^2) + K));
        greenDeblur_2_ft(i,j) = (greenBlur_2_ft(i,j)*((abs(blur_2_ft(i,j)))^2))/((blur_2_ft(i,j))*(((abs(blur_2_ft(i,j)))^2) + K));
        blueDeblur_2_ft(i,j) = (blueBlur_2_ft(i,j)*((abs(blur_2_ft(i,j)))^2))/((blur_2_ft(i,j))*(((abs(blur_2_ft(i,j)))^2) + K));
    end
end

redDeblur_2 = ifft2(redDeblur_2_ft);
greenDeblur_2 = ifft2(greenDeblur_2_ft);
blueDeblur_2 = ifft2(blueDeblur_2_ft);

redDeblur_2 = (255/max(redDeblur_2(:))).* redDeblur_2;
greenDeblur_2 = (255/max(greenDeblur_2(:))).* greenDeblur_2;
blueDeblur_2 = (255/max(blueDeblur_2(:))).* blueDeblur_2;

imgDeblur_2 = cat(3, uint8(redDeblur_2), uint8(greenDeblur_2), uint8(blueDeblur_2));
imgDeblur = imgDeblur_2;
axes(handles.axes3);
imshow(imgDeblur_2);
imwrite(imgDeblur_2, 'weiner_2.png');



% --- Executes on button press in weiner_3.
function weiner_3_Callback(hObject, eventdata, handles)
% hObject    handle to weiner_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blur_3_ft redChannel redBlur_3 greenBlur_3 blueBlur_3 imgDeblur_3 imgDeblur;

[h, w] = size(redChannel);
redDeblur_3_ft = zeros(h, w);
greenDeblur_3_ft = zeros(h, w);
blueDeblur_3_ft = zeros(h, w);
redBlur_3_ft = fft2(redBlur_3);
greenBlur_3_ft = fft2(greenBlur_3);
blueBlur_3_ft = fft2(blueBlur_3);

K = str2double(get(handles.k_3, 'String'));

for i=1:h
    for j=1:w
        redDeblur_3_ft(i,j) = (redBlur_3_ft(i,j)*((abs(blur_3_ft(i,j)))^2))/((blur_3_ft(i,j))*(((abs(blur_3_ft(i,j)))^2) + K));
        greenDeblur_3_ft(i,j) = (greenBlur_3_ft(i,j)*((abs(blur_3_ft(i,j)))^2))/((blur_3_ft(i,j))*(((abs(blur_3_ft(i,j)))^2) + K));
        blueDeblur_3_ft(i,j) = (blueBlur_3_ft(i,j)*((abs(blur_3_ft(i,j)))^2))/((blur_3_ft(i,j))*(((abs(blur_3_ft(i,j)))^2) + K));
    end
end

redDeblur_3 = ifft2(redDeblur_3_ft);
greenDeblur_3 = ifft2(greenDeblur_3_ft);
blueDeblur_3 = ifft2(blueDeblur_3_ft);

redDeblur_3 = (255/max(redDeblur_3(:))).* redDeblur_3;
greenDeblur_3 = (255/max(greenDeblur_3(:))).* greenDeblur_3;
blueDeblur_3 = (255/max(blueDeblur_3(:))).* blueDeblur_3;

imgDeblur_3 = cat(3, uint8(redDeblur_3), uint8(greenDeblur_3), uint8(blueDeblur_3));
imgDeblur = imgDeblur_3;
axes(handles.axes3);
imshow(imgDeblur_3);
imwrite(imgDeblur_3, 'weiner_3.png');


% --- Executes on button press in weiner_4.
function weiner_4_Callback(hObject, eventdata, handles)
% hObject    handle to weiner_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blur_4_ft redChannel redBlur_4 greenBlur_4 blueBlur_4 imgDeblur_4 imgDeblur;

[h, w] = size(redChannel);
redDeblur_4_ft = zeros(h, w);
greenDeblur_4_ft = zeros(h, w);
blueDeblur_4_ft = zeros(h, w);
redBlur_4_ft = fft2(redBlur_4);
greenBlur_4_ft = fft2(greenBlur_4);
blueBlur_4_ft = fft2(blueBlur_4);

K = str2double(get(handles.k_4, 'String'));

for i=1:h
    for j=1:w
        redDeblur_4_ft(i,j) = (redBlur_4_ft(i,j)*((abs(blur_4_ft(i,j)))^2))/((blur_4_ft(i,j))*(((abs(blur_4_ft(i,j)))^2) + K));
        greenDeblur_4_ft(i,j) = (greenBlur_4_ft(i,j)*((abs(blur_4_ft(i,j)))^2))/((blur_4_ft(i,j))*(((abs(blur_4_ft(i,j)))^2) + K));
        blueDeblur_4_ft(i,j) = (blueBlur_4_ft(i,j)*((abs(blur_4_ft(i,j)))^2))/((blur_4_ft(i,j))*(((abs(blur_4_ft(i,j)))^2) + K));
    end
end

redDeblur_4 = ifft2(redDeblur_4_ft);
greenDeblur_4 = ifft2(greenDeblur_4_ft);
blueDeblur_4 = ifft2(blueDeblur_4_ft);

redDeblur_4 = (255/max(redDeblur_4(:))).* redDeblur_4;
greenDeblur_4 = (255/max(greenDeblur_4(:))).* greenDeblur_4;
blueDeblur_4 = (255/max(blueDeblur_4(:))).* blueDeblur_4;

imgDeblur_4 = cat(3, uint8(redDeblur_4), uint8(greenDeblur_4), uint8(blueDeblur_4));
imgDeblur = imgDeblur_4;
axes(handles.axes3);
imshow(imgDeblur_4);
imwrite(imgDeblur_4, 'weiner_4.png');



function k_1_Callback(hObject, eventdata, handles)
% hObject    handle to k_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k_1 as text
%        str2double(get(hObject,'String')) returns contents of k_1 as a double



% --- Executes during object creation, after setting all properties.
function k_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function k_2_Callback(hObject, eventdata, handles)
% hObject    handle to k_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k_2 as text
%        str2double(get(hObject,'String')) returns contents of k_2 as a double


% --- Executes during object creation, after setting all properties.
function k_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function k_3_Callback(hObject, eventdata, handles)
% hObject    handle to k_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k_3 as text
%        str2double(get(hObject,'String')) returns contents of k_3 as a double


% --- Executes during object creation, after setting all properties.
function k_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function k_4_Callback(hObject, eventdata, handles)
% hObject    handle to k_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k_4 as text
%        str2double(get(hObject,'String')) returns contents of k_4 as a double



% --- Executes during object creation, after setting all properties.
function k_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in clsf_1.
function clsf_1_Callback(hObject, eventdata, handles)
% hObject    handle to clsf_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global blur_1_ft redChannel redBlur_1 greenBlur_1 blueBlur_1 imgDeblur_1 imgDeblur;

[h, w] = size(redChannel);
redDeblur_1_ft = zeros(h, w);
greenDeblur_1_ft = zeros(h, w);
blueDeblur_1_ft = zeros(h, w);
p_matrix = zeros(h, w);
p_matrix(1:3, 1:3) = [0, -1, 0; -1, 4, -1; 0, -1, 0;];
redBlur_1_ft = fft2(redBlur_1);
greenBlur_1_ft = fft2(greenBlur_1);
blueBlur_1_ft = fft2(blueBlur_1);
p_matrix_ft = fft2(p_matrix);

gamma = str2double(get(handles.clsf_val_1, 'String'));

for i=1:h
    for j=1:w
        redDeblur_1_ft(i,j) = (redBlur_1_ft(i,j)*(conj(blur_1_ft(i,j))))/(((gamma)*(((abs(p_matrix_ft(i,j)))^2))) + ((abs(blur_1_ft(i,j)))^2));
        greenDeblur_1_ft(i,j) = (greenBlur_1_ft(i,j)*(conj(blur_1_ft(i,j))))/(((gamma)*(((abs(p_matrix_ft(i,j)))^2))) + ((abs(blur_1_ft(i,j)))^2));
        blueDeblur_1_ft(i,j) = (blueBlur_1_ft(i,j)*(conj(blur_1_ft(i,j))))/(((gamma)*(((abs(p_matrix_ft(i,j)))^2))) + ((abs(blur_1_ft(i,j)))^2));
    end
end

redDeblur_1 = ifft2(redDeblur_1_ft);
greenDeblur_1 = ifft2(greenDeblur_1_ft);
blueDeblur_1 = ifft2(blueDeblur_1_ft);

redDeblur_1 = (255/max(redDeblur_1(:))).* redDeblur_1;
greenDeblur_1 = (255/max(greenDeblur_1(:))).* greenDeblur_1;
blueDeblur_1 = (255/max(blueDeblur_1(:))).* blueDeblur_1;

imgDeblur_1 = cat(3, uint8(redDeblur_1), uint8(greenDeblur_1), uint8(blueDeblur_1));
imgDeblur = imgDeblur_1;
axes(handles.axes3);
imshow(imgDeblur_1);
imwrite(imgDeblur_1, 'clsf_1.png');



% --- Executes on button press in clsf_2.
function clsf_2_Callback(hObject, eventdata, handles)
% hObject    handle to clsf_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global blur_2_ft redChannel redBlur_2 greenBlur_2 blueBlur_2 imgDeblur_2 imgDeblur;

[h, w] = size(redChannel);
redDeblur_2_ft = zeros(h, w);
greenDeblur_2_ft = zeros(h, w);
blueDeblur_2_ft = zeros(h, w);
p_matrix = zeros(h, w);
p_matrix(1:3, 1:3) = [0, -1, 0; -1, 4, -1; 0, -1, 0;];
redBlur_2_ft = fft2(redBlur_2);
greenBlur_2_ft = fft2(greenBlur_2);
blueBlur_2_ft = fft2(blueBlur_2);
p_matrix_ft = fft2(p_matrix);

gamma = str2double(get(handles.clsf_val_2, 'String'));

for i=1:h
    for j=1:w
        redDeblur_2_ft(i,j) = (redBlur_2_ft(i,j)*(conj(blur_2_ft(i,j))))/(((gamma)*(((abs(p_matrix_ft(i,j)))^2))) + ((abs(blur_2_ft(i,j)))^2));
        greenDeblur_2_ft(i,j) = (greenBlur_2_ft(i,j)*(conj(blur_2_ft(i,j))))/(((gamma)*(((abs(p_matrix_ft(i,j)))^2))) + ((abs(blur_2_ft(i,j)))^2));
        blueDeblur_2_ft(i,j) = (blueBlur_2_ft(i,j)*(conj(blur_2_ft(i,j))))/(((gamma)*(((abs(p_matrix_ft(i,j)))^2))) + ((abs(blur_2_ft(i,j)))^2));
    end
end

redDeblur_2 = ifft2(redDeblur_2_ft);
greenDeblur_2 = ifft2(greenDeblur_2_ft);
blueDeblur_2 = ifft2(blueDeblur_2_ft);

redDeblur_2 = (255/max(redDeblur_2(:))).* redDeblur_2;
greenDeblur_2 = (255/max(greenDeblur_2(:))).* greenDeblur_2;
blueDeblur_2 = (255/max(blueDeblur_2(:))).* blueDeblur_2;

imgDeblur_2 = cat(3, uint8(redDeblur_2), uint8(greenDeblur_2), uint8(blueDeblur_2));
imgDeblur = imgDeblur_2;
axes(handles.axes3);
imshow(imgDeblur_2);
imwrite(imgDeblur_2, 'clsf_2.png');



% --- Executes on button press in clsf_3.
function clsf_3_Callback(hObject, eventdata, handles)
% hObject    handle to clsf_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blur_3_ft redChannel redBlur_3 greenBlur_3 blueBlur_3 imgDeblur_3 imgDeblur;

[h, w] = size(redChannel);
redDeblur_3_ft = zeros(h, w);
greenDeblur_3_ft = zeros(h, w);
blueDeblur_3_ft = zeros(h, w);
p_matrix = zeros(h, w);
p_matrix(1:3, 1:3) = [0, -1, 0; -1, 4, -1; 0, -1, 0;];
redBlur_3_ft = fft2(redBlur_3);
greenBlur_3_ft = fft2(greenBlur_3);
blueBlur_3_ft = fft2(blueBlur_3);
p_matrix_ft = fft2(p_matrix);

gamma = str2double(get(handles.clsf_val_3, 'String'));

for i=1:h
    for j=1:w
        redDeblur_3_ft(i,j) = (redBlur_3_ft(i,j)*(conj(blur_3_ft(i,j))))/(((gamma)*(((abs(p_matrix_ft(i,j)))^2))) + ((abs(blur_3_ft(i,j)))^2));
        greenDeblur_3_ft(i,j) = (greenBlur_3_ft(i,j)*(conj(blur_3_ft(i,j))))/(((gamma)*(((abs(p_matrix_ft(i,j)))^2))) + ((abs(blur_3_ft(i,j)))^2));
        blueDeblur_3_ft(i,j) = (blueBlur_3_ft(i,j)*(conj(blur_3_ft(i,j))))/(((gamma)*(((abs(p_matrix_ft(i,j)))^2))) + ((abs(blur_3_ft(i,j)))^2));
    end
end

redDeblur_3 = ifft2(redDeblur_3_ft);
greenDeblur_3 = ifft2(greenDeblur_3_ft);
blueDeblur_3 = ifft2(blueDeblur_3_ft);

redDeblur_3 = (255/max(redDeblur_3(:))).* redDeblur_3;
greenDeblur_3 = (255/max(greenDeblur_3(:))).* greenDeblur_3;
blueDeblur_3 = (255/max(blueDeblur_3(:))).* blueDeblur_3;

imgDeblur_3 = cat(3, uint8(redDeblur_3), uint8(greenDeblur_3), uint8(blueDeblur_3));
imgDeblur = imgDeblur_3;
axes(handles.axes3);
imshow(imgDeblur_3);
imwrite(imgDeblur_3, 'clsf_3.png');



% --- Executes on button press in clsf_4.
function clsf_4_Callback(hObject, eventdata, handles)
% hObject    handle to clsf_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global blur_4_ft redChannel redBlur_4 greenBlur_4 blueBlur_4 imgDeblur_4 imgDeblur;

[h, w] = size(redChannel);
redDeblur_4_ft = zeros(h, w);
greenDeblur_4_ft = zeros(h, w);
blueDeblur_4_ft = zeros(h, w);
p_matrix = zeros(h, w);
p_matrix(1:3, 1:3) = [0, -1, 0; -1, 4, -1; 0, -1, 0;];
redBlur_4_ft = fft2(redBlur_4);
greenBlur_4_ft = fft2(greenBlur_4);
blueBlur_4_ft = fft2(blueBlur_4);
p_matrix_ft = fft2(p_matrix);

gamma = str2double(get(handles.clsf_val_4, 'String'));

for i=1:h
    for j=1:w
        redDeblur_4_ft(i,j) = (redBlur_4_ft(i,j)*(conj(blur_4_ft(i,j))))/(((gamma)*(((abs(p_matrix_ft(i,j)))^2))) + ((abs(blur_4_ft(i,j)))^2));
        greenDeblur_4_ft(i,j) = (greenBlur_4_ft(i,j)*(conj(blur_4_ft(i,j))))/(((gamma)*(((abs(p_matrix_ft(i,j)))^2))) + ((abs(blur_4_ft(i,j)))^2));
        blueDeblur_4_ft(i,j) = (blueBlur_4_ft(i,j)*(conj(blur_4_ft(i,j))))/(((gamma)*(((abs(p_matrix_ft(i,j)))^2))) + ((abs(blur_4_ft(i,j)))^2));
    end
end

redDeblur_4 = ifft2(redDeblur_4_ft);
greenDeblur_4 = ifft2(greenDeblur_4_ft);
blueDeblur_4 = ifft2(blueDeblur_4_ft);

redDeblur_4 = (255/max(redDeblur_4(:))).* redDeblur_4;
greenDeblur_4 = (255/max(greenDeblur_4(:))).* greenDeblur_4;
blueDeblur_4 = (255/max(blueDeblur_4(:))).* blueDeblur_4;

imgDeblur_4 = cat(3, uint8(redDeblur_4), uint8(greenDeblur_4), uint8(blueDeblur_4));
imgDeblur = imgDeblur_4;
axes(handles.axes3);
imshow(imgDeblur_4);
imwrite(imgDeblur_4, 'clsf_4.png');




function clsf_val_1_Callback(hObject, eventdata, handles)
% hObject    handle to clsf_val_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clsf_val_1 as text
%        str2double(get(hObject,'String')) returns contents of clsf_val_1 as a double


% --- Executes during object creation, after setting all properties.
function clsf_val_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clsf_val_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function clsf_val_2_Callback(hObject, eventdata, handles)
% hObject    handle to clsf_val_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clsf_val_2 as text
%        str2double(get(hObject,'String')) returns contents of clsf_val_2 as a double


% --- Executes during object creation, after setting all properties.
function clsf_val_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clsf_val_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function clsf_val_3_Callback(hObject, eventdata, handles)
% hObject    handle to clsf_val_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clsf_val_3 as text
%        str2double(get(hObject,'String')) returns contents of clsf_val_3 as a double


% --- Executes during object creation, after setting all properties.
function clsf_val_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clsf_val_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function clsf_val_4_Callback(hObject, eventdata, handles)
% hObject    handle to clsf_val_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clsf_val_4 as text
%        str2double(get(hObject,'String')) returns contents of clsf_val_4 as a double


% --- Executes during object creation, after setting all properties.
function clsf_val_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clsf_val_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in org_img.
function org_img_Callback(hObject, eventdata, handles)
% hObject    handle to org_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img;
image_file = imgetfile();
img = imread(image_file);
axes(handles.axes1);
imshow(img);


% --- Executes on button press in blr_img.
function blr_img_Callback(hObject, eventdata, handles)
% hObject    handle to blr_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img blur_img redChannel greenChannel blueChannel redBlur_1 greenBlur_1 blueBlur_1 blur_1_ft;
image_file = imgetfile();
blur_img = imread(image_file);
axes(handles.axes2);
imshow(blur_img);

redChannel = img(:,:,1);
greenChannel = img(:,:,2);
blueChannel = img(:,:,3);

redBlur_1 = blur_img(:,:,1);
greenBlur_1 = blur_img(:,:,2);
blueBlur_1 = blur_img(:,:,3);

bw_img = rgb2gray(img);
bw_blur_img = rgb2gray(blur_img);

bw_img = double(bw_img);
bw_blur_img = double(bw_blur_img);

blur_1_ft = (fft2(bw_img))./(fft2(bw_blur_img));



function blur_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to blur_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of blur_psnr as text
%        str2double(get(hObject,'String')) returns contents of blur_psnr as a double


% --- Executes during object creation, after setting all properties.
function blur_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blur_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function blur_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to blur_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of blur_ssim as text
%        str2double(get(hObject,'String')) returns contents of blur_ssim as a double


% --- Executes during object creation, after setting all properties.
function blur_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blur_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
