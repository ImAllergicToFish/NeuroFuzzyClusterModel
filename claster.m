classdef claster < handle
    properties 
        functions;
        weights;
        examplesX;
    end
    
    methods
        function obj = claster()
            obj.functions = [];
            obj.weights = [];
            obj.examplesX = [];
        end
        
        function addExample(obj, exampleIn, exampleOut)
            import membershipFunction.*;
            newFunctions = [];
            for i = 1:length(exampleIn)
                newFunctions = [newFunctions, membershipFunction(-realmax, exampleIn(i), realmax)];
            end
            obj.functions = [obj.functions; newFunctions];
            obj.weights = [obj.weights, exampleOut];
            obj.examplesX = [obj.examplesX; exampleIn];

            %obj.exampleNorm(length(obj.weights));
        end

        function norm(obj)
            for i = 1:length(obj.weights)
                currentExample = obj.examplesX(i, :);
                [y, k] = obj.exec(currentExample);
%                 disp(['=== Y AND W AT ', num2str(i),  ' ==='])
%                 disp(y)
%                 disp(obj.weights(i))
                if y ~= obj.weights(i)
%                     disp("NORM")
                    j = obj.getArgmax(i, k);
                    cij = obj.functions(i, j).c;
                    ckj = obj.functions(k, j).c;
                    wk = obj.weights(k);
                    wi = obj.weights(i);

%                     disp(wk)

                    x = (cij - ckj)*wk/(wk - wi) + ckj;
%                     disp(x)
                    if ckj < cij
                        obj.functions(k, j).h= x;
                    else 
                        obj.functions(k, j).l = x;
                    end
                end
            end
        end

%         function exampleNorm(obj, n)
%             m = length(obj.weights);
%             i = 1;
%             k = n;
%             for l = 1:m
%                 i = l;
%                 k = n;
%                 centersi = [];
%                 for j = 1:length(obj.functions(i, :))
%                     centersi = [centersi, obj.functions(i, j).c];
%                 end
%                 [y, ~] = obj.exec(centersi, i);
%                 if y <= obj.weights(i)
%                     centersk = [];
%                     for j = 1:length(obj.functions(k, :))
%                         disp(['K: ', num2str(k)])
%                         centersk = [centersk, obj.functions(k, j).c];
%                     end
%                     [y, ~] = obj.exec(centersk, k);
%                     if y <= obj.weights(i)
%                         continue;
%                     end
% 
%                     i = n;
%                     k = l;
%                 end
% 
%                 j = obj.getArgmax(i, k);
%                 cij = obj.functions(i, j).c;
%                 ckj = obj.functions(k, j).c;
%                 wk = obj.weights(k);
%                 wi = obj.weights(i);
% 
%                 x = (cij - ckj)*wk/(wk - wi + 0.00000000001) + ckj;
%                 disp(['CKJ: ', num2str(ckj)]);
%                 disp(['CIJ: ', num2str(cij)]);
%                 disp(['WK: ', num2str(wk)]);
%                 disp(['WI: ', num2str(wi)]);
% 
%                 if ckj < cij
%                     obj.functions(k, j).h = x;
%                 else 
%                     obj.functions(k, j).l = x;
%                 end
%             end
%         end

        function jMax = getArgmax(obj, i, k)
            jMax = 1;
            diffMax = 0;
            for j = 1:length(obj.functions(i, :))
                currentDiff = abs( obj.functions(k, j).c - obj.functions(i, j).c );
                if currentDiff >= diffMax
                    jMax = j;
                end
            end
        end

        function [result, k] = exec(obj, input)
            ymax = 0;
            k = 1;
            for i = 1:length(obj.weights)
                yj = 1;
                for j = 1:length(obj.functions(i, :))
                    currentYj = obj.functions(i, j).eval(input(j));
                    if currentYj < yj
                        yj = currentYj;
                    end
                end
                currentY = abs(yj * obj.weights(i));
                if currentY > ymax
                    k = i;
                    ymax = currentY;
                end
            end
            result = ymax * sign(obj.weights(k));
        end
        
        function y = eval(obj, input)
            [y, ~] = obj.exec(input);
        end
    end
end

