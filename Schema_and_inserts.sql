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

-- Inserindo dados na tabela Centro_pesquisa
INSERT INTO Centro_pesquisa (nome, endereco, ramal, email, telefone, area_atuacao) VALUES
('Centro de Estudos Avançados', 'Rua A, 123, Brasil, SP', 101, 'cea@centro.com', '1234-5678', 'Física'),
('Centro de Pesquisa Tecnológica', 'Rua B, 456, Brasil, RJ', 102, 'cpt@centro.com', '9876-5432', 'Tecnologia'),
('Instituto de Pesquisa Biológica', 'Rua C, 789, Brasil, MG', 103, 'ipb@centro.com', '4567-8910', 'Biologia'),
('Centro de Estudos de Engenharia', 'Rua D, 101, Brasil, RS', 104, 'cee@centro.com', '1122-3344', 'Engenharia'),
('Instituto de Ciências Sociais', 'Rua E, 202, Brasil, BA', 105, 'ics@centro.com', '5566-7788', 'Sociologia'),
('Centro de Pesquisa Química', 'Rua F, 303, Brasil, PR', 106, 'cpq@centro.com', '2233-4455', 'Química'),
('Centro de Estudos Matemáticos', 'Rua G, 404, Brasil, PE', 107, 'cem@centro.com', '6677-8899', 'Matemática'),
('Instituto de Pesquisa Médica', 'Rua H, 505, Brasil, CE', 108, 'ipm@centro.com', '3344-5566', 'Medicina'),
('Centro de Estudos Agrícolas', 'Rua I, 606, Brasil, SC', 109, 'cea@centro.com', '7788-9900', 'Agronomia'),
('Centro de Pesquisa Ambiental', 'Rua J, 707, Brasil, MT', 110, 'cpa@centro.com', '4455-6677', 'Meio Ambiente');

-- Inserindo dados na tabela Departamento
INSERT INTO Departamento (nome, chefe_Departamento, FK_CentPesq_PK) VALUES
('Departamento de Física Teórica', 'Dr. João Silva', 1),
('Departamento de Engenharia Civil', 'Eng. Maria Souza', 4),
('Departamento de Biologia Molecular', 'Dr. Carlos Lima', 3),
('Departamento de Química Orgânica', 'Dr. Ana Paula', 6),
('Departamento de Matemática Aplicada', 'Dr. Marcos Pereira', 7),
('Departamento de Tecnologia da Informação', 'Dr. Roberto Costa', 2),
('Departamento de Ciências Sociais Aplicadas', 'Dr. Luciana Almeida', 5),
('Departamento de Medicina Preventiva', 'Dr. Pedro Santos', 8),
('Departamento de Agricultura Sustentável', 'Eng. Ricardo Mota', 9),
('Departamento de Gestão Ambiental', 'Dra. Fernanda Ribeiro', 10);

-- Inserindo dados na tabela Trabalhador
INSERT INTO Trabalhador (CPF, nome, data_admissao, data_nascimento, email, endereco, telefone, area_especialização, tipo_trabalhador, FK_ID_departamento_PK) VALUES
(11111111111, 'João Almeida', '2022-01-15', '1980-05-20', 'joao.almeida@centro.com', 'Rua A, 123', '1234-5678', 'Física Teórica', 'Pesquisador', 1),
(22222222222, 'Maria Oliveira', '2021-03-10', '1975-08-15', 'maria.oliveira@centro.com', 'Rua B, 456', '9876-5432', 'Engenharia Civil', 'Pesquisador', 2),
(33333333333, 'Carlos Pereira', '2019-06-20', '1982-12-30', 'carlos.pereira@centro.com', 'Rua C, 789', '4567-8910', 'Biologia Molecular', 'Pesquisador', 3),
(44444444444, 'Ana Paula Souza', '2018-09-12', '1985-07-25', 'ana.paula@centro.com', 'Rua D, 101', '1122-3344', 'Química Orgânica', 'Pesquisador', 4),
(55555555555, 'Marcos Lima', '2020-02-05', '1978-11-10', 'marcos.lima@centro.com', 'Rua E, 202', '5566-7788', 'Matemática Aplicada', 'Pesquisador', 5),
(66666666666, 'Roberto Costa', '2021-05-17', '1983-03-05', 'roberto.costa@centro.com', 'Rua F, 303', '2233-4455', 'Tecnologia da Informação', 'Pesquisador', 6),
(77777777777, 'Luciana Almeida', '2017-07-25', '1979-09-15', 'luciana.almeida@centro.com', 'Rua G, 404', '6677-8899', 'Ciências Sociais Aplicadas', 'Pesquisador', 7),
(88888888888, 'Pedro Santos', '2018-11-13', '1986-06-20', 'pedro.santos@centro.com', 'Rua H, 505', '3344-5566', 'Medicina Preventiva', 'Pesquisador', 8),
(99999999999, 'Ricardo Mota', '2022-04-22', '1981-01-25', 'ricardo.mota@centro.com', 'Rua I, 606', '7788-9900', 'Agricultura Sustentável', 'Pesquisador', 9),
(10101010101, 'Fernanda Ribeiro', '2020-08-30', '1984-04-18', 'fernanda.ribeiro@centro.com', 'Rua J, 707', '4455-6677', 'Gestão Ambiental', 'Pesquisador', 10);

