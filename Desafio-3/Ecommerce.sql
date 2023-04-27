-- crianção do banco de dados para o cenario de E-commerce
create database desafio_ecommerce;
use desafio_ecommerce;

-- criar tabela cliente
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
    constraint unique_cpf_client unique (CPF)
);

alter table clients modify Address varchar(255);
alter table clients auto_increment=1;

desc clients;
    
-- criar tabela produto
-- size equivale a dimensao do produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(10),
    classification_kids bool,
    category enum('eletronico','vestimenta','brinquedos','alimentos','moveis') not null,
    avaliação float default 0,
    size varchar(10)
);

alter table product modify Pname varchar(25);

-- criar tabela payments
create table payments(
	idClient int primary key,
    id_payment int,
    typePayment enum('boleto','cartao','dois cartoes'),
    limitAvailable float,
    constraint fk_payment_client foreign key (idClient) references clients(idClient)
);
    
-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('cancelado','confirmado','em processamento') default 'em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);

desc orders;
    
-- criar tabela estoque

create table productStorage(
	idproductStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

-- criar tabela fornecedor


create table supplier(
	idSupplier int auto_increment primary key,
    socialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

-- criar a tabela vendedor

create table seller(
	idSeller int auto_increment primary key,
    socialName varchar(255) not null,
    AbsName varchar(255),
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (Cpf)
);

alter table seller add column contact varchar(11);

-- criar tabela vendedor 
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPSeller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idseller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

desc productSeller;

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('disponivel','indisponivel') default 'disponivel',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProductStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_produt_suppiler_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

show tables;

