function list = searchfile(varargin)
% SEARCHFILE search for files and/or directories under a given folder
% Syntax
%       list = searchfile('dir', 'filter', 'recflag')
%
%                   'dir'(Optional) -
%                   The source directory where to search. If not specified,
%                   current working directory will be used
%
%                   'filter'(Optional) -
%                   File filter('*.txt', 'ABC*.*' etc)
%
%                   'recflag'(Optional) -
%                   1 = Recurse into subdirectory, otherwise look only in
%                   the specified/current directory
%
%           Eg: list = searchfile('C:\Temp', '*.txt', 1);
%               list = searchfile('*.txt', 1);
%               list = searchfile(1);
%
%       Return value : Structure with following fields
%               'name'      - Name of the file/directory
%               'path'      - Path to the file/directory
%               'fullpath'  - Full path of the file/directory including its
%                             name
%               'isdir'     - Flag indicates whether a directory or file
%                             1 = Directory, 0 = File
%

% Author : Rahul P N
% Date   : 26/06/2009


% Initialize the structure for file/dir info
list = struct('name', [], 'path', [], 'fullpath', [], 'isdir', []);
lstcnt = 0;

strCurrDir = cd;

strSrcPath = '';
strFilter = '';
nRecFlag = '';

strErrMsg1 = 'Invalid argument passed';
strErrMsg2 = 'Invalid number of arguments passed';

switch nargin
    case 0
        strSrcPath = strCurrDir;
    case 1
        if(isdir(varargin{1}))
            strSrcPath = varargin{1};
        elseif(ischar(varargin{1}))
            strFilter = varargin{1};
        elseif(isnumeric(varargin{1}) && varargin{1} == 1)
            nRecFlag = ' /S';
        else
            error(strErrMsg1);
        end
    case 2
        if(isdir(varargin{1}))
            strSrcPath = varargin{1};
            if(ischar(varargin{2}))
                strFilter = varargin{2};
            elseif(isnumeric(varargin{2}) && varargin{2} == 1)
                nRecFlag = ' /S';
            else
                error(strErrMsg1);
            end
        elseif(ischar(varargin{1}))
            strSrcPath = strCurrDir;
            strFilter = varargin{1};
            if(isnumeric(varargin{2}) && varargin{2} == 1)
                nRecFlag = ' /S';
            else
                error(strErrMsg1);
            end
        else
            error(strErrMsg1);
        end
    case 3
        if(isdir(varargin{1}))
            strSrcPath = varargin{1};
            if(ischar(varargin{2}))
                strFilter = varargin{2};
                if(isnumeric(varargin{3})  && varargin{3} == 1)
                    nRecFlag = ' /S';
                else
                    error(strErrMsg1);
                end
            else
                error(strErrMsg1);
            end
        else
            error(strErrMsg1);
        end
    otherwise
        error(strErrMsg);
end

% Make the dir command for DOS
strDirCmd = ['dir ', strFilter, nRecFlag, ' /B'];

% Get the directory/file listing
cd(strSrcPath);
[status, result] = dos(strDirCmd);
cd(strCurrDir);

% If not file found, display message returned by DOS
if(status == 1)
    disp(result);
else

    % Parse the file list string returned by DOS
    strList = regexp(result, '(.*)\n', 'tokens', 'dotexceptnewline');

    % Populate the file/dir list
    for iCount = 1 : size(strList, 2)
        strFullPath = strList{iCount}{1};
        lastSlashIdx = find(strFullPath == '\', 1, 'last');
        if(~isempty(lastSlashIdx))
            strPath = strFullPath(1 : lastSlashIdx-1);
            strName = strFullPath(lastSlashIdx+1:end);
        else
            strPath = strSrcPath;
            strName = strFullPath;
            strFullPath = [strPath, '\', strName];
        end
        if(isdir(strFullPath))
            lstcnt = lstcnt + 1;
            list(lstcnt).fullpath = strFullPath;
            list(lstcnt).name = strName;
            list(lstcnt).path = strPath;
            list(lstcnt).isdir = 1;
        else
            lstcnt = lstcnt + 1;
            list(lstcnt).fullpath = strFullPath;
            list(lstcnt).name = strName;
            list(lstcnt).path = strPath;
            list(lstcnt).isdir = 0;
        end
    end
end

%If list empty, return empty matrix
if(lstcnt == 0)
    list = [];
end