function varargout = ProjectPraktikum(varargin)
% PROJECTPRAKTIKUM MATLAB code for ProjectPraktikum.fig
%      PROJECTPRAKTIKUM, by itself, creates a new PROJECTPRAKTIKUM or raises the existing
%      singleton*.
%
%      H = PROJECTPRAKTIKUM returns the handle to a new PROJECTPRAKTIKUM or the handle to
%      the existing singleton*.
%
%      PROJECTPRAKTIKUM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECTPRAKTIKUM.M with the given input arguments.
%
%      PROJECTPRAKTIKUM('Property','Value',...) creates a new PROJECTPRAKTIKUM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ProjectPraktikum_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ProjectPraktikum_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ProjectPraktikum

% Last Modified by GUIDE v2.5 01-Jul-2021 15:35:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProjectPraktikum_OpeningFcn, ...
                   'gui_OutputFcn',  @ProjectPraktikum_OutputFcn, ...
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


% --- Executes just before ProjectPraktikum is made visible.
function ProjectPraktikum_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ProjectPraktikum (see VARARGIN)

% Choose default command line output for ProjectPraktikum
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ProjectPraktikum wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ProjectPraktikum_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LoadData.
function LoadData_Callback(hObject, eventdata, handles)
% hObject    handle to LoadData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%data = readmatrix('sao-paulo-properties-april-2019.xlsx', "Range", "A2:J200");
opts = detectImportOptions('laptop_pricing.xlsx');
opts.SelectedVariableNames = [2 3 4 5 6 9 10];
data = readmatrix('laptop_pricing.xlsx',opts);
%tampilkan data di tabel
set(handles.tabelData,'data',data);



% --- Executes on button press in CalculateResult.
function CalculateResult_Callback(hObject, eventdata, handles)
% hObject    handle to CalculateResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('laptop_pricing.xlsx');
opts.SelectedVariableNames = [2 3 4 5 6 9 10];
data = readmatrix('laptop_pricing.xlsx',opts);

%Atribut tiap-tiap kriteria, dimana nilai 1 = benefit, dan 0 = cost
krt = [1,1,1,1,1,1,0];

%Nilai bobot tiap kriteria
wght = [4,5,3,3,3,2,4];

%Hitung nilai jumlah row dan column dari data
[m, n]=size (data);

%Membagi bobot per kriteria dengan jumlah total seluruh bobot
wght= round(wght./sum(wght),2);

%Kali weight cost dengan -1 agar berubah jadi minus
for j=1:n
    if krt(j)==0, wght(j)=-1*wght(j);
    end
end

%Melakukan perhitungan vektor(S) per baris (alternatif)
for i=1:m
    S(i)=prod(data(i,:).^wght);
end

%tahapan ketiga, proses perangkingan
V= S/sum(S);

[sortedDist, index] = sort(V,'descend');
result = sortedDist.';
idx = index.';
ss = [result idx];
disp(ss);

set(handles.tabelHasil1,'data',ss);
