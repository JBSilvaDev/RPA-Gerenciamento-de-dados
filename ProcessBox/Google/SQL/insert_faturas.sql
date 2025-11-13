-- Tipo de Documento: Armador
-- SQL para inserir os dados extraídos da fatura no GCP
-- Ambientes(datasets): LOGPAY_QA, LOGPAY_PROD
-- tabela:fatura-armador
-- Para adicionar novos campos vindos da fatura, considerar os itens abaixo: 
-- Taxonomia do DU
-- Treinar novas faturas
-- Adicionar os campos neste SQL e respeitar a ordem das colunas e parâmentros (na atividade Run Command)
-- Campos que não vem da fatura porém também são adicionados para auditoria do processo: reference, email,fornecedor, remetente, recebido, fatura, tipo-documento, linguagem, saida-extracao
INSERT INTO
    `sz-00009-ws.pagamento_faturas_energia_qa.faturas_fio_raw` (
        `GUID`,
        `nome_cliente`,
        `subgrupo_tarifario`,
        `mes_referencia`,
        `endereco_cliente`,
        `base_calc_cofins`,
        `COFINS`,
        `base_calc_pis`,
        `PIS`,
        `base_calc_pis_cofins`,
        `pis_cofins`,
        `base_calc_icms`,
        `ICMS`,
        `numero_instalacao`,
        `numero_cliente`,
        `numero_fatura`,
        `data_emissao`,
        `codigo_barras`,
        `total_fatura`,
        `data_vencimento`,
        `cnpj_cliente`,
        `cnpj_fornecedor`,
        `nome_fornecedor`,
        `mensagem_aviso`,
        `reservado_fisco`,
        `tipo_cliente`,
        `tipo_fatura`,
        `numero_pedido`,
        `miro_fb60`,
        `compensacao`,
        `chamados`,
        `obs_gerais`,
        `URI`,
        `tipo_layout`
    )
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);