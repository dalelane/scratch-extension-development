FROM mcr.microsoft.com/devcontainers/javascript-node:0-18-bullseye

# setup the location of the Scratch code
WORKDIR /usr/app
RUN chown node:node /usr/app

# switch to the Scratch developer user account
USER node

# get the base Scratch code
RUN git clone --depth=1 https://github.com/LLK/scratch-vm.git
RUN git clone --depth=1 https://github.com/LLK/scratch-gui.git

# build Scratch vm
WORKDIR /usr/app/scratch-vm
RUN npm install
RUN npm ln

# build Scratch gui
WORKDIR /usr/app/scratch-gui
RUN npm install
RUN npm ln scratch-vm

# location of the Scratch source code
ENV SCRATCH_SRC_HOME=/usr/app

# copy extension development files
WORKDIR /usr/app
COPY 2-build.sh .
COPY 3-run-private.sh .

# initial default build
RUN ./2-build.sh
