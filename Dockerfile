FROM alpine
RUN apk update
RUN apk add alpine-sdk make git libjpeg tiff-dev libpng-dev mesa-dev libunwind-dev
RUN mkdir work
WORKDIR work
RUN git clone --depth=1 https://github.com/simonfuhrmann/mve.git
WORKDIR mve
RUN env OPENMP="-lpng -ltiff -ljpeg -lgomp -lexecinfo -lstdc++ -lz -fopenmp" LDFLAGS="-flto -s" make -j16
RUN mkdir bin
RUN find apps -type f | fgrep -v "." | grep -v Makefile | xargs -IXXXX cp XXXX bin/

FROM alpine
COPY --from=0 /work/mve/bin/* /bin/
RUN apk update --no-cache && apk add gcc g++ gmp libjpeg tiff libpng mesa libunwind libexecinfo
COPY run.sh run.sh
