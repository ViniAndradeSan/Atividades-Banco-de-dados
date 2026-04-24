CREATE TABLE IF NOT EXISTS clientes (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  status VARCHAR(20) DEFAULT 'ativo',
  limite NUMERIC(10,2) CHECK (limite >= 0),
  criado_em TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE if not exists autores (
  id SERIAL primary key,
  nome VARCHAR(100) NOT NULL 
);

create table if not exists livros (
  id SERIAL primary key,
  titulo VARCHAR(150) NOT null,
  preco numeric(10,2) not null,
  autor_id integer references autores(id) on delete restrict
);

Alter table livros add paginas integer;

alter table livros alter column titulo type varchar(200);

alter table livros add constraint chk_preco check (preco > 0);

Alter table livros drop column paginas;

CREATE TABLE consultas (
  id INTEGER,
  paciente VARCHAR(100),
  medico VARCHAR(100),
  data_consulta TIMESTAMP,
  valor REAL,
  status VARCHAR(50)
);

CREATE TABLE consultas (
    id SERIAL PRIMARY KEY,          
    paciente_nome VARCHAR(100) NOT NULL, 
    medico_nome VARCHAR(100) NOT NULL,   
    data_consulta TIMESTAMP NOT NULL,  
    valor NUMERIC(10, 2) DEFAULT 0.00, 
    status VARCHAR(50) DEFAULT 'Agendada', 
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

create table artistas_caju (
  id serial primary key,
  nome varchar(255) not null unique,
  pais varchar(100),
  data_cadastro timestamp default current_timestamp
);

create table albuns_caju (
  id serial primary key,
  titulo varchar(255) not null,
  ano int not null check (ano > 1850),
  artista_id INT NOT NULL,
  preco decimal(10,2),
  foreign key (artista_id) references artistas_caju(id),
  check (preco is null or preco > 0)
);

CREATE TABLE faixas_caju (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    duracao_segundos INT NOT NULL CHECK (duracao_segundos > 0),
    album_id INT NOT NULL,
    FOREIGN KEY (album_id) REFERENCES albuns_caju(id)
);

ALTER TABLE faixas_caju
ADD COLUMN genero_musical VARCHAR(50)
CHECK (genero_musical IN ('Rock', 'Pop', 'Jazz', 'Samba', 'Forró'));


DELETE FROM faixas_caju WHERE album_id IN (SELECT id FROM albuns_caju WHERE artista_id = 1);
DELETE FROM albuns_caju WHERE artista_id = 1;
DELETE FROM artistas_caju WHERE id = 1;

insert INTO artistas_caju (nome, pais)
values ('Djvan', 'Brasil'), ('Nina Simone', 'EUA');

insert into artistas_caju (nome)
select "name" from  "artist" limit 3;

update albuns_caju
set preco = 34.90
where id = 1;

update albuns_caju
set preco = preco * 1.1
where id = 1;

insert into artistas_caju (nome) values
('Alberto'), ('Bernardo'), ('Carlinhos'), ('Daniel'), ('Emeson');

insert into albuns_caju (titulo, preco, artista_id, ano) values
('Revida',  45.00, 1, 2019), ('Banana Nana', 30.66, 1, 2024) ,
('Carlinhos e você', 66.33, 3, 2021), ('Ceu de cada dia', 77.77, 3, 2020);

insert into faixas_caju (nome, duracao_segundos, album_id) values
('Expresso 2222', 218, 2), ('Back in Bahia', 275, 2), ('You Don''t Know Me', 230, 3);

update artistas_caju set 
nome = 'Alberteson'
where id = 1;

update albuns_caju set
preco = 32.23
where id = 4

update faixas_caju set
duracao_segundos = duracao_segundos + 30
where id = 2

delete from faixas_caju 
where album_id in (
  select id from albuns_caju
  where artista_id = 1
);

delete from albuns_caju
where artista_id = 1;

delete from artistas_caju
where id = 1;

insert into artistas_caju (nome)
select name
from artist
limit 3
returning *;

begin;

truncate table track restart IDENTITY cascade;
select cont(*) from track

rollback;
select cont(*) from track

select count(*) from track
where milliseconds between 20000 and 300000