FROM nvidia/cuda:12.1.1-base-ubuntu22.04

RUN apt update --quiet \
    && apt install --yes --quiet software-properties-common \
    && apt install --yes --quiet git wget build-essential

# Install specific Python version. Tell APT this isn't an
# interactive TTY to avoid prompt when installing.
RUN add-apt-repository ppa:deadsnakes/ppa \
    && DEBIAN_FRONTEND=noninteractive apt install --yes --quiet python3.12 python3-pip python3.12-venv python3.12-dev

# Create a Python virtual environment.
ENV VENV_PATH="/blt_venv" 
RUN python3.12 -m venv "$VENV_PATH"
ENV PATH="$VENV_PATH/bin:$PATH"

# Upgrade pip.
RUN pip install --upgrade pip

# Set working directory.
WORKDIR /app

# Clone the source code repository.
RUN git clone https://github.com/rickydeluca/blt.git
WORKDIR /app/blt

# Install Python dependencies.
RUN pip install --pre torch --index-url https://download.pytorch.org/whl/nightly/cu121 \
RUN pip install ninja
RUN pip install -v -U git+https://github.com/facebookresearch/xformers.git@de742ec3d64bd83b1184cc043e541f15d270c148
RUN pip install -r requirements.txt

# Start an interactive shell.
CMD ['bash']
