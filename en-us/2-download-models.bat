@echo off
setlocal

@REM To enable HuggingFace Hub's experimental high-speed file transfer, uncomment the line below.
@REM https://huggingface.co/docs/huggingface_hub/hf_transfer
rem set HF_HUB_ENABLE_HF_TRANSFER=1

@REM To set mirror site for HuggingFace Hub, uncomment and edit the line below.
rem set HF_ENDPOINT=https://hf-mirror.com

@REM To set mirror site for PIP, uncomment and edit the line below.
rem set PIP_INDEX_URL=https://mirrors.cernet.edu.cn/pypi/web/simple

set HF_HUB_CACHE=%~dp0\HuggingFaceHub

set TORCH_HOME=%~dp0\TorchHome

set PATH=%PATH%;%~dp0\MinGit\cmd;%~dp0\python_standalone\Scripts

set PYTHONPYCACHEPREFIX=%~dp0\pycache

@REM Reinstall hf-hub
if not exist ".\python_standalone\Scripts\.hf-reinstalled" (
    echo Reinstalling huggingface-hub...
    .\python_standalone\python.exe -s -m pip uninstall --yes huggingface-hub
    .\python_standalone\python.exe -s -m pip install "huggingface-hub[hf-transfer]"
    if %errorlevel% equ 0 (
        echo.> ".\python_standalone\Scripts\.hf-reinstalled"
    )
)

echo Downloading Direct3D-S2 V1.1 models from HuggingFace...

.\python_standalone\Scripts\huggingface-cli.exe download ^
"wushuang98/Direct3D-S2" --include "direct3d-s2-v-1-1/*"

.\python_standalone\Scripts\huggingface-cli.exe download ^
"ZhengPeng7/BiRefNet"

.\python_standalone\python.exe -s -c "import torch; torch.hub.load('facebookresearch/dinov2', 'dinov2_vitl14_reg');"

echo The script has finished executing. If any files are incomplete, please rerun the script.

endlocal
pause
