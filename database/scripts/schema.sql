create table partido
(
    sigla    varchar(15) not null
        constraint idx_16403_primary
            primary key,
    nome     text        not null,
    situacao text,
    uri_logo text        not null,
    uri_site text,
    id       bigint      not null
);

alter table partido
    owner to docker;

create table deputado
(
    id                 bigint     not null
        constraint idx_16398_primary
            primary key,
    nome               text       not null,
    nome_eleitoral     text,
    situacao           text       not null,
    condicao_eleitoral text       not null,
    partido            varchar(15)
        constraint deputado_ibfk_1
            references partido,
    estado             varchar(5) not null,
    uri_foto           text
);

alter table deputado
    owner to docker;

create index idx_16398_partido_fk
    on deputado (partido);

create table proposicoes
(
    id                bigint     not null
        constraint idx_16408_primary
            primary key,
    tipo              varchar(5) not null,
    ano               integer    not null,
    ementa            text       not null,
    ementa_detalhada  text,
    data_apresentacao date,
    ultimo_relator_id bigint
        constraint proposicoes_ibfk_1
            references deputado,
    situacao          text,
    uri_documento     text
);

alter table proposicoes
    owner to docker;

create table autor_proposicoes
(
    id_proposicao bigint not null
        constraint autor_proposicoes_ibfk_2
            references proposicoes
            on delete cascade,
    id_deputado   bigint not null
        constraint autor_proposicoes_ibfk_1
            references deputado,
    constraint idx_16390_primary
        primary key (id_proposicao, id_deputado)
);

alter table autor_proposicoes
    owner to docker;

create index idx_16390_id_deputado_fk
    on autor_proposicoes (id_deputado);

create table classificacao_proposicoes
(
    id_proposicao bigint not null
        constraint classificacao_proposicoes_ibfk_1
            references proposicoes,
    classificacao text   not null
);

alter table classificacao_proposicoes
    owner to docker;

create index idx_16393_id_proposicao_fk
    on classificacao_proposicoes (id_proposicao);

create index idx_16408_id_ultimo_relator_fk
    on proposicoes (ultimo_relator_id);

create table proposicoes_keywords
(
    keyword       text   not null,
    proposicao_id bigint not null
        constraint proposicoes_keywords_ibfk_1
            references proposicoes
            on delete cascade
);

alter table proposicoes_keywords
    owner to docker;

create index idx_16413_proposicao_id_fk
    on proposicoes_keywords (proposicao_id);

create table tesauro_categorias
(
    id    bigint not null
        constraint idx_16418_primary
            primary key,
    valor text   not null
);

alter table tesauro_categorias
    owner to docker;

create table tesauro_subcategorias
(
    id           bigint not null
        constraint idx_16423_primary
            primary key,
    categoria_id bigint not null
        constraint tesauro_subcategorias_ibfk_1
            references tesauro_categorias,
    valor        text   not null
);

alter table tesauro_subcategorias
    owner to docker;

create index idx_16423_categoria_id_fk
    on tesauro_subcategorias (categoria_id);

create table tesauro_termos
(
    id              bigint not null
        constraint idx_16428_primary
            primary key,
    subcategoria_id bigint not null
        constraint tesauro_termos_ibfk_1
            references tesauro_subcategorias,
    valor           text   not null
);

alter table tesauro_termos
    owner to docker;

create index idx_16428_subcategoria_id_fk
    on tesauro_termos (subcategoria_id);