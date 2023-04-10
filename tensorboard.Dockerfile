FROM pytorch/pytorch:2.0.0-cuda11.7-cudnn8-runtime

RUN mkdir /app
RUN pip install --upgrade pip && pip install tensorboard
CMD "bash"