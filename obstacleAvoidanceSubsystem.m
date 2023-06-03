classdef obstacleAvoidanceSubsystem < handle
    
    properties
        cmVL;
        cmVR;
    end
    
    methods
        function obj = obstacleAvoidanceSubsystem()
            import claster.*;
            obj.cmVL = claster();
            obj.cmVR = claster();
        end
        
        function addExample(obj, ld, fd, rd, vl, vr)
            obj.cmVL.addExample([ld, fd, rd], vl);
            obj.cmVR.addExample([ld, fd, rd], vr);
        end

        function train(obj, RMSE)
            obj.cmVL(RMSE);
            obj.cmVR(RMSE);
        end

        function [vl, vr] = exec(obj, ld, fd, rd)
            vl = obj.cmVL.exec([ld, fd, rd]);
            vr = obj.cmVR.exec([ld, fd, rd]);
        end
    end
end

