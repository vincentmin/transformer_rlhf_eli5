FROM pytorch/pytorch:2.0.0-cuda11.7-cudnn8-runtime

RUN apt-get update && apt-get -y install cmake protobuf-compiler git

RUN mkdir /app
COPY requirements.txt /app
WORKDIR /app

RUN pip install --upgrade pip && pip install -r requirements.txt

# Ugly fix: https://github.com/TimDettmers/bitsandbytes/issues/156
RUN cp /opt/conda/lib/python3.10/site-packages/bitsandbytes/libbitsandbytes_cuda117.so /opt/conda/lib/python3.10/site-packages/bitsandbytes/libbitsandbytes_cpu.so

CMD "bash"