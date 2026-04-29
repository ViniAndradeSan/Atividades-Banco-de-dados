''' 
       Questão 1

A query incorreta —

SQL
select
  count(customer_id) as total_clientes
from
  customer
group by
  city
having
  count(customer_id) >= 5
order by
  total_clientes desc;

O que foi encontrado —
Não está selecionando o nome do país no select. Além disso, o grup está por cidade (city)
em vez de país (country) e o filtro está incluindo países com 5 clientes (>= 5),
enquanto o enunciado pede mais de 5 clientes (> 5).

Como chegaram na solução —
Adicionamos a coluna country no select e alterar o GROUP BY de city para country.
Também corrigimos o operador do HAVING para > 5.

A query correta —

select
  country, 
  count(customer_id) as total_clientes
from
  customer
group by
  country
having
  count(customer_id) > 5
order by
  total_clientes desc;
------------------------------------------------  
     Questão 2
A query incorreta —

select
  support_rep_id as atendente,
  count(*) as total_clientes
from
  customer
group by
  atendente
order by
  atendente asc;

O que foi encontrado —
Ausencia completa de filtrar os atendentes com mais de 15 clientes.
Além disso, a ordenação estava classificada pelo ID do atendente em ordem asc,
 mas, o enunciado pede a ordenação pela contagem de clientes, do maior para o menor.

Como chegaram na solução —
Adicionamos o filtro HAVING count(customer_id) > 15 logo após o GROUP BY.
Depois, o ORDER BY para usar a coluna total_clientes com o desc no lugar do asc

A query correta —

select
  support_rep_id as atendente,
  count(customer_id) as total_clientes
from
  customer
group by
  support_rep_id
having
  count(customer_id) > 15
order by
  total_clientes desc;
 ----------------------------------------------------- 
                        Questão  3
A query incorreta —

select
  country as pais,
  count(customer_id) as clientes_com_empresa
from
  customer
group by
  pais
having
  count(customer_id) < 3
order by
  clientes_com_empresa desc;

O que foi encontrado —
o having filtrava menos de 3, quando a regra era pelo menos 3 e 
não havia nenhum filtro verificando se o cliente possui empresa.

Como chegaram na solução —
Corrigimos o having para >= 3 e foi adicionado um filtro para company IS NOT NULL antes do grup by.

A query correta —

select
  country as pais,
  count(customer_id) as clientes_com_empresa
from
  customer
where 
  company is not null
group by
  country
having
  count(customer_id) >= 3
order by 
  clientes_com_empresa desc;
----------------------
           Questão 4
Query 4
A query incorreta — 
select
  state as estado,
  count(customer_id) as total_clientes
from
  customer
group by
  estado
order by
  total_clientes desc;

O que foi encontrado — 
O resultado trazia todos os estados de todos os países e incluía valores nulos.

Como chegaram na solução — 
Filtramos o país do USA e removemos estados nulos para limpar o resultado.

A query correta —
select 
  state as estado,
  count(customer_id) as total_clientes
from 
  customer
where 
  country = 'USA' and state is not null
group by 
  state
order by 
  total_clientes desc;

----------------------------
        Questão 5

A query incorreta — 
select
  country as pais
from
  customer
group by
  pais
having
  count(*) > 2
order by
  pais asc;

O que foi encontrado —
O select mostrava apenas o país, sem a contagem.
A ordenação estava alfabética e não pelo fax.

Como chegaram na solução — 
Colocomos a contagem no SELECT, 
filtramos registros onde o Fax não é nulo e
ordenamos pelo total de forma decrescente.

A query correta —

select 
  country as pais,
  count(fax) as clientes_com_fax
from 
  customer
where
  fax is not null
group by
  country
having
  count(fax) > 2
order by
  clientes_com_fax desc;
-------------------------------
           Questão 6

A query incorreta — 
select
  count(invoice_id) as total_faturas
from
  invoice
group by
  billing_state
having
  count(invoice_id) > 5
order by
  total_faturas asc;

O que foi encontrado —
Não mostrava o nome do estado no resultado e
a ordenação estava invertida (do menor para o maior).

Como chegaram na solução — 
Incluímos billing_state no SELECT 
e alteramos a ordenação para desc.

A query correta —

select 
  billing_state as estado,
  count(invoice_id) as total_faturas
from
  invoice
where
  billing_state is not null
group by 
  billing_state
having
  count(invoice_id) > 5
order by
  total_faturas desc;
------------------------

Query 7
A query incorreta —

SQL
select
  min(total) as menor_fatura,
  max(total) as maior_fatura
from
  invoice
group by
  billing_country
order by
  maior_fatura desc;

O que foi encontrado —
A falta de incluir a coluna de país (billing_country) no SELECT

Como chegaram na solução —
A solução foi adicionar o billing_country  no SELECT.

A query correta —

select
  billing_country as pais,
  min(total) as menor_fatura,
  max(total) as maior_fatura
from
  invoice
group by
  billing_country
order by
  maior_fatura desc;
---------------------------------
   Questão 8

A query incorreta —

select
  billing_city as cidade,
  count(invoice_id) as total_faturas
from
  invoice
group by
  cidade
having
  count(invoice_id) > 3
order by
  cidade asc;

O que foi encontrado —
Falta o filtro para garantir que sejam apenas do Canadá.
o ORDER BY está ordenando alfabeticamente pela cidad, quando deveria ser pela quantidade de faturas
 do maior para o meno. 

Como chegaram na solução —
Adicionamos o WHERE billing_country = 'Canada1'
para pegar o país inteiro corretamente. Em seguida,
ajustamos o ORDER BY para apontar para total_faturas desc.

A query correta —

select
  billing_city as cidade,
  count(invoice_id) as total_faturas
from
  invoice
where
  billing_country = 'Canada'
group by
  billing_city
having
  count(invoice_id) > 3
order by
  total_faturas desc;
----------------------------------
         Questão 9

A query incorreta —

select
  sum(total) as faturamento_total
from
  invoice
group by
  extract(quarter from invoice_date)
order by
  extract(quarter from invoice_date) asc;

O que foi encontrado —
O trimestre não está no SELECT.
A ordenação original estava classificando os dados do trimestre mas o enunciado exige
que a ordenação seja do maior faturamento para o menor.

Como chegaram na solução —
adicionamos o trimestre extract no bloco SELECT.
e alteramos o bloco ORDER BY para usar a coluna de soma de faturamento de forma descrecsente

A query correta —

select
  extract(quarter from invoice_date) as trimestre,
  sum(total) as faturamento_total
from
  invoice
group by
  extract(quarter from invoice_date)
order by
  faturamento_total desc;
-----------------------------------------------
                  Questão 10
A query incorreta —

select
  count(customer_id) as total_clientes
from
  customer
group by
  city
having
  count(customer_id) >= 2
order by
  total_clientes desc;

O que foi encontrado —
A cidade não está sendo retornada no SELECT. 
o o enunciado pede a contagem de clientes distintos (únicos).

Como chegaram na solução —
Adicionamos a coluna city no SELECT. 
Para garantir a contagem de clientes distintos conforme o enunciado pede.

A query correta —
select 
  city as cidade, 
  count(distinct customer_id) as total_clientes
from
  customer
group by
  city
having
  count(distinct customer_id) >= 2
order by
  total_clientes desc;