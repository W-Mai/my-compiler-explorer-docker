FROM node:latest

# Download all open-source compilers
RUN git clone https://github.com/compiler-explorer/infra.git
WORKDIR /infra
RUN make ce
RUN ./bin/ce_install --enable nightly install compilers

# Download compiler-explorer repo.
RUN git clone https://github.com/compiler-explorer/compiler-explorer.git
RUN git clone https://github.com/compiler-explorer/tools.git

WORKDIR /tools

RUN ./get_compilers.sh

WORKDIR /compiler-explorer

RUN make info
RUN make prebuild

EXPOSE 10240

CMD make dev
