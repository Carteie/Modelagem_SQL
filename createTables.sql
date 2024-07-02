CREATE DATABASE CENTROS
default character set utf8
default collate utf8_general_ci;

use CENTROS;

create table Centro_pesquisa(
ID_centro int not null auto_increment Primary key,
nome varchar(40) not null,
endereco varchar(100) default ('Rua, numero, Pais, Estado'),
ramal int,
email varchar(40) not null,
telefone varchar(20),
area_atuacao varchar(40));

create table Departamento(
ID_departamento int not null auto_increment Primary key,
nome varchar(60) not null,
chefe_Departamento varchar(40) not null,
FK_CentPesq_PK int,
foreign key (FK_CentPesq_PK) references Centro_pesquisa(ID_centro));

create table Trabalhador(
CPF bigint not null primary key,
nome varchar(40) not null,
data_admissao date not null,
data_nascimento date not null,
email varchar(40) not null,
endereco varchar(40) not null,
telefone varchar(20),
area_especialização varchar(40) not null,
tipo_trabalhador enum('Funcionario', 'Pesquisador'),
FK_ID_departamento_PK int not null,
foreign key (FK_ID_departamento_PK) references Departamento(ID_departamento));

create table Equipamento(
ID_equipamento int not null auto_increment Primary key,
nome varchar(40) not null,
descricao varchar(60) not null,
FK_ID_departamento_PK int not null,
foreign key (FK_ID_departamento_PK) references Departamento(ID_departamento));

create table Compra( #funcionario compra equipamento
Data_compra date not null,
valor decimal,
fk_Equipamento_ID_equipamento int,
fk_Funcionario_CPF bigint,
foreign key (fk_Equipamento_ID_equipamento) references Equipamento(ID_equipamento),
foreign key (fk_Funcionario_CPF) references Trabalhador(CPF));

create table Projeto_pesquisa(
ID_pesquisa int not null auto_increment Primary key,
titulo varchar(40) not null,
descricao varchar (60) not null,
data_inicio date not null,
data_finalizacao date,
FK_ID_departamento_PK int,
foreign key (FK_ID_departamento_PK) references Departamento(ID_departamento));

create table Quem_pesquisa(
FK_projeto int,
FK_CPF_orientador bigint,
FK_CPF_pesquisador bigint,
foreign key (FK_projeto) references Projeto_pesquisa(ID_pesquisa),
foreign key (FK_CPF_orientador) references Trabalhador(CPF),
foreign key (FK_CPF_pesquisador) references Trabalhador(CPF));

create table Publicacao(
ID_publicacao int not null auto_increment Primary key,
titulo varchar(40) not null,
descricao varchar(60),
area varchar(20),
FK_ID_pesquisa_PK int,
FK_ID_departamento int,
foreign key (FK_ID_pesquisa_PK) references Projeto_pesquisa(ID_pesquisa));

create table Participa ( #pesquisador participa de publicação
fk_Trabalhador_CPF bigint,
fk_Publicação_ID_publicação int,
foreign key (fk_Trabalhador_CPF) references Trabalhador(CPF),
foreign key (fk_Publicação_ID_publicação ) references Publicacao(ID_publicacao));

create table Financiador(
ID_financiador int not null auto_increment Primary key,
nome varchar(100),
contato varchar(40));

create table Financeiro(
ID_financeiro int not null auto_increment Primary key,
valor decimal not null,
tipo_financeiro enum('Entrada', 'Saida'),
descricao_gasto varchar(80),
descricao_movimentacao varchar(80),
data_movimentacao date not null,
FK_ID_pesquisa int,
FK_ID_financiador int,
foreign key (FK_ID_pesquisa) references Projeto_pesquisa(ID_pesquisa),
foreign key (FK_ID_financiador) references Financiador(ID_financiador));

CREATE TABLE Financia ( #financiador contribui (financia) para algum financeiro
fk_Financiador_ID_financiador int,
fk_Financeiro_ID_financeiro int,
foreign key (fk_Financiador_ID_financiador) references Financiador(ID_financiador),
foreign key (fk_Financeiro_ID_financeiro) references Financeiro(ID_financeiro));
