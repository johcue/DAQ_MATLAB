function varargout = P2(varargin)
% P2 MATLAB code for P2.fig
%      P2, by itself, creates a new P2 or raises the existing
%      singleton*.
%
%      H = P2 returns the handle to a new P2 or the handle to
%      the existing singleton*.
%
%      P2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in P2.M with the given input arguments.
%
%      P2('Property','Value',...) creates a new P2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before P2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to P2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help P2

% Last Modified by GUIDE v2.5 10-Apr-2020 01:27:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @P2_OpeningFcn, ...
                   'gui_OutputFcn',  @P2_OutputFcn, ...
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


% --- Executes just before P2 is made visible.
function P2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to P2 (see VARARGIN)
CreargraficaAcop(handles);
% Choose default command line output for P2
handles.output = hObject;
axis manual
%% 
            grid on
            axis([0 10 -4 4])
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes P2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = P2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Chanel1(handles)
est1=get(handles.btnChannel1,'Value');
    while (est1==1) 
    % Adquiere los datos
%      [datos,t]=startForeground(handles.s);   
        pause(0.2);
        %Volt/divi (modifica amplitud)
        op=get(handles.lstVDiv1, 'Value');
        switch op
        case 1 
            volt=0.5;
        case 2 
            volt=1;
        case 3 
            volt=2.5;
        case 4
            volt=5;
        end

    %seg/div (Modifica los ciclos)
    op1=get(handles.lstSDiv1,'Value');
    t=10;
    frec=100;
    Fs=1000*frec;
    offset=1;
    Amp=4;
        switch op1
            case 1 
                %Se utiliza t=10 para que el número de muestras esté en los
                %10 cuadros del eje x (así fue como lo vimos más fácil)
                %luego ese valor se divide para obtener el valor requerido
                %para cada cuadro de acuerdo a la opción seleccionada
                
                  N1=Fs*t;
                  t1=(0:N1)*1/Fs;
                  Arg=(2*pi)*(frec*t1/10000);%Se divide para que cada cuadro tenga el valor esperado de t=0.001
               
            case 2 
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/4000);%Para t=0.0025
              
            case 3 
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/2000);%Para t=0.005
                            
            case 4
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/1000);%Para t=0.010
            
            case 5
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/400);%Para t=0.025
            case 6
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/200);%Para t=0.050
        end
        %Seno
        y=(Amp/volt)*sin(Arg)+offset/volt;
        %Cuadrada
%         y=(Amp/volt)*square(Arg)+offset/volt;
        %Triangular   
%         y=(Amp/volt)*sawtooth(Arg,0.5)+offset/volt;
        
    pause(0.2);  
    %Calculo del promedio
    prom=mean(y);    
    valprom=round(prom);
    %%% Acople 
   Ac=get(handles.lstAcople,'Value');
   
   switch Ac
       case 1
           % Entrada AC, es decir sin offse
           if(offset>0)
%             if (valprom>0)
%                 if op1==1 || op1==2
%                     y=y-valprom+volt;
%                 else 
%                      y= y-prom;
%                 end
           y=y-offset/volt;
            %Calculo de Vrms
            vrms=sqrt(sum(y.^2)/length(y));
            set(handles.txtVrms1,'String',vrms);
             %Calculo del promedio
            prom=round(mean(y));
            set(handles.txtVavg1,'String',prom);
            
           
            axis manual
            plot(t1,y,'green');    
            grid on
            axis([0 10 -4 4])
            set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
            set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
            xlabel('Tiempo(s)')
            ylabel('Voltaje(V)')
            title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
%             end
            else 
%                  Calculo de Vrms
            vrms=sqrt(sum(y.^2)/length(y));
            set(handles.txtVrms1,'String',vrms);
%              Calculo del promedio
            prom=round(mean(y));
            set(handles.txtVavg1,'String',prom);
            axis manual
            plot(t1,y,'green');    
            grid on
            axis([0 10 -4 4])
            set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
            set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
            xlabel('Tiempo(s)')
            ylabel('Voltaje(V)')
            title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
            end 
            
       case 2
           %%Entrada DC, es tal cual viene la señal,con offset incluido
                  %Calculo de Vrms
                 vrms=sqrt(sum(y.^2)/length(y));
                 set(handles.txtVrms1,'String',vrms);
                 %Calculo del promedio
                 prom=round(mean(y));
                 set(handles.txtVavg1,'String',prom);
                 axis manual
                 plot(t1,y,'green');    
                 grid on
                 axis([0 10 -4 4])
                 set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
                 set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
                 xlabel('Tiempo(s)')
                 ylabel('Voltaje(V)')
                 title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
       case 3 %Tierra, la gráfica es cte en cero
            %Calculo de Vrms
            vrms=0;
            set(handles.txtVrms1,'String',vrms);
             %Calculo del promedio
            prom=0;
            set(handles.txtVavg1,'String',prom);
                axis manual
                x=5*t1;
                y=0*x;
                plot(x,y,'green');  
                grid on
                axis([0 10 -4 4])
                set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
                set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
                xlabel('Tiempo(s)')
                ylabel('Voltaje(V)')
                title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
   end
   
    
