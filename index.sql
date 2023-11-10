create schema fortes;
show databases;
use fortes;

create table funcionarios(
cpf varchar(14) unique primary key not null,
matricula int unique not null,
nome varchar(100) unique not null,
id_card int unique not null,
cargo varchar(50) not null
);

create table fornecedores(
cnpj varchar(18) unique primary key not null,
razão_social varchar(50),
cep int not null,
complemento varchar(100) not null,
refefencia varchar(100) 
);

create table obras(
id_obra int unique primary key not null,
id_funcionario_obra int not null,
constraint id_funcionario_obra foreign key(id_funcionario_obra) references funcionarios(cpf),
cep int not null
);
