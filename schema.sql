create table partido
(
    id       bigint primary key,
    nome     text not null,
    situacao text,
    uri_logo text not null,
    uri_site text
);

create table deputado
(
    id                 bigint primary key,
    nome               text   not null,
    nome_eleitoral     text,
    situacao           text   not null,
    condicao_eleitoral text   not null,
    partido_slug       varchar(5),
    partido_id         bigint not null,
    foreign key partido_fk (partido_id) references partido (id)
);

create table proposicoes
(
    id                bigint primary key,
    tipo              varchar(5) not null,
    ano               int        not null,
    ementa            text       not null,
    ementa_detalhada  text       not null,
    uri_documento     text       not null, ## Campo uri_inteiro_teor do documento
    data_apresentacao date,
    ultimo_relator_id bigint     not null,
    foreign key id_ultimo_relator_fk (ultimo_relator_id) references deputado (id),
    situacao          text       not null  ## Na API é retornado o campo codSituacao. A partir desse codigo irei pegar o texto e colocar aqui
);

## A partir do campo keywords retornado na API preencher essa tabela
## Com isso podemos buscar facilmente as proposicoes que tem algum tipo de keyword
create table proposicoes_keywords
(
    keyword       text   not null,
    proposicao_id bigint not null,
    foreign key proposicao_id_fk (proposicao_id) references proposicoes (id)
);

## O valor dessas tabelas sera preechido com os CSVs disponibilizados nessa página:
## https://dadosabertos.camara.leg.br/swagger/api.html#staticfile -> Tesauro da câmara dos deputados

create table tesauro_categorias(
    id bigint primary key,
    valor text not null
);

create table tesauro_subcategorias(
    id bigint primary key,
    categoria_id bigint not null,
    foreign key categoria_id_fk (categoria_id) references tesauro_categorias(id),
    valor text not null
);

create table tesauro_termos(
    id bigint primary key,
    subcategoria_id bigint not null,
    foreign key subcategoria_id_fk (subcategoria_id) references tesauro_subcategorias(id),
    valor text not null
);