%     axes(handles.Oscilosco)
    est1=get(handles.btnChannel1,'Value');
    
    nue=get(handles.btnAdquirir,'Value');
    if (nue==0)
        break
    end
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
function Chanel2(handles)
est2=get(handles.btnChannel2,'Value');
       while (est2==1) 
           % Adquiere los datos
           %      [datos,t]=startForeground(handles.s);   
  
           pause(0.2);
           %Volt/divi (modifica amplitud)
           op=get(handles.lstVDiv2, 'Value');
                switch op
                case 1 
                    volt=0.5;
                case 2 
                    volt=1;
                case 3 
                    volt=2.5;
                case 4
                    volt=5;
                end

            %seg/div (Modifica los ciclos)
             op1=get(handles.lstSDiv2,'Value');
    t=10;
    frec=100;
    Fs=1000*frec;
    offset=1;
    Amp=4;
        switch op1
            case 1 
                %Se utiliza t=10 para que el número de muestras esté en los
                %10 cuadros del eje x (así fue como lo vimos más fácil)
                %luego ese valor se divide para obtener el valor requerido
                %para cada cuadro de acuerdo a la opción seleccionada
                
                  N1=Fs*t;
                  t1=(0:N1)*1/Fs;
                  Arg=(2*pi)*(frec*t1/10000);%Se divide para que cada cuadro tenga el valor esperado de t=0.001
               
            case 2 
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/4000);%Para t=0.0025
              
            case 3 
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/2000);%Para t=0.005
                            
            case 4
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/1000);%Para t=0.010
            
            case 5
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/400);%Para t=0.025
            case 6
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/200);%Para t=0.050
        end
        %Coseno
        y=(Amp/volt)*cos(Arg)+offset/volt;%es la desfasada las del canal 2
%                 switch op1
%                 case 1 
%                     t=0.001;
%                     handles.s.NumberOfScans=10*t*handles.s.Rate;           
%                 case 2 
%                     t=0.0025;
%                     handles.s.NumberOfScans=10*t*handles.s.Rate;           
%                 case 3 
%                     t=0.005;
%                     handles.s.NumberOfScans=10*t*handles.s.Rate;           
%                 case 4
%                     t=0.01;
%                     handles.s.NumberOfScans=10*t*handles.s.Rate;           
%                 case 5
%                     t=0.025;
%                     handles.s.NumberOfScans=10*t*handles.s.Rate;           
%                 case 6
%                     t=0.05;
%                     handles.s.NumberOfScans=10*t*handles.s.Rate;           
%                 end
  
                pause(0.2);
    % Grafica datos
    %Calculo del promedio
    prom=mean(y);    
    valprom=round(prom);
    %%% Acople 
   Ac=get(handles.lstAcople2,'Value');
   
   switch Ac
       case 1
           % Entrada AC, es decir sin offse
           if(offset>0)
