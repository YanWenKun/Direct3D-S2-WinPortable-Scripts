@echo off
setlocal
chcp 65001

set PATH=%PATH%;%~dp0\MinGit\cmd;%~dp0\python_standalone\Scripts

REM 检查 git 是否存在
where git >nul 2>&1
if errorlevel 1 (
    echo 错误： git 命令未找到。请确保已安装 git 并将其添加到 PATH 环境变量。
    echo 下载： https://git-scm.com/downloads/win
    goto :error
)

set "target_dir=Direct3D-S2"

REM 检查目标目录是否存在
if not exist "%target_dir%" (
    echo 错误：目标目录 "%target_dir%" 不存在。
    goto :error
)

REM 进入目标目录
pushd "%target_dir%"

echo 正在执行 git reset --hard...
git reset --hard
if errorlevel 1 (
    echo 错误： git reset --hard 执行失败。
    goto :error
)

REM 检查 git remote 地址是否以 https://github.com 开头并替换为国内代理
echo 正在检查 git remote 地址...
for /f "delims=" %%i in ('git remote get-url origin') do set "remote_url=%%i"
echo 当前 remote 地址: %remote_url%

echo %remote_url%|findstr /r /c:"^https://github.com" >nul
if not errorlevel 1 (
    echo 检测到 GitHub 地址，添加代理前缀...
    git remote set-url origin https://gh-proxy.com/%remote_url%
    echo 新 remote 地址: https://gh-proxy.com/%remote_url%
)

echo 正在执行 git pull...
git pull
if errorlevel 1 (
    echo 错误： git pull 执行失败。
    goto :error
)

popd

set "target_dir=WinScripts"

if not exist "%target_dir%" (
    echo 错误：目标目录 "%target_dir%" 不存在。
    goto :error
)

pushd "%target_dir%"

echo 正在执行 git reset --hard...
git reset --hard
if errorlevel 1 (
    echo 错误： git reset --hard 执行失败。
    goto :error
)

REM 检查 git remote 地址是否以 https://github.com 开头并替换为国内代理
echo 正在检查 git remote 地址...
for /f "delims=" %%i in ('git remote get-url origin') do set "remote_url=%%i"
echo 当前 remote 地址: %remote_url%

echo %remote_url%|findstr /r /c:"^https://github.com" >nul
if not errorlevel 1 (
    echo 检测到 GitHub 地址，添加代理前缀...
    git remote set-url origin https://gh-proxy.com/%remote_url%
    echo 新 remote 地址: https://gh-proxy.com/%remote_url%
)

echo 正在执行 git pull...
git pull
if errorlevel 1 (
    echo 错误： git pull 执行失败。
    goto :error
)

start /d .\zh-cn init.bat

echo 已在新窗口执行脚本，可关闭本窗口

popd

goto :eof

:error
echo 脚本执行过程中发生错误。

:eof
endlocal
pause
