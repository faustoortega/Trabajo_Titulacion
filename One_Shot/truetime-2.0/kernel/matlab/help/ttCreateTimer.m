% TTCREATETIMER   Create a one-shot timer and associate an interrupt
%                 handler with the timer.
%
%  Usage: ttCreateTimer(timername, time, handlername)
%
%  Inputs:
%    time         The time when the timer is set to expire.
%    handlername  Name of the interrupt handler to be associated 
%                 with the timer.
%    timername    Name of the timer, must be unique if specified
%       
% See also TTCREATEINTERRUPTHANDLER, TTCREATEPERIODICTIMER, 
%          TTREMOVETIMER

% Copyright (c) 2016 Lund University
%
% Written by Anton Cervin, Dan Henriksson and Martin Ohlin,
% Department of Automatic Control LTH, Lund University, Sweden.
%   
% This file is part of TrueTime 2.0.
%
% TrueTime 2.0 is free software: you can redistribute it and/or
% modify it under the terms of the GNU General Public License as
% published by the Free Software Foundation, either version 3 of the
% License, or (at your option) any later version.
%
% TrueTime 2.0 is distributed in the hope that it will be useful, but
% without any warranty; without even the implied warranty of
% merchantability or fitness for a particular purpose. See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with TrueTime 2.0. If not, see <http://www.gnu.org/licenses/>
