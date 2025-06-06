@echo on
setlocal

set ATTN_BACKEND=flash_attn
set SPARSE_BACKEND=torchsparse
set SPARSE_ATTN_BACKEND=flash_attn

@REM To set proxy, edit and uncomment the two lines below (remove 'rem ' in the beginning of line).
rem set HTTP_PROXY=http://localhost:1080
rem set HTTPS_PROXY=http://localhost:1080

@REM ===========================================================================
@REM These settings usually don't need change.

@REM This command will set PATH environment variable.
set PATH=%PATH%;%~dp0\MinGit\cmd;%~dp0\python_standalone\Scripts
set VCPKG_ROOT=%~dp0\vcpkg

@REM This command will let the .pyc files to be stored in one place.
set PYTHONPYCACHEPREFIX=%~dp0\pycache

@REM This command redirects HuggingFace-Hub to download model files in this folder.
set HF_HUB_CACHE=%~dp0\HuggingFaceHub

@REM This command redirects Pytorch Hub to download model files in this folder.
set TORCH_HOME=%~dp0\TorchHome

@REM ===========================================================================

cd Direct3D-S2
..\python_standalone\python.exe -s app.py

cd ..

endlocal
pause
