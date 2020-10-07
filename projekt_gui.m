function varargout = projekt_gui(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @projekt_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @projekt_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before projekt_gui is made visible.
function projekt_gui_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.seq1,'String','GGCAA');%'GATACTA');
set(handles.seq2,'String','GCACA');%'GATTACCA');
set(handles.edit_match,'String','1');
set(handles.edit_mismatch,'String','-1');
set(handles.edit_gaps,'String','-2');

set(handles.textPercent,'visible','off');
set(handles.percent,'visible','off');
set(handles.txtHom,'visible','off');
set(handles.text_sciezka,'visible','on');
set(handles.textMatch,'visible','on');
set(handles.textMismatch,'visible','on');
set(handles.textGaps,'visible','on');
set(handles.edit_match,'visible','on');
set(handles.edit_mismatch,'visible','on');
set(handles.edit_gaps,'visible','on');
set(handles.static1,'String','Identity: ');
set(handles.static2,'String','Gaps: ');
set(handles.btn_change,'visible','on');
set(handles.table,'visible','off');



% --- Outputs from this function are returned to the command line.
function varargout = projekt_gui_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;



function seq1_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function seq1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function seq2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function seq2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_ok.
function btn_ok_Callback(hObject, eventdata, handles)
v = get(handles.menu,'Value');
if v==3
cla;
L=0;
if length(get(handles.seq1,'String')) > length(get(handles.seq2,'String'))
   L= length(get(handles.seq1,'String'));
else
    L=length(get(handles.seq2,'String'));
end
t=round(str2double(get(handles.percent,'String'))/100*length(get(handles.seq1,'String')));
[a,b]=chartDotPlot(get(handles.seq1,'String'),get(handles.seq2,'String'),t);
hold on;
axis([0 L 0 L]);hold on;
scatter(a,b);hold off;
ylabel('Sekwencja 1');xlabel('Sekwencja 2');title('Dot Plot');legend('dopasowanie');

t=round(0.3*length(get(handles.seq1,'String')));
[a,b,~,i,s]=chartDotPlot(get(handles.seq1,'String'),get(handles.seq2,'String'),t);
    if isempty(a) && isempty(b)
        hom='Sekwencje nie sa homologiczne';
    else hom='Sekwencje sa homologiczne';
    end
set(handles.txtHom,'String',hom);
if i==true
   set(handles.id_ins_del,'String','insercja / delecja'); 
end
if s==true
   set(handles.gap_subs,'String','substytucja'); 
end
%
else
set(handles.slider,'visible','on','value',1);
str1=get(handles.seq1,'String');
str2=get(handles.seq2,'String');
match=str2double(get(handles.edit_match,'String'));
mismatch=str2double(get(handles.edit_mismatch,'String'));
gap=str2double(get(handles.edit_gaps,'String'));
if v==1
    [m,all,q ] = glob( str1,str2,match,mismatch,gap );
elseif v==2
    [m,all,q ] = local( str1,str2,match,mismatch,gap );
end
kolumny=all(1).kolumny;
wiersze=all(1).wiersze;
chartImage( m,kolumny,wiersze );
set(handles.wykres,'visible','on');
set(handles.table,'visible','off');
[ sys ] = sysOut( all(1).s1,all(1).s2 );
set(handles.text_sciezka,'String',sys);
set(handles.id_ins_del,'String',all(1).identity);
set(handles.gap_subs,'String',all(1).gaps);
if q~= 1
    set(handles.slider,'MIN',1,'MAX',q,'SliderStep',[1/(q-1) 1/(q-1)]);
else
    set(handles.slider,'visible','off');
end
end


% --- Executes on button press in btn_load1.
function btn_load1_Callback(hObject, eventdata, handles)
[p] = loadFile();
set(handles.seq1,'String',p.Sequence);


% --- Executes on button press in btn_load2.
function btn_load2_Callback(hObject, eventdata, handles)
[p] = loadFile();
set(handles.seq2,'String',p.Sequence);

% --- Executes on button press in btn_zapisz.
function btn_zapisz_Callback(hObject, eventdata, handles)
v=get(handles.menu,'value');
if v==3
t=round(str2double(get(handles.percent,'String'))/100*length(get(handles.seq1,'String')));
[a,b,m,~,~]=chartDotPlot(get(handles.seq1,'String'),get(handles.seq2,'String'),t);
zapiszDotPlot(a,b,m);
else
val=get(handles.slider,'value');
str1=get(handles.seq1,'String');
str2=get(handles.seq2,'String');
match=str2double(get(handles.edit_match,'String'));
mismatch=str2double(get(handles.edit_mismatch,'String'));
gap=str2double(get(handles.edit_gaps,'String'));
if v==1
       [m,all,~ ] = glob( str1,str2,match,mismatch,gap );