%             if valprom>0 
%               
%                  if op1==1
%                     y=y-valprom+2;
%                  else 
%                      y= y-valprom;
%                  end
%            
            y=y-offset/volt;
            %Calculo de Vrms
            vrms=sqrt(sum(y.^2)/length(y));
            set(handles.txtVrms2,'String',vrms);
             %Calculo del promedio
            prom=round(mean(y));
            set(handles.txtVavg2,'String',prom);
    
            axis manual
            plot(t1,y,'yellow');    
            grid on
            axis([0 10 -4 4])
            set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
            set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
            xlabel('Tiempo(s)')
            ylabel('Voltaje(V)')
            title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
            else 
                 %Calculo de Vrms
            vrms=sqrt(sum(y.^2)/length(y));
            set(handles.txtVrms2,'String',vrms);
             %Calculo del promedio
            prom=round(mean(y));
            set(handles.txtVavg2,'String',prom);
            axis manual
            plot(t1,y,'yellow');    
            grid on
            axis([0 10 -4 4])
            set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
            set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
            xlabel('Tiempo(s)')
            ylabel('Voltaje(V)')
            title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
            end 
           
       case 2
           %%Entrada DC, es tal cual viene la señal,con offset incluido
                  %Calculo de Vrms
                 vrms=sqrt(sum(y.^2)/length(y));
                 set(handles.txtVrms2,'String',vrms);
                 %Calculo del promedio
                 prom=round(mean(y));
                 set(handles.txtVavg2,'String',prom);
                 axis manual
                 plot(t1,y,'yellow');    
                 grid on
                 axis([0 10 -4 4])
                 set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
                 set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
                 xlabel('Tiempo(s)')
                 ylabel('Voltaje(V)')
                 title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
       case 3 %Tierra, la gráfica es cte en cero
            %Calculo de Vrms
            vrms=0;
            set(handles.txtVrms2,'String',vrms);
             %Calculo del promedio
            prom=0;
            set(handles.txtVavg2,'String',prom);
                axis manual
                x=5*t1;
                y=0*x;
                plot(x,y,'yellow');  
                grid on
                axis([0 10 -4 4])
                set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
                set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
                xlabel('Tiempo(s)')
                ylabel('Voltaje(V)')
                title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
   end
                est2=get(handles.btnChannel2,'Value');
                
    nue=get(handles.btnAdquirir,'Value');
    if (nue==0)
        break
    end
       end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
       
function GraAmbas(handles)

est1=get(handles.btnChannel1,'Value');
est2=get(handles.btnChannel2,'Value');
    while (est1==1 && est2==1) 
     % Adquiere los datos
%      [datos1,ta]=startForeground(handles.s);   
%      [datos2,tb]=startForeground(handles.s);
%     pause(0.2);
    %Volt/divi (modifica amplitud)
   op=get(handles.lstVDiv1, 'Value');
   op1=get(handles.lstVDiv2, 'Value');
   switch op
    case 1 
        volt=0.5;
    case 2 
        volt=1;
    case 3 
        volt=2.5;
    case 4
        volt=5;
   end
   switch op1
    case 1 
        volt1=0.5;
    case 2 
        volt1=1;
    case 3 
        volt1=2.5;
    case 4
        volt1=5;
   end
pause(0.2);
%seg/div (Modifica los ciclos)
   t=10;
   op2=get(handles.lstSDiv1,'Value');
   op3=get(handles.lstSDiv2,'Value');
    frec=100;
    Fs=1000*frec;
    offset=0;
    Amp=5;
        switch op2
            case 1             
                  N1=Fs*t;
                  t1=(0:N1)*1/Fs;
                  Arg=(2*pi)*(frec*t1/10000);%Se divide para que cada cuadro tenga el valor esperado de t=0.001
               
            case 2 
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/4000);%Para t=0.0025
              
            case 3 
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/2000);%Para t=0.005
                            
            case 4
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/1000);%Para t=0.010
            
            case 5
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/400);%Para t=0.025
            case 6
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/200);%Para t=0.050
        end
        switch op3
            case 1             
                  N1=Fs*t;
                  t2=(0:N1)*1/Fs;
                  Arg2=(2*pi)*(frec*t2/10000);%Se divide para que cada cuadro tenga el valor esperado de t=0.001
               
            case 2 
                N1=Fs*t;
                t2=(0:N1)*1/Fs;
                Arg2=(2*pi)*(frec*t2/4000);%Para t=0.0025
              
            case 3 
                N1=Fs*t;
                t2=(0:N1)*1/Fs;
                Arg2=(2*pi)*(frec*t2/2000);%Para t=0.005
                            
            case 4
                N1=Fs*t;
                t2=(0:N1)*1/Fs;
                Arg2=(2*pi)*(frec*t2/1000);%Para t=0.010
            
            case 5
                N1=Fs*t;
                t2=(0:N1)*1/Fs;
                Arg2=(2*pi)*(frec*t2/400);%Para t=0.025
            case 6
                N1=Fs*t;
                t2=(0:N1)*1/Fs;
                Arg2=(2*pi)*(frec*t2/200);%Para t=0.050
        end
        %Canal 1, señal sin desfase
    y1=(Amp/volt)*sin(Arg)+offset/volt;
        
        %Canal 2, señal desfasada 90 
         y2=(Amp/volt1)*cos(Arg2)+offset/volt1;
    % Grafica datos
  
    %Calculo del promedio canal 1
    prom=mean(y1);
    valprom1=round(prom);

    %Calculo del promedio canal 2
    prom1=mean(y2);
    valprom2=round(prom1);
    
     Ac1=get(handles.lstAcople,'Value');
     Ac2=get(handles.lstAcople2,'Value');
   
   switch Ac1
       case 1
           % Entrada AC, es decir sin offse
           if offset>0
