@echo off
setlocal

@REM Edit this to your GPU arch.
@REM You don't need to add the "+PTX". Here it works as a fail-safe (providing forward compatibility).
set TORCH_CUDA_ARCH_LIST=6.1+PTX;8.6;8.9;12.0

@REM To set mirror site for PIP, uncomment and edit the line below.
rem set PIP_INDEX_URL=https://mirrors.cernet.edu.cn/pypi/web/simple

set PATH=%PATH%;%~dp0\MinGit\cmd;%~dp0\python_standalone\Scripts

echo Compile-installing voxelize...

.\python_standalone\python.exe -s -m pip install .\Direct3D-S2\third_party\voxelize

if %errorlevel% neq 0 (
    echo Failed to compile-install voxelize!
    goto :end
)

echo Compile-installing TorchSparse...

.\python_standalone\python.exe -s -m pip install ^
git+https://github.com/mit-han-lab/torchsparse.git

if %errorlevel% neq 0 (
    echo Failed to compile-install TorchSparse!
    goto :end
)

echo Compile-installing Direct3D-S2...

.\python_standalone\python.exe -s -m pip install -e .\Direct3D-S2

if %errorlevel% neq 0 (
    echo Failed to compile-install Direct3D-S2!
    goto :end
)

echo Compile-install Finished!

:end
endlocal
pause
