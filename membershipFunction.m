classdef membershipFunction < handle

    properties
        l;
        c;
        h;
    end
    
    methods
        %Constructor
        function obj = membershipFunction(l, c, h)
            obj.c = c;
            obj.l = l;
            obj.h = h;
        end
        
        function y = eval(obj, x)
%             if obj.l > obj.h || obj.l > obj.c || obj.c > obj.h
%                 disp('TRIMF ERROR')
%                 disp(obj.l);
%                 disp(obj.c);
%                 disp(obj.h);
%             end

            a = obj.l;
            b = obj.c;
            c = obj.h;

            %y = trimf(x, [obj.l , obj.c, obj.h]);
            y = max([min([(x-a)/(b-a), (c-x)/(c-b)]), 0]);
        end
    end
end

