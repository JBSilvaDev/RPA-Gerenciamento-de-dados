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
    `sz-00009-ws.pagamento_faturas_energia_qa.faturas_fio_servicos_raw` (
        `GUID`,
        `descricao`,
        `quantidade`,
        `tarifa_liquida`,
        `tarifa_bruta`,
        `base_calculo_icms`,
        `aliquota_icms`,
        `valor_icms`,
        `base_calculo_pis_cofins`,
        `aliquota_pis_cofins`,
        `valor_pis_cofins`,
        `base_calculo_pis`,
        `aliquota_pis`,
        `valor_pis`,
        `base_calculo_cofins`,
        `aliquota_cofins`,
        `valor_cofins`,
        `valor_linha`
    )
VALUES
    (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);