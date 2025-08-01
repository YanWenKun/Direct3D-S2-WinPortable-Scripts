@echo off
setlocal
chcp 65001

@REM 编辑为你的 GPU 对应架构
@REM 修改时无需保留 "+PTX" ，其用于前向兼容，防止用户忘了该步骤。
set TORCH_CUDA_ARCH_LIST=6.1+PTX;7.5;8.6;8.9+PTX

@REM 使用国内 PyPI 源
set PIP_INDEX_URL=https://mirrors.cernet.edu.cn/pypi/web/simple

set PATH=%PATH%;%~dp0\MinGit\cmd;%~dp0\python_standalone\Scripts
set VCPKG_ROOT=%~dp0\vcpkg

echo 编译安装 voxelize...

.\python_standalone\python.exe -s -m pip install .\Direct3D-S2\third_party\voxelize

if %errorlevel% neq 0 (
    echo 编译安装 voxelize 失败！
    goto :end
)

echo 安装 TorchSparse...

.\python_standalone\python.exe -s -m pip install ^
https://gh-proxy.com/https://github.com/Deathdadev/torchsparse/releases/download/v2.1.0-windows/torchsparse-2.1.0-cp310-cp310-win_amd64.whl

if %errorlevel% neq 0 (
    echo 安装 TorchSparse 失败！
    goto :end
)

echo 编译安装 utils3d...

.\python_standalone\python.exe -s -m pip uninstall --yes utils3d

.\python_standalone\python.exe -s -m pip install ^
git+https://gh-proxy.com/https://github.com/EasternJournalist/utils3d.git#egg=utils3d

if %errorlevel% neq 0 (
    echo 编译安装 utils3d 失败！
    goto :end
)

echo 编译安装 Direct3D-S2...

.\python_standalone\python.exe -s -m pip install -e .\Direct3D-S2

if %errorlevel% neq 0 (
    echo 编译安装 Direct3D-S2 失败！
    goto :end
)

echo 编译安装完成！

:end
endlocal
pause
