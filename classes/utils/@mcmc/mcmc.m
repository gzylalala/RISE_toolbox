classdef mcmc
    
    properties
        pnames
        nchains
        npop
        nparams
        draws
        i_dropped
        start
        psrf
        best
    end
    
    methods
        
        function obj=mcmc(draws,pnames,drop)
            
            if nargin<3
                
                drop=[];
                
                if nargin<2
                    
                    pnames=[];
                    
                    if nargin<1
                        
                        return
                        
                    end
                    
                end
                
            end
            
            [obj.draws,obj.i_dropped,obj.start,results_summary]=mcmc.process_draws(draws,drop);
            
            obj.best=results_summary.best;
            
            [obj.nchains,obj.npop]=size(obj.draws);
            
            obj.nparams=numel(obj.draws(1).x);
            
            if isempty(pnames)
                
                pnames=parser.create_state_list('p',obj.nparams);
                
            end
            
            obj.pnames=pnames;
            
            obj.psrf=gelman_rubin(obj,true);
            
        end
        
        varargout=traceplot(varargin)
        
        varargout=densplot(varargin)
        
        varargout=meanplot(varargin)
        
        varargout=autocorrplot(varargin)
        
        varargout=gelman_plot(varargin)
        
        varargout=summary(varargin)
        
        varargout=heidelberg_welch(varargin)
        
    end
    
    methods(Static)
        
        varargout=process_draws(varargin)
        
    end
    
    methods(Access=private)
        
        varargout=load_draws(varargin)
        
        varargout=gelman_rubin(varargin)
        
    end
    
end