-- Inserindo dados na tabela Equipamento
INSERT INTO Equipamento (nome, descricao, FK_ID_departamento_PK) VALUES
('Microscópio Eletrônico', 'Microscópio para análises avançadas', 1),
('Computador de Alto Desempenho', 'Computador para cálculos complexos', 2),
('Centrífuga', 'Equipamento para separação de componentes', 3),
('Espectrômetro de Massa', 'Equipamento para análise de massa', 4),
('Servidor de Dados', 'Servidor para armazenamento de grandes volumes de dados', 5),
('Impressora 3D', 'Impressora para prototipagem rápida', 6),
('Laboratório de Análise Química', 'Laboratório completo para análises químicas', 7),
('Scanner Corporal', 'Equipamento para análises médicas', 8),
('Trator de Precisão', 'Equipamento agrícola de alta precisão', 9),
('Sistema de Monitoramento Ambiental', 'Sistema completo para monitoramento de áreas ambientais', 10);

-- Inserindo dados na tabela Compra
INSERT INTO Compra (Data_compra, valor, fk_Equipamento_ID_equipamento, fk_Funcionario_CPF) VALUES
('2023-01-10', 50000.00, 1, 11111111111),
('2023-02-15', 25000.00, 2, 22222222222),
('2023-03-20', 15000.00, 3, 33333333333),
('2023-04-25', 30000.00, 4, 44444444444),
('2023-05-30', 40000.00, 5, 55555555555),
('2023-06-05', 35000.00, 6, 66666666666),
('2023-07-10', 45000.00, 7, 77777777777),
('2023-08-15', 20000.00, 8, 88888888888),
('2023-09-20', 50000.00, 9, 99999999999),
('2023-10-25', 60000.00, 10, 10101010101);

-- Inserindo dados na tabela Projeto_pesquisa
INSERT INTO Projeto_pesquisa (titulo, descricao, data_inicio, data_finalizacao, FK_ID_departamento_PK) VALUES
('Projeto Física Quântica', 'Pesquisa avançada em física quântica', '2022-01-01', '2024-01-01', 1),
('Projeto Pontes Sustentáveis', 'Desenvolvimento de pontes com materiais sustentáveis', '2022-02-01', '2024-02-01', 2),
('Projeto Genoma Humano', 'Estudo do genoma humano', '2022-03-01', '2024-03-01', 3),
('Projeto Novos Fármacos', 'Desenvolvimento de novos medicamentos', '2022-04-01', '2024-04-01', 4),
('Projeto Algoritmos Avançados', 'Desenvolvimento de algoritmos para análise de dados', '2022-05-01', '2024-05-01', 5),
('Projeto Inteligência Artificial', 'Pesquisa em inteligência artificial aplicada', '2022-06-01', '2024-06-01', 6),
('Projeto Impacto Social', 'Estudo do impacto social de políticas públicas', '2022-07-01', '2024-07-01', 7),
('Projeto Saúde Preventiva', 'Pesquisa em métodos de saúde preventiva', '2022-08-01', '2024-08-01', 8),
('Projeto Agricultura Sustentável', 'Desenvolvimento de técnicas de agricultura sustentável', '2022-09-01', '2024-09-01', 9),
('Projeto Conservação Ambiental', 'Estudo de métodos de conservação ambiental', '2022-10-01', '2024-10-01', 10);

-- Inserindo dados na tabela Pesquisa
INSERT INTO Quem_pesquisa (FK_projeto, FK_CPF_orientador, FK_CPF_pesquisador) VALUES
(1, 11111111111, 11111111111),
(2, 22222222222, 22222222222),
(3, 33333333333, 33333333333),
(4, 44444444444, 44444444444),
(5, 55555555555, 55555555555),
(6, 66666666666, 66666666666),
(7, 77777777777, 77777777777),
(8, 88888888888, 88888888888),
(9, 99999999999, 99999999999),
(10, 10101010101, 10101010101);

