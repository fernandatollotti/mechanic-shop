create database if not exists mechanic_shop;

use mechanic_shop;

create table customer (
	id_customer int auto_increment primary key,
	fullname varchar(100) not null,
	CPF char(11),
	CNPJ char(14), 
	email varchar(50),
	phone char(11),
	address varchar(100),
	constraint unique_cpf_customer unique(CPF),
	constraint unique_cnpj_customer unique(CNPJ)
);

create table mechanic (
	id_mechanic int auto_increment primary key,
	fullname varchar(100) not null,
	specialty varchar(30) not null,
	address varchar(50),
	phone char(11)
);

create table service (
	id_service int auto_increment primary key,
	name varchar(50) not null,
	description varchar(255),
	price decimal(10, 2)
);

create table part (
	id_part int auto_increment primary key,
	name varchar(50) not null,
	description varchar(100),
	unit_price decimal(10, 2) not null,
	stock_quantity int default 1
);

create table payment_method (
	id_payment_method int auto_increment primary key,
	type_payment enum('Cartão de crédito', 'PIX', 'Dinheiro') not null,
	allows_installments bool not null
);

create table vehicle (
	id_vehicle int auto_increment primary key,
	id_customer int not null,
	plate char(7) not null,
	brand varchar(50),
	model varchar(50),
	year int,
	constraint unique_plate_vehicle unique (plate),
	constraint fk_vehicle_customer foreign key (id_customer) references customer (id_customer)
);

create table service_order (
	id_service_order int auto_increment primary key,
	id_customer int not null,
	id_vehicle int not null,
	id_mechanic int not null,
	issue_date date not null,
	status enum('Em andamento', 'Aguardando Peças', 'Pronto para Retirada', 'Aguardando Pagamento', 'Concluído', 'Cancelado') default 'Em andamento',
	completion_date date,
	total_value decimal(10, 2),
	constraint fk_so_customer foreign key (id_customer) references customer (id_customer),
	constraint fk_so_vehicle foreign key (id_vehicle) references vehicle (id_vehicle),
	constraint fk_so_mechanic foreign key (id_mechanic) references mechanic (id_mechanic)
);

create table payment (
	id_payment int auto_increment primary key,
	id_service_order int not null,
	id_payment_method int not null,
	payment_date datetime not null,
	amount decimal(10, 2) not null,
	installments int default 1,
	transaction_details varchar(50),
	constraint fk_payment_so foreign key (id_service_order) references service_order (id_service_order),
	constraint fk_payment_method foreign key (id_payment_method) references payment_method (id_payment_method)
);


create table so_service (
	id_service_order int,
	id_service int,
	price_ranged decimal(10, 2),
	primary key (id_service_order, id_service),
	constraint fk_ss_so foreign key (id_service_order) references service_order (id_service_order),
	constraint fk_ss_service foreign key (id_service) references service (id_service)
);

create table so_part (
	id_service_order int,
	id_part int,
	quantity_used int not null,
	sale_price decimal(10,2),
	primary key (id_service_order, id_part),
	constraint fk_sp_so foreign key (id_service_order) references service_order (id_service_order),
	constraint fk_sp_part foreign key (id_part) references part (id_part)
);

















