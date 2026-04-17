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
