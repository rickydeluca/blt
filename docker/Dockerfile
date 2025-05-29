FROM nvidia/cuda:12.1.1-base-ubuntu22.04

# System dependencies
RUN apt-get update --quiet \
    && apt-get install --yes --quiet software-properties-common \
    && apt-get install --yes --quiet git wget gcc g++ make

# Python
RUN add-apt-repository ppa:deadsnakes/ppa \
    && DEBIAN_FRONTEND=noninteractive apt-get install --yes --quiet python3.12 python3-pip python3.12-venv python3.12-dev

# Python virtual environment
ENV VENV_PATH="/opt/blt_venv" 
RUN python3.12 -m venv "$VENV_PATH"
ENV PATH="$VENV_PATH/bin:$PATH"

# Upgrade pip
RUN pip install --upgrade pip setuptools wheel

# Set working directory
WORKDIR /app

# Get the code
RUN git clone https://github.com/facebookresearch/blt.git
WORKDIR /app/blt

# Python dependencies 
RUN pip install --pre torch --index-url https://download.pytorch.org/whl/nightly/cu121 \
    && pip install ninja \
    && pip install -v -U git+https://github.com/facebookresearch/xformers.git@de742ec3d64bd83b1184cc043e541f15d270c148 \
    && pip install -r requirements.txt

# Run a loop application to keep the container running
CMD ["bash", "-c", "while true; do sleep 30; done;"]
