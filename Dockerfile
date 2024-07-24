FROM python:3.8

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY modelo modelo
COPY scripts scripts
COPY fasttext/cc.pt.300.bin cc.pt.300.bin

CMD ["jupyter", "nbconvert","--execute", "--to", "html", "modelo/clusterizar_tags.ipynb", "-o", "output_tags.html"]
CMD ["jupyter", "nbconvert","--execute", "--to", "html", "modelo/classificar_proposicoes.ipynb", "-o", "output_prop.html"]

#RUN cp /output_tags.html /output
#RUN cp /output_prop.html /output
