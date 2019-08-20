FROM alpine
RUN apk update
RUN apk add python3 python3-dev mesa-dev
RUN python3 -m venv env
RUN apk add cmake
RUN apk add alpine-sdk # for "gcc"
RUN source env/bin/activate && pip install conan
RUN apk add libexecinfo-dev # for "../../libs/util/libmve_util.a(system.o): In function `util::system::print_stack_trace()':"
RUN git clone https://github.com/kotauchisunsun/mve.git
WORKDIR mve
RUN source /env/bin/activate && conan install . --build
RUN env OPENMP="-lunwind -lexecinfo -static-libgcc -static-libstdc++ -fopenmp" LDFLAGS="-flto -s" make all -j8
RUN mkdir bin
RUN find apps -type f | fgrep -v "." | grep -v Makefile | xargs -IXXXX cp XXXX bin/


FROM alpine
COPY --from=0 /mve/bin/* /bin/
RUN apk update --no-cache && apk add libgomp libexecinfo
COPY run.sh run.sh
