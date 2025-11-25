SELECT *
FROM `sz-00009-ws.datasetGCP.faturas_fio_raw`
WHERE (numero_instalacao = 'instNum' AND numero_fatura = 'nfNum')
   OR (numero_cliente = 'clientNum' AND numero_fatura = 'nfNum');