%             if valprom1>0 
%               
%                   if op2==1 || op2==2
%                     y1=y1-valprom1+1;
%                     else 
%                      y1= y1-valprom1;
%                   end
           y1=y1-offset/volt;
            %Calculo de Vrms
            vrms=sqrt(sum(y1.^2)/length(y1));
            set(handles.txtVrms1,'String',vrms);
             %Calculo del promedio
            prom=round(mean(y1));
            set(handles.txtVavg1,'String',prom);
    
            axis manual
            plot(t1,y1,'green',t2,y2,'yellow') 
            grid on
            axis([0 10 -4 4])
            set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
            set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
            xlabel('Tiempo(s)')
            ylabel('Voltaje(V)')
            title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
            else 
                 %Calculo de Vrms
            vrms=sqrt(sum(y1.^2)/length(y1));
            set(handles.txtVrms1,'String',vrms);
             %Calculo del promedio
            prom=round(mean(y1));
            set(handles.txtVavg1,'String',prom);
            axis manual
            plot(t1,y1,'green',t2,y2,'yellow')    
            grid on
            axis([0 10 -4 4])
            set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
            set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
            xlabel('Tiempo(s)')
            ylabel('Voltaje(V)')
            title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
            end 
           
       case 2
           %%Entrada DC, es tal cual viene la señal,con offset incluido
                  %Calculo de Vrms
                 vrms=sqrt(sum(y1.^2)/length(y1));
                 set(handles.txtVrms1,'String',vrms);
                 %Calculo del promedio
                 prom=round(mean(y1));
                 set(handles.txtVavg1,'String',prom);
                 axis manual
                 plot(t1,y1,'green',t2,y2,'yellow')  
                 grid on
                 axis([0 10 -4 4])
                 set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
                 set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
                 xlabel('Tiempo(s)')
                 ylabel('Voltaje(V)')
                 title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
       case 3 %Tierra, la gráfica es cte en cero
            %Calculo de Vrms
            vrms=0;
            set(handles.txtVrms1,'String',vrms);
             %Calculo del promedio
            prom=0;
            set(handles.txtVavg1,'String',prom);
                axis manual
                x=5*t1;
                y1=0*x;
                plot(x,y1,'green',t2,y2,'yellow') 
                grid on
                axis([0 10 -4 4])
                set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
                set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
                xlabel('Tiempo(s)')
                ylabel('Voltaje(V)')
                title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
   end
   
    switch Ac2
       case 1
           % Entrada AC, es decir sin offse
           if offset>0
%             if valprom2>0 
%               
%                  if op3==1
%                     y2=y2-valprom2+2;
%                  else 
%                      y2= y2-valprom2;
%                  end
           y2=y2-offset/volt1;
            %Calculo de Vrms
            vrms=sqrt(sum(y2.^2)/length(y2));
            set(handles.txtVrms2,'String',vrms);
             %Calculo del promedio
            prom=round(mean(y2));
            set(handles.txtVavg2,'String',prom);
    
            axis manual
            plot(t1,y1,'green',t2,y2,'yellow')
            grid on
            axis([0 10 -4 4])
            set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
            set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
            xlabel('Tiempo(s)')
            ylabel('Voltaje(V)')
            title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
            else 
                 %Calculo de Vrms
            vrms=sqrt(sum(y2.^2)/length(y2));
            set(handles.txtVrms2,'String',vrms);
             %Calculo del promedio
            prom=round(mean(y2));
            set(handles.txtVavg2,'String',prom);
            axis manual
            plot(t1,y1,'green',t2,y2,'yellow')    
            grid on
            axis([0 10 -4 4])
            set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
            set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
            xlabel('Tiempo(s)')
            ylabel('Voltaje(V)')
            title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
            end 
           
       case 2
           %%Entrada DC, es tal cual viene la señal,con offset incluido
                  %Calculo de Vrms
                 vrms=sqrt(sum(y2.^2)/length(y2));
                 set(handles.txtVrms2,'String',vrms);
                 %Calculo del promedio
                 prom=round(mean(y2));
                 set(handles.txtVavg2,'String',prom);
                 axis manual
                 plot(t1,y1,'green',t2,y2,'yellow')     
                 grid on
                 axis([0 10 -4 4])
                 set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
                 set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
                 xlabel('Tiempo(s)')
                 ylabel('Voltaje(V)')
                 title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
       case 3 %Tierra, la gráfica es cte en cero
            %Calculo de Vrms
            vrms=0;
            set(handles.txtVrms2,'String',vrms);
             %Calculo del promedio
            prom=0;
            set(handles.txtVavg2,'String',prom);
                axis manual
                x=5*t1;
                y2=0*x;
                plot(t1,y1,'green',x,y2,'yellow')   
                grid on
                axis([0 10 -4 4])
                set(gca, 'xtick', [0 1 2 3 4 5 6 7 8 9 10]);
                set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
                xlabel('Tiempo(s)')
                ylabel('Voltaje(V)')
                title('Gráfica de Amplitud (V(t)) contra Tiempo (s)')
   end
    
    est1=get(handles.btnChannel1,'Value');
    est2=get(handles.btnChannel2,'Value');
    
    nue=get(handles.btnAdquirir,'Value');
    if (nue==0)
        break
    end
    end
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Lisajouss(handles)
est1=get(handles.btnChannel1,'Value');
est2=get(handles.btnChannel2,'Value');

    while (est1==1 && est2==1) 
    % Adquiere los datos
