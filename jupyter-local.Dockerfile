FROM python:latest
#FROM jupyter/scipy-notebook:ubuntu-22.04
WORKDIR /app

#RUN apk update
#RUN apk add git
#RUN apt install -y git
RUN apt-get update
RUN apt-get install -y postgresql
RUN pip3 install notebook


COPY requirements.txt ./
RUN git clone https://github.com/facebookresearch/fastText.git
RUN pip install fastText/
RUN pip install --no-cache-dir -r requirements.txt
COPY modelo modelo
COPY scripts scripts

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

EXPOSE 8888