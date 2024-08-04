FROM python:3.8 as model

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN git clone https://github.com/facebookresearch/fastText.git
RUN pip install fastText/
RUN pip install --no-cache-dir -r requirements.txt

COPY modelo modelo
COPY scripts scripts
RUN mkdir output
#COPY fasttext/cc.pt.300.bin cc.pt.300.bin
#RUN jupyter nbconvert --execute --to html modelo/clusterizar_tags.ipynb --output output/tags.html
CMD ["jupyter", "nbconvert","--execute", "--to", "html", "modelo/clusterizar_tags.ipynb", "--output", "output/tags.html"]
#CMD ["jupyter", "nbconvert","--execute", "--to", "html", "modelo/classificar_proposicoes.ipynb", "--output", "output/prop.html"]
