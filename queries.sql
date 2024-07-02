-- Listar todos os trabalhadores e seus respectivos departamentos, ordenados pelo nome do trabalhador
SELECT T.nome AS Trabalhador, D.nome AS Departamento
FROM Trabalhador T
JOIN Departamento D ON T.FK_ID_departamento_PK = D.ID_departamento
ORDER BY T.nome;

-- Contar o número de trabalhadores em cada departamento, agrupados pelo nome do departamento
SELECT D.nome AS Departamento, COUNT(T.CPF) AS Numero_de_Trabalhadores
FROM Departamento D
JOIN Trabalhador T ON D.ID_departamento = T.FK_ID_departamento_PK
GROUP BY D.nome
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