%      [datos1,ta]=startForeground(handles.s);   
%      [datos2,tb]=startForeground(handles.s);
    pause(0.2);
    %Volt/divi (modifica amplitud)
   op=get(handles.lstVDiv1, 'Value');
   op1=get(handles.lstVDiv2, 'Value');
   switch op
    case 1 
        volt=0.5;
    case 2 
        volt=1;
    case 3 
        volt=2.5;
    case 4
        volt=5;
   end
   switch op1
    case 1 
        volt1=0.5;
    case 2 
        volt1=1;
    case 3 
        volt1=2.5;
    case 4
        volt1=5;
   end

%seg/div (Modifica los ciclos)
  t=10;
   op2=get(handles.lstSDiv1,'Value');
   op3=get(handles.lstSDiv2,'Value');
    frec=100;
    Fs=1000*frec;
    offset=0;
    Amp=5;
        switch op2
            case 1             
                  N1=Fs*t;
                  t1=(0:N1)*1/Fs;
                  Arg=(2*pi)*(frec*t1/10000);%Se divide para que cada cuadro tenga el valor esperado de t=0.001
               
            case 2 
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/4000);%Para t=0.0025
              
            case 3 
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/2000);%Para t=0.005
                            
            case 4
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/1000);%Para t=0.010
            
            case 5
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/400);%Para t=0.025
            case 6
                N1=Fs*t;
                t1=(0:N1)*1/Fs;
                Arg=(2*pi)*(frec*t1/200);%Para t=0.050
        end
        switch op3
            case 1             
                  N1=Fs*t;
                  t2=(0:N1)*1/Fs;
                  Arg2=(2*pi)*(frec*t2/10000);%Se divide para que cada cuadro tenga el valor esperado de t=0.001
               
            case 2 
                N1=Fs*t;
                t2=(0:N1)*1/Fs;
                Arg2=(2*pi)*(frec*t2/4000);%Para t=0.0025
              
            case 3 
                N1=Fs*t;
                t2=(0:N1)*1/Fs;
                Arg2=(2*pi)*(frec*t2/2000);%Para t=0.005
                            
            case 4
                N1=Fs*t;
                t2=(0:N1)*1/Fs;
                Arg2=(2*pi)*(frec*t2/1000);%Para t=0.010
            
            case 5
                N1=Fs*t;
                t2=(0:N1)*1/Fs;
                Arg2=(2*pi)*(frec*t2/400);%Para t=0.025
            case 6
                N1=Fs*t;
                t2=(0:N1)*1/Fs;
                Arg2=(2*pi)*(frec*t2/200);%Para t=0.050
        end
        %Canal 1, señal sin desfase
    y1=(Amp/volt)*sin(Arg)+offset/volt;
        
        %Canal 2, señal desfasada 90 
         y2=(Amp/volt1)*cos(Arg2)+offset/volt1;
        % Grafica datos
  
    %Calculo del promedio canal 1
    prom=mean(y1);
    valprom1=round(prom);

    %Calculo del promedio canal 2
    prom1=mean(y2);
    valprom2=round(prom1);
    
     Ac1=get(handles.lstAcople,'Value');
     Ac2=get(handles.lstAcople2,'Value');
   
   switch Ac1
       case 1
           % Entrada AC, es decir sin offset
           if offset>0
