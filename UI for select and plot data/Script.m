% Clear workspace and the command window
clc
clear all

% Ask the user to select the location

[Loc,indx] = GetLocation();

switch indx
    case 1
        data = xlsread('lewrick data.xlsx');
        
    case 2
        data = xlsread('Oxford Data.xlsx');
end
yearData = data(:,1);
isdataloaded(Loc); % user wriiten function with no output and one input
% Asking user to select the year
list = {'2000','2001','2002','2003','2004','2005','2006','2007','2008','2008','2010','2011','2012','2013','2014','2015','2016','2017','2018','2019','2020','2021'};

[indx,tf] = listdlg('ListString',list,'ListSize', [150 300],'SelectionMode','single','PromptString','Choose Year');

Year = year_calculator(indx); % function with one input and output function


list = {'tmax (c)','tmin (c)','rain(mm)'};
[indx,tf] = listdlg('ListString',list,'ListSize', [150 30],'SelectionMode','single','PromptString','Choose Graph');
graph = string(list(indx));

switch graph
    case 'tmax (c)'
        plotted_data = data(:,3);
    case 'tmin (c)'
        plotted_data = data(:,4);
    case 'rain(mm)'
        plotted_data = data(:,5);
end

answer = questdlg(join(['Location is',Loc,'and year is',num2str(Year)]), ...
	'Confirm Location and year', ...
	'Confirmed','Not Confirmed','Not Confirmed');
if string(answer) == 'Confirmed'
    plot_month = [];
    for i = 1:length(yearData)
        if (yearData(i) == Year)
            plot_month = [plot_month plotted_data(i)]; % Save the required data for that year
        end
    end
figure,plot(1:12,plot_month),title(join([graph,'graph','For',Loc,'and year is',num2str(Year)])),ylabel(graph),xlabel('Month#'),legend(graph),grid on    
% statistical Analysis
fprintf('Mean of the %s in %d is %0.4f \n',graph,Year,mean(plot_month));
fprintf('Maximum of the %s in %d is %0.4f \n',graph,Year,max(plot_month));
fprintf('Minimum of the %s in %d is %0.4f \n',graph,Year,min(plot_month));

else
    errorgenerator();
end

function [Year] = year_calculator(indx)

Year = indx +1999; % input 1 output 1
end

function [] = isdataloaded(Loc)
% input 1 output 0
uiwait(msgbox(join(['Data Loaded for',Loc]),'Success'));
end

function [] = errorgenerator()
    % no input no output
    errordlg('Location or year Not Confirmed');
end

function [Loc,indx] = GetLocation()
% No input but output
list = {'Lewrick','Oxford'};
[indx,tf] = listdlg('ListString',list,'ListSize', [150 30],'SelectionMode','single','PromptString','Choose Location');
Loc = string(list(indx));
end



            
        
        
    


