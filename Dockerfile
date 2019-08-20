FROM alpine
RUN apk update
RUN apk add python3 python3-dev libexecinfo-dev mesa-dev
RUN python3 -m venv env
RUN apk add alpine-sdk
RUN source env/bin/activate && pip install conan

#env conan install 
