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