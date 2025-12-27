# start from a clean base image (replace <version> with the desired release)
FROM runpod/worker-comfyui:5.1.0-base

# install custom nodes using comfy-cli
RUN comfy-node-install comfyui-kjnodes || echo "Warning: comfyui-kjnodes install failed"
RUN comfy-node-install comfyui-ic-light || echo "Warning: comfyui-ic-light install failed"
RUN comfy-node-install comfyui_ipadapter_plus || echo "Warning: comfyui_ipadapter_plus install failed"
RUN comfy-node-install comfyui_essentials || echo "Warning: comfyui_essentials install failed"
RUN comfy-node-install ComfyUI-Hangover-Nodes || echo "Warning: ComfyUI-Hangover-Nodes install failed"

# download models using comfy-cli
# the "--filename" is what you use in your ComfyUI workflow
RUN comfy model download --url https://huggingface.co/KamCastle/jugg/resolve/main/juggernaut_reborn.safetensors --relative-path models/checkpoints --filename juggernaut_reborn.safetensors
RUN comfy model download --url https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus_sd15.bin --relative-path models/ipadapter --filename ip-adapter-plus_sd15.bin
RUN comfy model download --url https://huggingface.co/shiertier/clip_vision/resolve/main/SD15/model.safetensors --relative-path models/clip_vision --filename models.safetensors
RUN comfy model download --url https://huggingface.co/lllyasviel/ic-light/resolve/main/iclight_sd15_fcon.safetensors --relative-path models/diffusion_models --filename iclight_sd15_fcon.safetensors

# Copy local static input files into the ComfyUI input directory (delete if not needed)
# Assumes you have an 'input' folder next to your Dockerfile
# COPY input/ /comfyui/input/