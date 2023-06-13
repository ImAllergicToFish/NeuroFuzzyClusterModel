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
        end

        function norm(obj)
            for i = 1:length(obj.weights)
                currentExample = obj.examplesX(i, :);
                [y, k] = obj.eval(currentExample);           
                if y ~= obj.weights(i)
                    for j = 1:length(obj.functions(i, :))
                        cij = obj.functions(i, j).c;
                        ckj = obj.functions(k, j).c;
                        wk = obj.weights(k);
                        wi = obj.weights(i);
        
                        x = (cij - ckj)*wk/(wk - wi) + ckj;

                        if ckj < cij
                            obj.functions(k, j).h= x;
                        else 
                            obj.functions(k, j).l = x;
                        end
                    end
   
                end
            end
        end

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

        function [result, k] = eval(obj, input)
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
        
        function y = exec(obj, input)
            [y, ~] = obj.eval(input);
        end

        function e = train(obj, rmse_accuracy)

            y = obj.weights;
            yc = [];
            for i = 1:length(y)
                x = obj.examplesX(i, :);
                yc = [yc, obj.exec(x)];
            end
            e = rmse(y, yc, "all");
            disp(['RMSE: ', num2str(e)]);

            while e > rmse_accuracy
                obj.norm();
                yc = [];
                for i = 1:length(y)
                    x = obj.examplesX(i, :);
                    yc = [yc, obj.exec(x)];
                end
                e = rmse(y, yc, "all");
                disp(['RMSE: ', num2str(e)]);
            end
        end

        function plotRules(obj)
            %figure("Name", "A");
            xMin = min(reshape(obj.examplesX, [], 1));
            xMax = max(reshape(obj.examplesX, [], 1));
            xt = linspace(xMin, xMax, 100);
            for i = 1:length(obj.functions)
                yt = [];
                for j = 1:length(xt)
                    yt = [yt, obj.functions(i, 1).eval(xt(j))];
                end
                
                plot(xt, yt, '-');
                hold on;
            end
            hold off;
        end
    end
end

