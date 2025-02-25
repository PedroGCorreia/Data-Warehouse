/* Projeto Final - Novas Tecnologias em Banco de Dados
 * Universidade Federal de São Carlos
 *
 * Grupo 03: Mateus Matsuo e Pedro Correia
 * Arquivo DDL - criação das tabelas
 */

-- Tabela de dimensão de local
CREATE TABLE Dim_Local (
    id_local SERIAL PRIMARY KEY,
    estado VARCHAR(50),
    regiao VARCHAR(50)
);

-- Tabela de dimensão de data
CREATE TABLE Dim_Data (
    id_data SERIAL PRIMARY KEY,
    mes INT,
    ano INT,
    mes_por_extenso VARCHAR(50),
    trimestre INT
);

-- Tabela de dimensão de produto
CREATE TABLE Dim_Produto (
    id_produto SERIAL PRIMARY KEY,
    subgrupo VARCHAR(50),
    grupo VARCHAR(50),
    unidade_medida VARCHAR(20)
);

-- Tabela fato 
CREATE TABLE Fato_Cotacao (
    id_local INT,
    id_data INT,
    id_produto INT,
    preco DOUBLE PRECISION,
    PRIMARY KEY (id_local, id_data, id_produto),
    FOREIGN KEY (id_local) REFERENCES dim_local(id_local),
    FOREIGN KEY (id_data) REFERENCES dim_data(id_data),
    FOREIGN KEY (id_produto) REFERENCES dim_produto(id_produto)
);