%             if valprom1>0 
%               
%                   if op2==1 || op2==2
%                     y1=y1-valprom1+1;
%                     else 
%                      y1= y1-valprom1;
%                   end
%            
            y1=y1-offset/volt;
            %Calculo de Vrms
            vrms=sqrt(sum(y1.^2)/length(y1));
            set(handles.txtVrms1,'String',vrms);
             %Calculo del promedio
            prom=round(mean(y1));
            set(handles.txtVavg1,'String',prom);
    
            axis manual
            plot(y1,y2,'red')
            grid on
            axis([-5 5 -4 4])
            set(gca, 'xtick', [-5 -4 -3 -2 -1 0 1 2 3 4 5]);
            set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
            xlabel('Channel 1')
            ylabel('Channel 2')
            title('Gráfica de Lissajous')
            else 
                 %Calculo de Vrms
            vrms=sqrt(sum(y1.^2)/length(y1));
            set(handles.txtVrms1,'String',vrms);
             %Calculo del promedio
            prom=round(mean(y1));
            set(handles.txtVavg1,'String',prom);
            axis manual
            plot(y1,y2,'red')    
            grid on
            axis([-5 5 -4 4])
            set(gca, 'xtick', [-5 -4 -3 -2 -1 0 1 2 3 4 5]);
            set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
            xlabel('Channel 1')
            ylabel('Channel 2')
            title('Gráfica de Lissajous')
            end 
           
       case 2
           %%Entrada DC, es tal cual viene la señal,con offset incluido
                  %Calculo de Vrms
                 vrms=sqrt(sum(y1.^2)/length(y1));
                 set(handles.txtVrms1,'String',vrms);
                 %Calculo del promedio
                 prom=round(mean(y1));
                 set(handles.txtVavg1,'String',prom);
                 axis manual
                 plot(y1,y2,'red')  
                 grid on
                  axis([-5 5 -4 4])
            set(gca, 'xtick', [-5 -4 -3 -2 -1 0 1 2 3 4 5]);
            set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
                 xlabel('Channel 1')
                 ylabel('Channel 2')
                 title('Gráfica de Lissajous')
       case 3 %Tierra, la gráfica es cte en cero
            %Calculo de Vrms
            vrms=0;
            set(handles.txtVrms1,'String',vrms);
             %Calculo del promedio
            prom=0;
            set(handles.txtVavg1,'String',prom);
                axis manual
                x=5*t1;
                y1=0*x;
                plot(y1,y2,'red')
                grid on
                axis([-5 5 -4 4])
                set(gca, 'xtick', [-5 -4 -3 -2 -1 0 1 2 3 4 5]);
                set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
                 xlabel('Channel 1')
                 ylabel('Channel 2')
                 title('Gráfica de Lissajous')
   end
   
    switch Ac2
       case 1
           % Entrada AC, es decir sin offset
           if offset>0
