@echo off
setlocal
chcp 65001

@REM 如需启用 HF Hub 实验性高速传输，取消该行注释。仅在千兆比特以上网速有意义。
@REM https://huggingface.co/docs/huggingface_hub/hf_transfer
rem set HF_HUB_ENABLE_HF_TRANSFER=1

@REM 使用国内镜像站点
set HF_ENDPOINT=https://hf-mirror.com

@REM 使用国内 PyPI 源
set PIP_INDEX_URL=https://mirrors.cernet.edu.cn/pypi/web/simple

set HF_HUB_CACHE=%~dp0\HuggingFaceHub

set TORCH_HOME=%~dp0\TorchHome

set PATH=%PATH%;%~dp0\MinGit\cmd;%~dp0\python_standalone\Scripts

set PYTHONPYCACHEPREFIX=%~dp0\pycache

@REM 重新安装 hf-hub
if not exist ".\python_standalone\Scripts\.hf-reinstalled" (
    echo 正在重新安装 huggingface-hub...
    .\python_standalone\python.exe -s -m pip uninstall --yes huggingface-hub
    .\python_standalone\python.exe -s -m pip install "huggingface-hub[hf-transfer]"
    if %errorlevel% equ 0 (
        echo.> ".\python_standalone\Scripts\.hf-reinstalled"
    )
)

echo 正在下载 Direct3D-S2 V1.1 模型...

.\python_standalone\Scripts\huggingface-cli.exe download ^
"wushuang98/Direct3D-S2" --include "direct3d-s2-v-1-1/*"

.\python_standalone\Scripts\huggingface-cli.exe download ^
"ZhengPeng7/BiRefNet"

.\python_standalone\python.exe -s -c "import torch; torch.hub.load('facebookresearch/dinov2', 'dinov2_vitl14_reg');

echo 脚本执行完毕，如有文件不完整，请重新运行脚本

endlocal
pause
