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