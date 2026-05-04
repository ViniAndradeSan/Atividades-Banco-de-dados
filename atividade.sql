create table if not exists clientes (
  id SERIAL primary key,
  name VARCHAR(100) not null,
  email VARCHAR(255) unique not null,
  status VARCHAR(20) default 'ativo',
  limite NUMERIC(10, 2) check (limite >= 0),
  criado_em TIMESTAMPTZ default CURRENT_TIMESTAMP
);

create table if not exists autores (id SERIAL primary key, nome VARCHAR(100) not null);

create table if not exists livros (
  id SERIAL primary key,
  titulo VARCHAR(150) not null,
  preco numeric(10, 2) not null,
  autor_id integer references autores (id) on delete restrict
);

alter table livros
add paginas integer;

alter table livros
alter column titulo type varchar(200);

alter table livros
add constraint chk_preco check (preco > 0);

alter table livros
drop column paginas;

create table consultas (
  id INTEGER,
  paciente VARCHAR(100),
  medico VARCHAR(100),
  data_consulta TIMESTAMP,
  valor REAL,
  status VARCHAR(50)
);

create table consultas (
  id SERIAL primary key,
  paciente_nome VARCHAR(100) not null,
  medico_nome VARCHAR(100) not null,
  data_consulta TIMESTAMP not null,
  valor NUMERIC(10, 2) default 0.00,
  status VARCHAR(50) default 'Agendada',
  criado_em TIMESTAMP default CURRENT_TIMESTAMP
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
  artista_id INT not null,
  preco decimal(10, 2),
  foreign key (artista_id) references artistas_caju (id),
  check (
    preco is null
    or preco > 0
  )
);

create table faixas_caju (
  id SERIAL primary key,
  nome VARCHAR(255) not null,
  duracao_segundos INT not null check (duracao_segundos > 0),
  album_id INT not null,
  foreign KEY (album_id) references albuns_caju (id)
);

alter table faixas_caju
add column genero_musical VARCHAR(50) check (
  genero_musical in ('Rock', 'Pop', 'Jazz', 'Samba', 'Forró')
);

delete from faixas_caju
where
  album_id in (
    select
      id
    from
      albuns_caju
    where
      artista_id = 1
  );

delete from albuns_caju
where
  artista_id = 1;

delete from artistas_caju
where
  id = 1;

insert into
  artistas_caju (nome, pais)
values
  ('Djvan', 'Brasil'),
  ('Nina Simone', 'EUA');

insert into
  artistas_caju (nome)
select
  "name"
from
  "artist"
limit
  3;

update albuns_caju
set
  preco = 34.90
where
  id = 1;

update albuns_caju
set
  preco = preco * 1.1
where
  id = 1;

insert into
  artistas_caju (nome)
values
  ('Alberto'),
  ('Bernardo'),
  ('Carlinhos'),
  ('Daniel'),
  ('Emeson');

insert into
  albuns_caju (titulo, preco, artista_id, ano)
values
  ('Revida', 45.00, 1, 2019),
  ('Banana Nana', 30.66, 1, 2024),
  ('Carlinhos e você', 66.33, 3, 2021),
  ('Ceu de cada dia', 77.77, 3, 2020);

insert into
  faixas_caju (nome, duracao_segundos, album_id)
values
  ('Expresso 2222', 218, 2),
  ('Back in Bahia', 275, 2),
  ('You Don''t Know Me', 230, 3);

update artistas_caju
set
  nome = 'Alberteson'
where
  id = 1;

update albuns_caju
set
  preco = 32.23
where
  id = 4
update faixas_caju
set
  duracao_segundos = duracao_segundos + 30
where
  id = 2
delete from faixas_caju
where
  album_id in (
    select
      id
    from
      albuns_caju
    where
      artista_id = 1
  );

delete from albuns_caju
where
  artista_id = 1;

delete from artistas_caju
where
  id = 1;

insert into
  artistas_caju (nome)
select
  name
from
  artist
limit
  3
returning
  *;

begin;

truncate table track restart IDENTITY cascade;

select
  cont (*)
from
  track
rollback;

select
  cont (*)
from
  track
select
  count(*)
from
  track
where
  milliseconds between 20000 and 300000
select
  first_name as nome,
  last_name as sobrenome,
  country as pais
from
  customer
where
  country in ('Brazil', 'Canada', 'France')
order by
  sobrenome;

select
  *
from
  track
where
  composer is null
order by
  name asc
select
  first_name as nome,
  last_name as sobrenome,
  country as pais
from
  customer
where
  country in ('Brazil', 'Canada', 'France')
order by
  sobrenome;

select
  COUNT(*) as NumerosDeNulos
from
  track
where
  composer is null
select
  COUNT(*) as entre4a6
from
  track
where
  milliseconds between 240000 and 360000
select
  name as Nome,
  milliseconds as Duração
from
  track
where
  milliseconds between 240000 and 360000
order by
  milliseconds desc
select
  name as "Nome",
  milliseconds as "Duração"
from
  track
where
  milliseconds between 240000 and 360000
order by
  milliseconds desc
select
  sum(total) as faturamento_total,
  round(avg(total), 2) as ticket_medio
from
  invoice
select
  genre_id as genero,
  count(track_id) as total_de_faixas
from
  track
group by
  genero
having
  count(*) > 50
order by
  genero
select
  billing_country as pais_de_compra,
  sum(total) as faturamento_total,
  count(invoice_id) as total_faturas,
  round(avg(total), 2) as ticket_medio
from
  invoice
where
  billing_country in ('France', 'Germany', 'Italy', 'Potugal')
group by
  pais_de_compra
having
  sum(total) > 100
order by
  faturamento_total
select
  t.name as nome_do_musica,
  al.title as titulo_album,
  t.unit_price as preco_unitario,
  ar.name as nome_do_artista
from
  track t
  inner join album al on t.album_id = al.album_id
  inner join artist ar on al.artist_id = ar.artist_id
select
  ar.artist_id as id,
  ar.name as nome_do_artista,
  count(t.track_id)
from
  track t
  inner join album al on t.album_id = al.album_id
  inner join artist ar on al.artist_id = ar.artist_id
group by
  id,
  nome_do_artista
select
  c.first_name,
  c.last_name
from
  customer c
  left join invoice i on c.customer_id = i.customer_id
where
  i.invoice_id is null;

select
  concat(first_name, ' ', last_name) as Completo
from
  customer
select
  CONCAT(first_name, ' ', last_name) as nome_completo,
  SUM(i.total) as total_gasto
from
  customer c
  inner join invoice i on i.customer_id = c.customer_id
group by
  c.customer_id,
  first_name,
  last_name
order by
  total_gasto desc;

select
  a.album_id,
  a.title as Titulo,
  a.artist_id
from
  album a
  left join track t on a.album_id = t.album_id
where
  t.track_id is null;

select
  sum(invoL.quantity) as Total_Venda,
  g.name as Nome_do_Genero
from
  invoice_line invoL
  inner join track t on invoL.track_id = t.track_id
  inner join genre g on t.genre_id = g.genre_id
group by
  g.name
order by
  Total_Venda desc;

select
  customer_id,
  total
from
  invoice
where
  total > (
    seledt avg(total)
    from
      invoice
  );

select
  track_id,
  name
from
  track
where
  track_id not in (
    select distinct
      track_id
    from
      invoice_line
  );

select
  avg(total_por_cliente)
from
  (
    select
      customer_id,
      sum(total) as total_por_cliente
    from
      invoice
    group by
      customer_id
  ) as totais;