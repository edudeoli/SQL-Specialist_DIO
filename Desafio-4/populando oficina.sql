use oficina_mecanica;

insert into Clients (Fname, Minit, Lname, CPF, Address, Contact) 
	   values('Matheus','B','Assis', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores', 21985621456),
		     ('Julia','D','Cruz', 987654321,'rua alemeda 289, Centro - Cidade das flores', 19996852154),
			 ('Roberto','H','Silva', 45678913,'avenida alemeda vinha 1009, Centro - Cidade das flores', 15993254512),
			 ('Maria','W','França', 789123456,'rua lareijras 861, Centro - Cidade das flores', 43993652125),
			 ('Isabela','O','Alves', 98745631,'avenidade koller 19, Centro - Cidade das flores', 12996852364),
			 ('Joao','Q','Pimental', 654789123,'rua alemeda das flores 28, Centro - Cidade das flores', 11994875282);

select * from clients;

insert into Mechanic (Fname, Lname, Contact, Specialty)
	values('Roger','Waters', 11996523214,'car'),
		  ('David','Gilmour', 43996565254,'van'),
          ('Rick','Wright', 44998521478,'suv'),
          ('Nick','Mason', 21963254782,'car'),
          ('Josh','Homme', 11998521452,'suv'),
          ('Nick','Oliveri', 31963256987,'car');
          
select * from mechanic;

insert into Vehicle (idClientVehicle, Vbrandname, Vmanufacturer, Vcategory, licencePlate)
	values('2','X3','BMW', 'car','GTR9T98'),
		  ('4','Z4','Mercedez', 'car','FSD2E36'),
          ('5','C3','Citroen', 'suv','QWE3R57'),
          ('1','Towner','Hyundai', 'van','EDU7H36'),
          ('6','Creta','Hyundai', 'suv','TRE5S36'),
          ('3','Fusca','VolksWagen', 'car','VCF3D85');
          
    
select * from Order_of_Service;
          
insert into Order_of_Service (idOrderMechanic, idOrderVehicle, dateOrder, expirationDateOrder, labor_value, parts_value, total_value)
	values('6','7','20230425','20230525','500.50','255.50','756.00'),
		  ('5','9','20230323','20230423','300.00','100.55','400.55'),
          ('3','12','20230215','20230315','200.15','200.40','400.55'),
          ('4','11','20230417','20230517','350.25','150.90','501.15'),
          ('3','10','20230414','20230514','125.00','125.10','250.10'),
          ('1','8','20230120','20230220','425.15','200.00','625.10');

-- left join de clientes e ordem de serviço
select * from clients
	left outer join order_of_service ON idClient = IdOrder;
    
-- left join de clientes e ordem de serviço em ordem por id cliente
select * from clients
	left outer join order_of_service ON idClient = IdOrder
    order by idclient;
    
-- buscando a categoria 'car' e agrupando pela mesma com a quantidade
select Vcategory, count(*)
	from Vehicle
    where Vcategory = 'car'
    group by Vcategory
    having count(*) >= 1;
    
-- selecionando cliente, numeo de ordem e modelo do carro ordenado pelo nome do cliente
select concat(Fname,' ',Lname) as Cliente, idorder as OS, Vbrandname as Modelo
	from clients c, order_of_service o, vehicle v
    where IdOrder
    order by Cliente;
    
select *
	from order_of_service;