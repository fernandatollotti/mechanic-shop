use mechanic_shop;

-- Qual mecânico gerou mais receita bruta no período?
select m.fullname, 
	   sum(so.total_value) gross_revenue 
from mechanic m 
join service_order so using(id_mechanic)
where so.status in ('Concluído', 'Aguardando Pagamento')
group by m.id_mechanic
order by gross_revenue desc;

-- Qual o volume de ordens canceladas por mecânico?
select m.fullname, 
	   count(so.id_service_order) total_canceled_orders
from mechanic m
join service_order so using (id_mechanic)
where so.status = 'Cancelado'
group by m.fullname, m.id_mechanic
order by total_canceled_orders desc;

-- Qual o tempo médio de conclusão (emissão e conclusão) de uma ordem de serviço por tipo de serviço?
select s.name service_name, 
	   avg(datediff(so.completion_date, so.issue_date)) average_time_days
from service_order so 
join so_service using(id_service_order)
join service s on so_service.id_service = s.id_service
where so.status = 'Concluído'
group by s.name
order by average_time_days desc;

-- Qual é o saldo devedor atual e quais clientes estão devendo?
select c.fullname customer_name, 
	   so.total_value total_order_value, 
	   sum(p.amount) total_paid, 
	   (so.total_value - sum(p.amount)) outstanding_balance
from service_order so
join customer c using(id_customer)
join payment p using(id_service_order)
where so.status not in  ('Concluído', 'Cancelado')
group by so.id_service_order, c.fullname, so.total_value
having outstanding_balance > 0
order by outstanding_balance desc;


-- Qual a forma de pagamento mais utilizada (PIX, Cartão, Dinheiro) em volume e valor, e qual a média de parcelamento no cartão?
select pm.type_payment payment_method,
	   count(p.id_payment) transaction_volume,
	   sum(p.amount) total_value_processed,
	   avg(p.installments) avg_installments
from payment p 
join payment_method pm using(id_payment_method)
where pm.type_payment = 'Cartão de crédito'
group by pm.type_payment
order by total_value_processed desc;

-- Qual o custo total das peças vendidas versus a receita gerada por elas?
select sum(sop.quantity_used * sop.sale_price) parts_revenue,
	   sum(sop.quantity_used *  pt.unit_price) parts_cost,
	   (sum(sop.quantity_used * sop.sale_price) - sum(sop.quantity_used * pt.unit_price)) parts_profit
from so_part sop
join part pt using(id_part)
where sop.quantity_used > 0;

-- Quais são os 5 clientes (Pessoa Física ou Jurídica) que geraram a maior receita total para a oficina?
select c.fullname, 
	   sum(so.total_value) revenue_generated
from customer c
join service_order so using(id_customer)
group by c.fullname
order by revenue_generated desc
limit 5;

-- Qual é a marca e modelo de veículo mais frequente na oficina?
select v.brand,
	   v.model,
	   count(so.id_service_order) total_orders
from vehicle v
join service_order so using(id_vehicle)
group by v.brand, v.model
order by total_orders desc
limit 1;

-- Quantos clientes possuem mais de um veículo registrado e qual o seu valor médio de ordem de serviço?
select count(distinct so.id_customer) total_car_customers,
	   avg(so.total_value) avg_order_value
from service_order so
where so.id_customer in (
	select id_customer 
	from vehicle
	group by id_customer
	having count(id_vehicle) > 1
);
