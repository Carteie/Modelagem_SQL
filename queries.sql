-- Listar todos os trabalhadores e seus respectivos departamentos, ordenados pelo nome do trabalhador
SELECT T.nome AS Trabalhador, D.nome AS Departamento
FROM Trabalhador T
JOIN Departamento D ON T.FK_ID_departamento_PK = D.ID_departamento
ORDER BY T.nome;

-- Contar o número de trabalhadores em cada departamento,em ordem descrescente, agrupados pelo nome do departamento e nome do centro de pesquisa
SELECT D.nome AS Departamento, COUNT(T.CPF) AS Numero_de_Trabalhadores, C.nome AS Nome_Centro
FROM Departamento D
JOIN Trabalhador T ON D.ID_departamento = T.FK_ID_departamento_PK
JOIN Centro_pesquisa C ON D.FK_CentPesq_PK = C.ID_centro
GROUP BY D.nome, C.nome
ORDER BY Numero_de_Trabalhadores DESC;

-- Listar todas as publicações e os respectivos departamentos, ordenados pelo título da publicação
SELECT P.titulo AS Publicacao, D.nome AS Departamento
FROM Publicacao P
JOIN Departamento D ON P.FK_ID_departamento = D.ID_departamento
ORDER BY P.titulo;

-- Contar o número de equipamentos por departamento, agrupados pelo nome do departamento
SELECT D.nome AS Departamento, COUNT(E.ID_equipamento) AS Numero_de_Equipamentos
FROM Departamento D
JOIN Equipamento E ON D.ID_departamento = E.FK_ID_departamento_PK
GROUP BY D.nome
ORDER BY Numero_de_Equipamentos DESC;

-- Listar todas as compras feitas por trabalhadores, incluindo o nome do trabalhador e o nome do equipamento, ordenados pela data da compra
SELECT C.Data_compra, T.nome AS Trabalhador, E.nome AS Equipamento, C.valor
FROM Compra C
JOIN Trabalhador T ON C.fk_Funcionario_CPF = T.CPF
JOIN Equipamento E ON C.fk_Equipamento_ID_equipamento = E.ID_equipamento
ORDER BY C.Data_compra DESC;

--  Listar departamentos que têm mais de 3 trabalhadores
SELECT D.nome AS Departamento, COUNT(T.CPF) AS Numero_de_Trabalhadores
FROM Departamento D
JOIN Trabalhador T ON D.ID_departamento = T.FK_ID_departamento_PK
GROUP BY D.nome
HAVING COUNT(T.CPF) > 3
ORDER BY Numero_de_Trabalhadores DESC;

-- Listar publicações que têm mais de um trabalhador participando
SELECT P.titulo AS Publicacao, COUNT(PA.fk_Trabalhador_CPF) AS Numero_de_Trabalhadores
FROM Publicacao P
JOIN Participa PA ON P.ID_publicacao = PA.fk_Publicação_ID_publicação
GROUP BY P.titulo
HAVING COUNT(PA.fk_Trabalhador_CPF) > 1
ORDER BY Numero_de_Trabalhadores DESC;

-- Listar financiadores que financiaram mais de 2 projetos
SELECT F.nome AS Financiador, COUNT(FI.fk_Financeiro_ID_financeiro) AS Numero_de_Projetos
FROM Financiador F
JOIN Financia FI ON F.ID_financiador = FI.fk_Financiador_ID_financiador
GROUP BY F.nome
HAVING COUNT(FI.fk_Financeiro_ID_financeiro) > 2
ORDER BY Numero_de_Projetos DESC;

-- Listar financiadores que não financiaram nenhum projeto até o momento
SELECT F.nome AS Financiador
FROM Financiador F
LEFT JOIN Financia FI ON F.ID_financiador = FI.fk_Financiador_ID_financiador
WHERE FI.fk_Financeiro_ID_financeiro IS NULL
ORDER BY F.nome;

-- Listar trabalhadores que participam de projetos de pesquisa com título começando com a letra 'A'
SELECT T.nome AS Trabalhador, P.titulo AS Projeto_de_Pesquisa
FROM Trabalhador T
JOIN Quem_pesquisa PE ON T.CPF = PE.FK_CPF_pesquisador
JOIN Projeto_pesquisa P ON PE.FK_projeto = P.ID_pesquisa
WHERE P.titulo LIKE 'A%'
ORDER BY T.nome, P.titulo;
