classdef motionToGoalSubsystem < handle
    %MOTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        cmVL;
        cmVR;
    end
    
    methods

        function obj = motionToGoalSubsystem()
            import claster.*;
            obj.cmVL = claster();
            obj.cmVR = claster();
        end
        
        function outputArg = addExample(obj, gd, ga)
            obj.cmVL.addExample([gd, ga], vl);
            obj.cmVR.addExample([gd, ga], vr);
        end

        function train(obj, rmse_accuracy)
            obj.cmVL(rmse_accuracy);
            obj.cmVR(rmse_accuracy);
        end

        function [vl, vr] = exec(obj, gd, ga)
            vl = obj.cmVL.exec([gd, ga]);
            vr = obj.cmVR.exec([gd, ga]);
        end
    end
end

