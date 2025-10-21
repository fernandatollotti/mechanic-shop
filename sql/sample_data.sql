use mechanic_shop;

INSERT INTO customer (fullname, CPF, CNPJ, email, phone, address) VALUES
('João Silva', '12345678901', NULL, 'joao.s@email.com', '11987654321', 'Rua das Flores, 100'),
('Maria Oliveira', '98765432109', NULL, 'maria.o@email.com', '11998765432', 'Av. Central, 500, Apto 10'),
('Auto Express Reparos Ltda', NULL, '01234567890123', 'contato@autoexpress.com', '1133334444', 'Rua Industrial, 90'),
('Pedro Santos', '11122233344', NULL, 'pedro.s@email.com', '11911112222', 'Av. Paulista, 10'), 
('Ana Mendes (VIP)', '55566677788', NULL, 'ana.m@email.com', '11922223333', 'Alameda das Acácias, 20'),
('Transportadora Rápida S.A.', NULL, '44455566677889', 'contato@rapida.com', '1144445555', 'Rodovia Principal, Galpão A'), 
('Lucas Ferreira', '77788899900', NULL, 'lucas.f@email.com', '11955556666', 'Rua do Bosque, 30'), 
('Carla Gomes', '33322211100', NULL, 'carla.g@email.com', '11966667777', 'Rua Larga, 45'); 

INSERT INTO mechanic (fullname, specialty, address, phone) VALUES
('Carlos Souza', 'Motor/Transmissão', 'Rua A, 1', '11912345678'), 
('Ana Costa', 'Suspensão/Freios', 'Rua B, 2', '11987654321'), 
('Ricardo Alves', 'Elétrica/Eletrônica', 'Rua C, 3', '11999990000'), 
('Marcos Lima', 'Geral/Preventiva', 'Rua D, 4', '11977778888');

INSERT INTO service (name, description, price) VALUES
('Troca de Óleo', 'Substituição de óleo e filtro.', 120.00), 
('Alinhamento', 'Alinhamento de direção.', 80.00), 
('Balanceamento', 'Balanceamento das 4 rodas.', 60.00), 
('Revisão Geral', 'Checklist completo.', 350.00),
('Substituição de Bateria', 'Instalação de nova bateria.', 50.00), 
('Reparo Elétrico', 'Diagnóstico e correção de falhas elétricas.', 150.00);

INSERT INTO part (name, description, unit_price, stock_quantity) VALUES
('Filtro de Óleo', 'Filtro para motor 1.0/1.4.', 25.00, 50), 
('Amortecedor Dianteiro', 'Amortecedor para linha popular.', 150.00, 10), 
('Vela de Ignição (kit)', 'Conjunto de 4 velas.', 40.00, 30), 
('Pastilha de Freio', 'Pastilhas de alto desempenho.', 80.00, 25), 
('Bateria 60Ah', 'Bateria automotiva 60Ah.', 250.00, 15); 

INSERT INTO payment_method (type_payment, allows_installments) VALUES
('Dinheiro', FALSE), 
('PIX', FALSE), 
('Cartão de crédito', TRUE); 

INSERT INTO vehicle (id_customer, plate, brand, model, year) VALUES
(1, 'ABC1234', 'Fiat', 'Uno', 2010), 
(2, 'DEF5678', 'Ford', 'Ka', 2018),
(5, 'GHI9012', 'BMW', 'X1', 2020), 
(5, 'JKL3456', 'BMW', 'Série 3', 2018),
(6, 'MNO7890', 'Scania', 'Caminhão P360', 2015), 
(8, 'PQR1234', 'VW', 'Gol', 2013); 

INSERT INTO service_order (id_customer, id_vehicle, id_mechanic, issue_date, status, completion_date, total_value) VALUES
(1, 1, 1, '2025-01-05', 'Concluído', '2025-01-06', 250.00), 
(2, 2, 2, '2025-02-10', 'Aguardando Pagamento', '2025-02-10', 530.00), 
(5, 3, 3, '2025-03-20', 'Concluído', '2025-03-21', 120.00), 
(5, 4, 4, '2025-04-01', 'Em andamento', NULL, 470.00), 
(6, 5, 1, '2025-04-15', 'Concluído', '2025-04-18', 1800.00), 
(8, 6, 2, '2025-05-01', 'Cancelado', NULL, 0.00); 

INSERT INTO so_service (id_service_order, id_service, price_ranged) VALUES (1, 4, 250.00);

INSERT INTO so_service (id_service_order, id_service, price_ranged) VALUES (2, 6, 150.00), (2, 5, 50.00);

INSERT INTO so_service (id_service_order, id_service, price_ranged) VALUES (3, 1, 120.00);

INSERT INTO so_service (id_service_order, id_service, price_ranged) VALUES (5, 4, 500.00);

INSERT INTO so_part (id_service_order, id_part, quantity_used, sale_price) VALUES (1, 1, 1, 30.00);

INSERT INTO so_part (id_service_order, id_part, quantity_used, sale_price) VALUES (2, 5, 1, 330.00);

INSERT INTO so_part (id_service_order, id_part, quantity_used, sale_price) VALUES (5, 2, 2, 250.00);

INSERT INTO payment (id_service_order, id_payment_method, payment_date, amount, installments, transaction_details) VALUES
(1, 2, '2025-01-06 10:00:00', 250.00, 1, 'Pix Recebido'),
(2, 3, '2025-02-10 14:00:00', 200.00, 2, 'Cartão Parcial'), 
(3, 1, '2025-03-21 14:05:00', 120.00, 1, 'Dinheiro Total'),
(5, 3, '2025-04-18 09:00:00', 1800.00, 10, 'Pagamento 10x');