%             if valprom2>0 
%               
%                  if op3==1
%                     y2=y2-valprom2+2;
%                  else 
%                      y2= y2-valprom2;
%                  end
           y2=y2-offset/volt1;
            %Calculo de Vrms
            vrms=sqrt(sum(y2.^2)/length(y2));
            set(handles.txtVrms2,'String',vrms);
             %Calculo del promedio
            prom=round(mean(y2));
            set(handles.txtVavg2,'String',prom);
    
            axis manual
            plot(y1,y2,'red')
            grid on
             axis([-5 5 -4 4])
            set(gca, 'xtick', [-5 -4 -3 -2 -1 0 1 2 3 4 5]);
            set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
            xlabel('Channel 1')
            ylabel('Channel 2')
            title('Gráfica de Lissajous')
            else 
                 %Calculo de Vrms
            vrms=sqrt(sum(y2.^2)/length(y2));
            set(handles.txtVrms2,'String',vrms);
             %Calculo del promedio
            prom=round(mean(y2));
            set(handles.txtVavg2,'String',prom);
            axis manual
            plot(y1,y2,'red')   
            grid on
             axis([-5 5 -4 4])
            set(gca, 'xtick', [-5 -4 -3 -2 -1 0 1 2 3 4 5]);
            set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
             xlabel('Channel 1')
             ylabel('Channel 2')
             title('Gráfica de Lissajous')
            end 
           
       case 2
           %%Entrada DC, es tal cual viene la señal,con offset incluido
                  %Calculo de Vrms
                 vrms=sqrt(sum(y2.^2)/length(y2));
                 set(handles.txtVrms2,'String',vrms);
                 %Calculo del promedio
                 prom=round(mean(y2));
                 set(handles.txtVavg2,'String',prom);
                 axis manual
                 plot(y1,y2,'red')
                 grid on
                  axis([-5 5 -4 4])
            set(gca, 'xtick', [-5 -4 -3 -2 -1 0 1 2 3 4 5]);
            set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
                 xlabel('Channel 1')
                 ylabel('Channel 2')
                 title('Gráfica de Lissajous')
       case 3 %Tierra, la gráfica es cte en cero
            %Calculo de Vrms
            vrms=0;
            set(handles.txtVrms2,'String',vrms);
             %Calculo del promedio
            prom=0;
            set(handles.txtVavg2,'String',prom);
                axis manual
                x=5*t1;
                y2=0*x;
                plot(y1,y2,'red')   
                grid on
                axis([-5 5 -4 4])
            set(gca, 'xtick', [-5 -4 -3 -2 -1 0 1 2 3 4 5]);
            set(gca,'ytick',[-4 -3 -2 -1 0 1 2 3 4]);
                xlabel('Channel 1')
                ylabel('Channel 2')
                title('Gráfica de Lissajous')
   end
  
    est1=get(handles.btnChannel1,'Value');
    est2=get(handles.btnChannel2,'Value');
    
    nue=get(handles.btnAdquirir,'Value');
    if (nue==0)
        break
    end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CreargraficaAcop(handles)
  
    
    op=get(handles.btnAdquirir,'Value');
% Cambia etiqueta del botón
    if op==0
        set(handles.btnAdquirir,'String','ADQUIRIR','BackgroundColor',([0.94 0.94 0.94])); 
    else
        set(handles.btnAdquirir,'String','DETENER','BackgroundColor',([1 0 0])); 
    end
    
    est1=get(handles.btnChannel1,'Value');
    if est1==0
    set(handles.btnChannel1,'String','ON','BackgroundColor',([0.94 0.94 0.94]));    
    else
    set(handles.btnChannel1,'String','OFF','BackgroundColor',([0 1 0]));
    end
    
    est2=get(handles.btnChannel2,'Value');
    if est2==0
    set(handles.btnChannel2,'String','ON','BackgroundColor',([0.94 0.94 0.94]));    
    else
    set(handles.btnChannel2,'String','OFF','BackgroundColor',([1 1 0]));
    end
    
traz=get(handles.lstTrazado,'Value');
while op==1
    
    if(traz==1)
        if(est1==1 && est2==0)
        Chanel1(handles);
%        op=get(handles.btnAdquirir1,'Value');
%      traz=get(handles.lstTrazado,'Value');
        else
            if(est1==0 && est2==1)
                Chanel2(handles);
%              traz=get(handles.lstTrazado,'Value');
%              op=get(handles.btnAdquirir1,'Value');
            else
                if (est1==1 && est2==1) 
%                    op=get(handles.btnAdquirir1,'Value');
                    GraAmbas(handles);
                    
%                   traz=get(handles.lstTrazado,'Value');
                end
            end
        end
    else
        if (est1==1 && est2==1)         
            Lisajouss(handles);
%             op=get(handles.btnAdquirir1,'Value');
        end
%         traz=get(handles.lstTrazado,'Value');
    end
    if(est1==0 && est2==0)
       if(op==1)
           op=0;
       else
           break
       end
    else
          op=get(handles.btnAdquirir,'Value');
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in btnAdquirir.
function btnAdquirir_Callback(hObject, eventdata, handles)
% hObject    handle to btnAdquirir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%  op=get(handles.btnAdquirir,'Value');
% Cambia etiqueta del botón
%     if op==0
%         set(handles.btnAdquirir,'String','ADQUIRIR','BackgroundColor',([0.94 0.94 0.94])); 
%     else
%         set(handles.btnAdquirir,'String','DETENER','BackgroundColor',([1 0 0])); 
%     end
% %     traz=get(handles.lstTrazado,'Value');
% %      
% while op==1
 CreargraficaAcop(handles);
%  op=get(handles.btnAdquirir,'Value');
% end

% Hint: get(hObject,'Value') returns toggle state of btnAdquirir


