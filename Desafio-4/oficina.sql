-- crianção do banco de dados para oficina mecânica
create database oficina_mecanica;
use oficina_mecanica;


create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
    contact char(11),
    constraint unique_cpf_client unique (CPF)
);
alter table clients modify Address varchar(255);
alter table clients auto_increment=1;

create table mechanic(
	iDmechanic int auto_increment primary key,
    Fname varchar(10),
    Lname varchar(25),
    contact char(11),
    specialty enum('car','suv','van') not null
);

create table vehicle(
	idVehicle int auto_increment primary key,
    idClientVehicle int,
    Vbrandname varchar(10) not null,
    Vmanufacturer varchar(10) not null,
    Vcategory enum('car','suv','van') not null,
    licencePlate varchar(7),
    constraint unique_licencePlate_vehicle unique (licencePlate),
    constraint fk_vehicle_client foreign key (idClientVehicle) references clients(idClient)
);

-- drop table vehicle;

create table Order_of_Service(
	IdOrder int auto_increment primary key,
    idOrderMechanic int,
    idOrderVehicle int,
    dateOrder date,
    expirationDateOrder date not null,
	labor_value float default 0,
    parts_value float default 0,
    total_value float not null,
    constraint fk_order_of_service_mechanic foreign key (idOrderMechanic) references mechanic(iDmechanic),
    constraint fk_order_of_service_vehicle foreign key (idOrderVehicle) references vehicle(idVehicle)
);

