create schema pizzariaBD1;
use pizzariaBD1;

#DDL(Data Definition Language): create, alter, drop, truncate

create table cliente(
pk_cliente int not null auto_increment,
nameCliente varchar(255),
adress varchar(255),
phone varchar(255),
primary key(pk_cliente)
);

create table pedido(
pk_pedido int not null auto_increment,
fk_cliente int not null,
dataHora timestamp default current_timestamp,
metodoPagamento enum('pix', 'dinheiro', 'cartao') not null,
entrega  boolean not null,
taxaEntrega float,
primary key(pk_pedido),
foreign key(fk_cliente) references cliente(pk_cliente)
);

create table tamanhoPizza(
pk_tamanhoPizza int not null auto_increment,
description varchar(255),
price float,
primary key(pk_tamanhoPizza)

);

create table borda(
pk_borda int not null auto_increment,
tipoBorda varchar(255),
priceAdditional float,
primary key(pk_borda)

);

create table pizza(
pk_pizza int not null,
flavorPizza varchar(255),
price float,
personalized boolean,
primary key(pk_pizza)

);

create table bebida(
pk_bebida int not null auto_increment,
nameDrink varchar(255),
price float,
primary key(pk_bebida)

);

create table pedidoPizza(
pk_pedidoPizza int not null auto_increment,
fk_pedido int not null,
fk_pizza int not null,
fk_tamanho int not null,
fk_borda int not null,
quantidade int not null,
primary key(pk_pedidoPizza),
foreign key(fk_pedido) references pedido(pk_pedido),
foreign key(fk_pizza) references pizza(pk_pizza),
foreign key(fk_tamanho) references tamanhoPizza(pk_tamanhoPizza),
foreign key(fk_borda) references borda(pk_borda)

);

create table pedidoBebida(
fk_pedido int not null,
fk_bebida int not null,
quantidade int not null,
foreign key(fk_pedido) references pedido(pk_pedido),
foreign key(fk_bebida) references bebida(pk_bebida)

);

#DML(Data Manipulation Language): insert, update, delete

use pizzariaBD1;
#inserir informações no banco de dados
insert into cliente(nameCliente, adress, phone) values( 'Mariana', 'Rua Joaquim Lopes, 1025 ,Bairro da Paz, Vitoria da Conquista, Bahia', '77988889955');

#consultar a chave identificadora do cliente
select pk_cliente from cliente where nameCliente = 'Mariana';

#ápos obter a pk_cliente, fazer a alteracao da informacoes usando a chave como referencia
update cliente set adress = 'Avenida Jorge Amado, SN, Salobrinho, Ilhéus, Bahia' where pk_cliente = 1;

#povoar mais informações e deletar algumas das informação do bd
insert into cliente(nameCliente, adress, phone) values('João', 'Rua Santa Helena, 38, salobrinho, ilhues, bahia', '73988885020');
insert into cliente(nameCliente, adress, phone) values('Joaquim','Rua jorge amado, sn, salobrinho, ilheus, bahia', '7399884455' );
insert into cliente(nameCliente, adress, phone) values('jose', 'Avenida brasil, 1025, bairro da paz, salvador, bahia','75988994545');

#consultar todos os clientes
select * from cliente; 

#delete
delete from cliente where pk_cliente = 2;

select *from cliente;

#table pedidos

#insert into pedido(fk_cliente, dataHora, metodoPagamento, entrega, taxaEntrega) values (1, 'pix', TRUE, 4.0); deu erro porque o valor de dataHora, não foi informado
insert into pedido(fk_cliente, metodoPagamento, entrega, taxaEntrega) values (1, 'pix', TRUE, 4.0);# se não preencher o valor de data e hora, ele pega e set o valor atual do computador
insert into pedido(fk_cliente, dataHora, metodoPagamento, entrega, taxaEntrega) values ( 3, '2024-11-02 17:45:00', 'cartao', FALSE, 0.0);
select *from pedido;

#table tamanhoPizza

insert into tamanhoPizza( description, price ) values('Grande', 89.90);
insert into tamanhoPizza( description, price) values('Media', 79.90);
insert into tamanhoPizza( description, price) values('Pequena', 69.90);

#table borda
#não foi possível inserir informação dessa forma, deria que adicionar a informação da chave primaria, mas é importante que a chave primaria seja do tipo auto_increment
insert into borda( tipoBorda, priceAdditional) values( 'simples', 0.0);
insert into borda(tipoBorda, priceAdditional) values('com queijo', 10.0);
insert into borda(tipoBorda, priceAdditional) values('queijo duplo','15.0');

SHOW CREATE TABLE pizza;

#table pizza

insert into pizza( flavorPizza, price, personalized) values( 'frango', 50.0, false);
insert into pizza( flavorPizza, price, personalized) values( 'calabresa', 60.0, true);
insert into pizza( flavorPizza, price, personalized) values( 'milho', 40.0, false);

# como a table pizza, a pk_pizza não é auto_increment, deve-se informar manualmente o valor da chave ou fazer as alterações necessario pra modificar o tipo da chave primaria
alter table pizza modify pk_pizza int not null auto_increment;

# a chave primaria de pizza é chave estrangeira na table pedidoPizza, com isso, torna-se necessario a exclusão dessa referencia pra posterior modificação da chave primaria
show create table pedidoPizza;

# a table pedidoPizza foi excluida para ser possível fazer a modificação de tipo da chave primaria na tabela pizza
drop table pedidoPizza;

#alteração da table pizza para incluir o auto increment
alter table pizza modify pk_pizza int not null auto_increment;
show create table pizza;

# a chave primaria da table de pizza volta a ser referenciada como chave estrangeira na table pedidoPizza
create table pedidoPizza(
pk_pedidoPizza int not null auto_increment,
fk_pedido int not null,
fk_pizza int not null,
fk_tamanho int not null,
fk_borda int not null,
quantidade int not null,
primary key(pk_pedidoPizza),
foreign key(fk_pedido) references pedido(pk_pedido),
foreign key(fk_pizza) references pizza(pk_pizza),
foreign key(fk_tamanho) references tamanhoPizza(pk_tamanhoPizza),
foreign key(fk_borda) references borda(pk_borda)

);

# agora pode-se inserir valores na table pizza sem precisar colocar o valor manual da chave primaria

insert into pizza( flavorPizza, price, personalized) values( 'frango', 50.0, false);
insert into pizza( flavorPizza, price, personalized) values( 'calabresa', 60.0, true);
insert into pizza( flavorPizza, price, personalized) values( 'milho', 40.0, false);

#table bebida
insert into bebida( nameDrink, price) values('coca', 5.0);
insert into bebida(nameDrink, price) values('fanta', 5.0);
insert into bebida(nameDrink, price) values('guarana', 5.0);
select *from bebida;

#table pedidoPizza
insert into pedidoPizza( fk_pedido ,fk_pizza , fk_tamanho ,fk_borda , quantidade ) values( 1,1,3,1,1);
insert into pedidoPizza( fk_pedido ,fk_pizza , fk_tamanho ,fk_borda , quantidade ) values( 2, 2,1,3,1);

select *from pedidoPizza;

#table pedidoBebibda
insert into pedidoBebida(fk_pedido, fk_bebida, quantidade) values (1,3,2);
insert into pedidoBebida(fk_pedido, fk_bebida, quantidade) values (2,2,1);
select *from pedidoBebida;








