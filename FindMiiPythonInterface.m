function clicks = FindMiiPythonInterface(python_cmd, python_dir, clicks_fn)

% The passed in python command will be run. That should save clicks to a
% .mat file which was saved by clicks.py and  will then be loaded and 
% returned by this function.
% optional arguments:
% python_dir- directory with your python code. this will be added to the
%   python path and prepended to the script name (ie python_dir/python_cmd
%   will be called. defaults to ./python
% clicks_fn- name of the mat file to save clicks in. defaults to
%   'clicks.mat'. This must match the file specified in clicks.py
% Example calling function:
%    function click = FindMiiTask1Level1(datadir)
%      click = FindMiiPythonInterface('t1l1_main.py');
%      return;
% You should not need to modify this file!

if nargin < 1
    python_cmd = 'test.py';
end
if nargin < 2
    python_dir = './python';
end
if nargin < 3
    % Make sure this matches the file name/ path in clicks.py!
    clicks_fn = 'clicks.mat';
end

% set up the environment so that all of our modules load properly...
% it took me 2 hours to figure these 2 lines out...
cv_lib_path = '/afs/ir.stanford.edu/class/cs223b/lib/OpenCV-2.2.0/lib/';
setenv('PYTHONPATH', [cv_lib_path ':' python_dir])
setenv('LD_LIBRARY_PATH', cv_lib_path)


% run the python script
display('')
display('*******************************')
display(['Running command: ' python_cmd])
result = unix([python_dir '/' python_cmd], '-echo');

% check whether python encountered and error
if result ~= 0 
    error('Python Script encountered an Error');
end

% this mat file should have a variable in it called 'clicks', which is then
% returned
load(clicks_fn)
unix(['rm -f ' clicks_fn]);

end