% --- Executes on selection change in lstTrazado.
function lstTrazado_Callback(hObject, eventdata, handles)
% hObject    handle to lstTrazado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreargraficaAcop(handles);
% Hints: contents = cellstr(get(hObject,'String')) returns lstTrazado contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstTrazado


% --- Executes during object creation, after setting all properties.
function lstTrazado_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstTrazado (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnChannel2.
function btnChannel2_Callback(hObject, eventdata, handles)
% hObject    handle to btnChannel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreargraficaAcop(handles);
% Hint: get(hObject,'Value') returns toggle state of btnChannel2


% --- Executes on selection change in lstVDiv2.
function lstVDiv2_Callback(hObject, eventdata, handles)
% hObject    handle to lstVDiv2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreargraficaAcop(handles);
% Hints: contents = cellstr(get(hObject,'String')) returns lstVDiv2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstVDiv2


% --- Executes during object creation, after setting all properties.
function lstVDiv2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstVDiv2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lstSDiv2.
function lstSDiv2_Callback(hObject, eventdata, handles)
% hObject    handle to lstSDiv2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreargraficaAcop(handles);
% Hints: contents = cellstr(get(hObject,'String')) returns lstSDiv2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstSDiv2


% --- Executes during object creation, after setting all properties.
function lstSDiv2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstSDiv2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lstAcople2.
function lstAcople2_Callback(hObject, eventdata, handles)
% hObject    handle to lstAcople2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreargraficaAcop(handles);
% Hints: contents = cellstr(get(hObject,'String')) returns lstAcople2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstAcople2


% --- Executes during object creation, after setting all properties.
function lstAcople2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstAcople2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtVavg2_Callback(hObject, eventdata, handles)
% hObject    handle to txtVavg2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreargraficaAcop(handles);
% Hints: get(hObject,'String') returns contents of txtVavg2 as text
%        str2double(get(hObject,'String')) returns contents of txtVavg2 as a double


% --- Executes during object creation, after setting all properties.
function txtVavg2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtVavg2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtVrms2_Callback(hObject, eventdata, handles)
% hObject    handle to txtVrms2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreargraficaAcop(handles);
% Hints: get(hObject,'String') returns contents of txtVrms2 as text
%        str2double(get(hObject,'String')) returns contents of txtVrms2 as a double


% --- Executes during object creation, after setting all properties.
function txtVrms2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtVrms2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnChannel1.
function btnChannel1_Callback(hObject, eventdata, handles)
% hObject    handle to btnChannel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreargraficaAcop(handles);
% Hint: get(hObject,'Value') returns toggle state of btnChannel1


% --- Executes on selection change in lstVDiv1.
function lstVDiv1_Callback(hObject, eventdata, handles)
% hObject    handle to lstVDiv1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreargraficaAcop(handles);
% Hints: contents = cellstr(get(hObject,'String')) returns lstVDiv1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstVDiv1


% --- Executes during object creation, after setting all properties.
function lstVDiv1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstVDiv1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lstSDiv1.
function lstSDiv1_Callback(hObject, eventdata, handles)
% hObject    handle to lstSDiv1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreargraficaAcop(handles);
% Hints: contents = cellstr(get(hObject,'String')) returns lstSDiv1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstSDiv1


% --- Executes during object creation, after setting all properties.
function lstSDiv1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstSDiv1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lstAcople.
function lstAcople_Callback(hObject, eventdata, handles)
% hObject    handle to lstAcople (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreargraficaAcop(handles);
% Hints: contents = cellstr(get(hObject,'String')) returns lstAcople contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstAcople


% --- Executes during object creation, after setting all properties.
function lstAcople_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstAcople (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtVavg1_Callback(hObject, eventdata, handles)
% hObject    handle to txtVavg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreargraficaAcop(handles);
% Hints: get(hObject,'String') returns contents of txtVavg1 as text
%        str2double(get(hObject,'String')) returns contents of txtVavg1 as a double


% --- Executes during object creation, after setting all properties.
function txtVavg1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtVavg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtVrms1_Callback(hObject, eventdata, handles)
% hObject    handle to txtVrms1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreargraficaAcop(handles);
% Hints: get(hObject,'String') returns contents of txtVrms1 as text
%        str2double(get(hObject,'String')) returns contents of txtVrms1 as a double


% --- Executes during object creation, after setting all properties.
function txtVrms1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtVrms1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.btnChannel1);
delete(handles.btnChannel2);
delete(handles.btnAdquirir);
% Hint: delete(hObject) closes the figure
delete(hObject);
