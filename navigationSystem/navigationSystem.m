classdef navigationSystem < handle
    
    properties
        OAsubsystem;
        MGsubsystem;
    end
    
    methods
        function obj = navigationSystem()
            import motionToGoalSubsystem.*
            import obstacleAvoidanceSubsystem.*
            obj.MGsubsystem = motionToGoalSubsystem();
            obj.OAsubsystem = obstacleAvoidanceSubsystem();
        end
        
        function addExampleOA(obj, ld, fd, rd, vl, vr)
           obj.OAsubsystem.addExample(ld, fd, rd, vl, vr);
        end

        function addExampleMG(obj, gd, ga, vl, vr)
           obj.MGsubsystem.addExample(gd, ga, vl, vr);
        end

        function train(obj, rmse_accuracy)
            obj.MGsubsystem.train(rmse_accuracy);
            obj.OAsubsystem.train(rmse_accuracy);
        end

        function [vl , vr] = exec(obj, gd, ga, ld, fd, rd)
            if (ld ~= 0) || (fd ~= 0) || (rd ~= 0)
                [vl, vr] = obj.OAsubsystem.exec(ld, fd, rd);
                return;
            end
            [vl, vr] = obj.MGsubsystem.exec(gd, ga);
        end

    end
end

