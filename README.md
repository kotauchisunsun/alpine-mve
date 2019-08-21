# Usage

```
sudo docker build -t kotauchisunsun/alpine-mve .
sudo docker run --rm -it --privileged -v `pwd`/image:/image -v `pwd`/scene:/scene kotauchisunsun/alpine-mve ./run.sh 
```