elseif v==2
    [m,all,~ ] = glob( str1,str2,match,mismatch,gap );
end
kolumny=all(val).kolumny;
wiersze=all(val).wiersze;
zapiszAlg( kolumny,wiersze,m );
end

function percent_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function percent_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in btn_change.
function btn_change_Callback(hObject, eventdata, handles)
if strcmp(get(handles.table,'visible'),'off')
set(handles.wykres,'visible','off');
set(handles.table,'visible','on','RowName',[],'ColumnName',[]);
str1=get(handles.seq1,'String');
str2=get(handles.seq2,'String');
match=str2double(get(handles.edit_match,'String'));
mismatch=str2double(get(handles.edit_mismatch,'String'));
gap=str2double(get(handles.edit_gaps,'String'));
menu=get(handles.menu,'value');
if menu==1
    [m,~,~ ] = glob( str1,str2,match,mismatch,gap );
elseif menu==2
    [m,~,~ ] = local( str1,str2,match,mismatch,gap );
end
set(handles.table,'Data',m);
else
    set(handles.table,'visible','off');
    set(handles.wykres,'visible','on');
end


% --- Executes on selection change in menu.
function menu_Callback(hObject, eventdata, handles)
v = get(handles.menu,'Value');
if v==1 || v==2 %global or local
    set(handles.textPercent,'visible','off');
    set(handles.percent,'visible','off');
    set(handles.txtHom,'visible','off');
    set(handles.text_sciezka,'visible','on');
    set(handles.textMatch,'visible','on');
    set(handles.textMismatch,'visible','on');
    set(handles.textGaps,'visible','on');
    set(handles.edit_match,'visible','on');
    set(handles.edit_mismatch,'visible','on');
    set(handles.edit_gaps,'visible','on');
    set(handles.static1,'String','Identity: ');
    set(handles.static2,'String','Gaps: ');
    set(handles.btn_change,'visible','on');
    set(handles.slider,'visible','on');
 elseif v==3 %dotplot
     set(handles.textPercent,'visible','on');
     set(handles.percent,'visible','on');
     set(handles.txtHom,'visible','on');
     set(handles.text_sciezka,'visible','off');
     set(handles.textMatch,'visible','off');
     set(handles.textMismatch,'visible','off');
     set(handles.textGaps,'visible','off');
     set(handles.edit_match,'visible','off');
     set(handles.edit_mismatch,'visible','off');
     set(handles.edit_gaps,'visible','off');
     set(handles.static1,'String','Insercja/delecja: ');
     set(handles.static2,'String','Substytucja: ');
     set(handles.btn_change,'visible','off');
     set(handles.slider,'visible','off');
     set(handles.table,'visible','off');
     set(handles.wykres,'visible','on');
end


% --- Executes during object creation, after setting all properties.
function menu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'Global';'Local';'Dot-Plot'});



function edit_match_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_match_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mismatch_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_mismatch_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gaps_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_gaps_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
v=get(handles.slider,'value');
str1=get(handles.seq1,'String');
str2=get(handles.seq2,'String');
match=str2double(get(handles.edit_match,'String'));
mismatch=str2double(get(handles.edit_mismatch,'String'));
gap=str2double(get(handles.edit_gaps,'String'));
menu=get(handles.menu,'value');
if menu==1
    [m,all,~ ] = glob( str1,str2,match,mismatch,gap );
elseif menu==2
    [m,all,~ ] = local( str1,str2,match,mismatch,gap );
end
kolumny=all(v).kolumny;
wiersze=all(v).wiersze;
chartImage( m,kolumny,wiersze );
[ sys ] = sysOut( all(v).s1,all(v).s2 );
set(handles.text_sciezka,'String',sys);
set(handles.wykres,'visible','on');
set(handles.table,'visible','off');
set(handles.id_ins_del,'String',all(v).identity);
set(handles.gap_subs,'String',all(v).gaps);


% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function text_sciezka_CreateFcn(hObject, eventdata, handles)
set(hObject,'FontName','Courier','HorizontalAlignment','Center');
