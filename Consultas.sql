/* Projeto Final - Novas Tecnologias em Banco de Dados
 * Universidade Federal de São Carlos
 *
 * Grupo 03: Mateus Matsuo e Pedro Correia
 * Arquivo com as consultas realizadas dentro do DW
 */

-- Consulta 01: visualização dos preços ao longo de um determinado período de tempo
CREATE MATERIALIZED VIEW mv_preco_medio_tempo AS
SELECT 
    dd.ano,
    dd.mes,
    dd.mes_por_extenso,
    AVG(fc.preco) AS preco_medio
FROM fato_cotacao fc
JOIN dim_data dd ON fc.id_data = dd.id_data
WHERE fc.id_produto = <id_produto> -- Alterar para o produto desejado no filtro
GROUP BY dd.ano, dd.mes, dd.mes_por_extenso
ORDER BY preco_medio

-- Consulta 02: preço médio de um determinado produto em cada região (permite identificar as melhores regiões para se comprar determinado produto)
CREATE MATERIALIZED VIEW mv_preco_medio_regiao AS
SELECT 
    dl.regiao,
    AVG(fc.preco) AS preco_medio
FROM fato_cotacao fc
JOIN dim_local dl ON fc.id_local = dl.id_local
WHERE fc.id_produto = <id_produto> -- Alterar para o produto desejado no filtro
GROUP BY dl.regiao
ORDER BY preco_medio;

-- Consulta 03: identificação do produtos que são produzidos dentro de um determinado local (pode ser realizada pela região ou pelo estado)
-- Pela região
CREATE MATERIALIZED VIEW mv_produtos_regiao AS
SELECT DISTINCT 
    dp.id_produto,
    dp.nome_produto,
    dp.grupo,
    dp.subgrupo,
    dp.unidade_medida
FROM fato_cotacao fc
JOIN dim_local dl ON fc.id_local = dl.id_local
JOIN dim_produto dp ON fc.id_produto = dp.id_produto
WHERE dl.regiao = '<nome_regiao>' -- Alterar para a região desejada no filtro
ORDER BY dp.grupo, dp.subgrupo;

-- Pelo estado
CREATE MATERIALIZED VIEW mv_produtos_estado AS
SELECT DISTINCT 
    dp.id_produto,
dp.nome_produto,
    dp.grupo,
    dp.subgrupo,
    dp.unidade_medida
FROM fato_cotacao fc
JOIN dim_local dl ON fc.id_local = dl.id_local
JOIN dim_produto dp ON fc.id_produto = dp.id_produto
WHERE dl.estado = '<nome_estado>' -- Alterar para o estado desejado no filtro
ORDER BY dp.grupo, dp.subgrupo;

-- Consulta 04: variações dos preços de acordo com o tipo de produto
CREATE MATERIALIZED VIEW mv_preco_tipo AS
SELECT 
    dp.grupo,
    dp.subgrupo,
    AVG(fc.preco) AS preco_medio,
    MIN(fc.preco) AS preco_minimo,
    MAX(fc.preco) AS preco_maximo,
    STDDEV(fc.preco) AS preco_desvio_padrao
FROM fato_cotacao fc
JOIN dim_produto dp ON fc.id_produto = dp.id_produto
GROUP BY dp.grupo, dp.subgrupo
ORDER BY dp.grupo, dp.subgrupo;