-- Inserindo dados na tabela Publicacao
INSERT INTO Publicacao (titulo, descricao, area, FK_ID_pesquisa_PK, FK_ID_departamento) VALUES
('Publicação Física Quântica', 'Resultados da pesquisa em física quântica', 'Física', 1, 1),
('Publicação Engenharia Sustentável', 'Estudos sobre pontes sustentáveis', 'Engenharia', 2, 2),
('Publicação Genoma Humano', 'Descobertas sobre o genoma humano', 'Biologia', 3, 3),
('Publicação Novos Fármacos', 'Desenvolvimento de medicamentos', 'Química', 4, 4),
('Publicação Algoritmos', 'Algoritmos para análise de dados', 'Tecnologia', 5, 5),
('Publicação IA', 'Aplicações de inteligência artificial', 'Tecnologia', 6, 6),
('Publicação Impacto Social', 'Resultados de impacto social', 'Sociologia', 7, 7),
('Publicação Saúde Preventiva', 'Métodos de saúde preventiva', 'Medicina', 8, 8),
('Publicação Agricultura', 'Técnicas de agricultura sustentável', 'Agronomia', 9, 9),
('Publicação Conservação Ambiental', 'Métodos de conservação ambiental', 'Meio Ambiente', 10, 10);

-- Inserindo dados na tabela Participa
INSERT INTO Participa (fk_Trabalhador_CPF, fk_Publicação_ID_publicação) VALUES
(11111111111, 1),
(22222222222, 2),
(33333333333, 3),
(44444444444, 4),
(55555555555, 5),
(66666666666, 6),
(77777777777, 7),
(88888888888, 8),
(99999999999, 9),
(10101010101, 10);

-- Inserindo dados na tabela Financiador
INSERT INTO Financiador (nome, contato) VALUES
('Fundação de Amparo à Pesquisa', 'fap@fundacao.com'),
('Conselho Nacional de Desenvolvimento Científico e Tecnológico', 'cnpq@conselho.com'),
('Coordenação de Aperfeiçoamento de Pessoal de Nível Superior', 'cap@coordenacao.com'),
('Banco Nacional de Desenvolvimento Econômico e Social', 'bndes@banco.com'),
('Ministério da Ciência e Tecnologia', 'mct@ministerio.com'),
('Empresa X', 'empresax@empresa.com'),
('Empresa Y', 'empresay@empresa.com'),
('Instituto Z', 'institutoz@instituto.com'),
('Fundação W', 'fundacaow@fundacao.com'),
('Associação V', 'associacaov@associacao.com');

-- Inserindo dados na tabela Financeiro
INSERT INTO Financeiro (valor, tipo_financeiro, descricao_gasto, descricao_movimentacao, data_movimentacao, FK_ID_financiador) VALUES
(100000.00, 'Entrada', 'Aporte inicial', 'Financiamento de pesquisa em física quântica', '2022-01-01', 1),
(80000.00, 'Entrada', 'Aporte inicial', 'Financiamento de pesquisa em engenharia sustentável', '2022-02-01', 2),
(120000.00, 'Entrada', 'Aporte inicial', 'Financiamento de pesquisa em genoma humano', '2022-03-01', 3),
(90000.00, 'Entrada', 'Aporte inicial', 'Financiamento de pesquisa em novos fármacos', '2022-04-01', 4),
(110000.00, 'Entrada', 'Aporte inicial', 'Financiamento de pesquisa em algoritmos', '2022-05-01', 5),
(95000.00, 'Entrada', 'Aporte inicial', 'Financiamento de pesquisa em inteligência artificial', '2022-06-01', 6),
(85000.00, 'Entrada', 'Aporte inicial', 'Financiamento de pesquisa de impacto social', '2022-07-01', 7),
(105000.00, 'Entrada', 'Aporte inicial', 'Financiamento de pesquisa em saúde preventiva', '2022-08-01', 8),
(115000.00, 'Entrada', 'Aporte inicial', 'Financiamento de pesquisa em agricultura sustentável', '2022-09-01', 9),
(125000.00, 'Entrada', 'Aporte inicial', 'Financiamento de pesquisa em conservação ambiental', '2022-10-01', 10);

-- Inserindo dados na tabela Financia
INSERT INTO Financia (fk_Financiador_ID_financiador, fk_Financeiro_ID_financeiro) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);
