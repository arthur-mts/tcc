create database tcc;
use tcc;
create table partido
(
    sigla    varchar(15) primary key,
    nome     text   not null,
    situacao text,
    uri_logo text   not null,
    uri_site text,
    id       bigint not null
);

create table deputado
(
    id                 bigint primary key,
    nome               text not null,
    nome_eleitoral     text,
    situacao           text not null,
    condicao_eleitoral text not null,
    partido            varchar(15),
    estado             varchar(5) not null,
    uri_foto           text,
    foreign key partido_fk (partido) references partido (sigla)
);

create table proposicoes
(
    id                bigint primary key,
    tipo              varchar(5) not null,
    ano               int        not null,
    ementa            text       not null,
    ementa_detalhada  text,
    uri_documento     text       not null, ## Campo uri_inteiro_teor do documento
    data_apresentacao date,
    ultimo_relator_id bigint,
    foreign key id_ultimo_relator_fk (ultimo_relator_id) references deputado (id),
    situacao          text                 ## Na API é retornado o campo codSituacao. A partir desse codigo irei pegar o texto e colocar aqui
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

create table tesauro_categorias
(
    id    bigint primary key,
    valor text not null
);

create table tesauro_subcategorias
(
    id           bigint primary key,
    categoria_id bigint not null,
    foreign key categoria_id_fk (categoria_id) references tesauro_categorias (id),
    valor        text   not null
);

create table tesauro_termos
(
    id              bigint primary key,
    subcategoria_id bigint not null,
    foreign key subcategoria_id_fk (subcategoria_id) references tesauro_subcategorias (id),
    valor           text   not null
);

alter table proposicoes
    drop column uri_documento;
alter table proposicoes
    add column uri_documento text default null;

create table autor_proposicoes(
    id_proposicao bigint,
    id_deputado bigint,
    foreign key id_deputado_fk (id_deputado) references deputado(id),
    foreign key id_proposicao_fk (id_proposicao) references proposicoes(id),
    primary key (id_proposicao, id_deputado)
);


GRANT ALL PRIVILEGES ON tcc.* TO 'docker'@'%';

