FROM alpine
RUN apk update
RUN apk add python3 python3-dev libexecinfo-dev mesa-dev
RUN python3 -m venv env
RUN source env/bin/activate
RUN pip install conan

#env conan install 
