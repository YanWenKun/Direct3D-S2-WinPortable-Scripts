@echo off
setlocal
chcp 65001

@REM 编辑为你的 GPU 对应架构
@REM 修改时无需保留 "+PTX" ，其用于前向兼容，防止用户忘了该步骤。
set TORCH_CUDA_ARCH_LIST=6.1+PTX;8.6;8.9;12.0

@REM 使用国内 PyPI 源
set PIP_INDEX_URL=https://mirrors.cernet.edu.cn/pypi/web/simple

set PATH=%PATH%;%~dp0\MinGit\cmd;%~dp0\python_standalone\Scripts

echo 编译安装 voxelize...

.\python_standalone\python.exe -s -m pip install .\Direct3D-S2\third_party\voxelize

if %errorlevel% neq 0 (
    echo 编译安装 voxelize 失败！
    goto :end
)

echo 安装 spconv...

.\python_standalone\python.exe -s -m pip install spconv-cu126

if %errorlevel% neq 0 (
    echo 安装 spconv 失败！
    goto :end
)

@REM echo 编译安装 TorchSparse...

@REM .\python_standalone\python.exe -s -m pip install ^
@REM git+https://ghfast.top/https://github.com/mit-han-lab/torchsparse.git

@REM if %errorlevel% neq 0 (
@REM     echo 编译安装 TorchSparse 失败！
@REM     goto :end
@REM )

@REM echo 编译安装 Direct3D-S2...

@REM .\python_standalone\python.exe -s -m pip install -e .\Direct3D-S2

@REM if %errorlevel% neq 0 (
@REM     echo 编译安装 Direct3D-S2 失败！
@REM     goto :end
@REM )

echo 编译安装完成！

:end
endlocal
pause
