classdef membershipFunction < handle

    properties
        l;
        c;
        h;
    end
    
    methods
        
        function obj = membershipFunction(l, c, h)
            obj.c = c;
            obj.l = l;
            obj.h = h;
        end
        
        function y = eval(obj, x)
            a = obj.l;
            b = obj.c;
            c = obj.h;
            y = max([min([(x-a)/(b-a), (c-x)/(c-b)]), 0]);
        end
    end
end

