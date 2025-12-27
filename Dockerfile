# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# No registry-verified custom nodes found.
# The workflow lists only unknown_registry nodes and none include an aux_id (GitHub repo) to clone, so they could not be resolved automatically:
# Could not resolve: CheckpointLoaderSimple
# Could not resolve: Reroute
# Could not resolve: Reroute
# Could not resolve: Reroute
# Could not resolve: Reroute
# Could not resolve: Bus Node
# Could not resolve: Reroute
# Could not resolve: CR Apply LoRA Stack
# Could not resolve: Reroute
# Could not resolve: PreviewImage
# Could not resolve: UpscaleModelLoader
# Could not resolve: Reroute
# Could not resolve: Reroute
# Could not resolve: Reroute
# Could not resolve: Image Save
# Could not resolve: UltimateSDUpscale
# Could not resolve: PreviewImage
# Could not resolve: ToDetailerPipe
# Could not resolve: SAMLoader
# Could not resolve: Reroute
# Could not resolve: LoRA Stacker
# Could not resolve: CLIPTextEncode
# Could not resolve: KSampler (Efficient)
# Could not resolve: UltralyticsDetectorProvider
# Could not resolve: Note
# Could not resolve: Note
# Could not resolve: Bus Node
# Could not resolve: Bus Node
# Could not resolve: Bus Node
# Could not resolve: Bus Node
# Could not resolve: Bus Node
# Could not resolve: ImageSharpen
# Could not resolve: Note
# Could not resolve: CLIPTextEncode
# Could not resolve: Seed (rgthree)
# Could not resolve: ImageSharpen
# Could not resolve: PreviewImage
# Could not resolve: Note
# Could not resolve: CR SDXL Aspect Ratio
# Could not resolve: CLIPTextEncode
# Could not resolve: workflow/Switch Detector
# Could not resolve: Image Save
# Could not resolve: Note
# Could not resolve: FaceDetailerPipe
# Could not resolve: Seed (rgthree)
# Could not resolve: MediaPipeFaceMeshDetectorProvider //Inspire
# Could not resolve: CLIPTextEncode

# download models into comfyui
RUN comfy model download --url https://huggingface.co/AiWise/Juggernaut-XL-V9-GE-RDPhoto2-Lightning_4S/blob/main/juggernautXL_v9Rdphoto2Lightning.safetensors --relative-path models/checkpoints --filename juggernautXL_v9Rdphoto2Lightning.safetensors
RUN comfy model download --url https://huggingface.co/gemasai/4x_NMKD-Siax_200k/resolve/main/4x_NMKD-Siax_200k.pth --relative-path models/upscale_models --filename 4x_NMKD-Siax_200k.pth
RUN comfy model download --url https://dl.fbaipublicfiles.com/segment_anything/sam_vit_b_01ec64.pth --relative-path models/checkpoints --filename sam_vit_b_01ec64.pth
RUN comfy model download --url https://huggingface.co/Kentus/Adetailer/blob/main/Eyeful_v1.pt --relative-path models/checkpoints --filename Eyeful_v1.pt

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/