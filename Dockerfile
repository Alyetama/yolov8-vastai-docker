# Ultralytics YOLO 🚀, AGPL-3.0 license
# Original: https://github.com/ultralytics/ultralytics/blob/main/docker/Dockerfile

FROM pytorch/pytorch:2.2.2-cuda12.1-cudnn8-runtime
RUN pip install --no-cache-dir nvidia-tensorrt --index-url https://pypi.ngc.nvidia.com

ENV APP_HOME /root
ENV MKL_THREADING_LAYER=GNU

ADD https://github.com/ultralytics/assets/releases/download/v0.0.0/Arial.ttf \
    https://github.com/ultralytics/assets/releases/download/v0.0.0/Arial.Unicode.ttf \
    /root/.config/Ultralytics/

RUN apt update && apt install --no-install-recommends -y \
    gcc git zip curl htop libgl1 libglib2.0-0 libpython3-dev gnupg g++ \
    libusb-1.0-0 libsm6 nvtop nano unzip timg

RUN apt upgrade --no-install-recommends -y openssl tar

WORKDIR $APP_HOME

ADD https://github.com/ultralytics/assets/releases/download/v8.2.0/yolov8n.pt $APP_HOME
ADD https://github.com/ultralytics/assets/releases/download/v8.2.0/yolov8x-cls.pt $APP_HOME
ADD https://github.com/ultralytics/assets/releases/download/v8.2.0/yolov8n-cls.pt $APP_HOME

RUN python3 -m pip install --upgrade pip wheel

RUN pip install numpy==1.23.5 wandb ultralytics albumentations comet pycocotools \
    dill bpytop

RUN touch ~/.no_auto_tmux

RUN git clone https://github.com/gpakosz/.tmux.git && \
    ln -s -f .tmux/.tmux.conf && \
    cp .tmux/.tmux.conf.local .
