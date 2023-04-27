use desafio_ecommerce;

-- idClient, Fname, Minit, Lname, CPF, Address
insert into Clients (Fname, Minit, Lname, CPF, Address) 
	   values('Maria','M','Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
		     ('Matheus','O','Pimentel', 987654321,'rua alemeda 289, Centro - Cidade das flores'),
			 ('Ricardo','F','Silva', 45678913,'avenida alemeda vinha 1009, Centro - Cidade das flores'),
			 ('Julia','S','França', 789123456,'rua lareijras 861, Centro - Cidade das flores'),
			 ('Roberta','G','Assis', 98745631,'avenidade koller 19, Centro - Cidade das flores'),
			 ('Isabela','M','Cruz', 654789123,'rua alemeda das flores 28, Centro - Cidade das flores');
             
             
-- idProduct, Pname, classification_kids boolean, category('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'), avaliação, size
insert into product (Pname, classification_kids, category, avaliação, size) values
							  ('Fone de ouvido',false,'eletronico','4',null),
                              ('Barbie Elsa',true,'brinquedos','3',null),
                              ('Body Carters',true,'vestimenta','5',null),
                              ('Microfone Vedo - Youtuber',False,'eletronico','4',null),
                              ('Sofá retrátil',False,'moveis','3','3x57x80'),
                              ('Farinha de arroz',False,'alimentos','2',null),
                              ('Fire Stick Amazon',False,'eletronico','3',null);
                              
select *
	from clients;
    
select *
	from product;
    
-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash

-- delete from orders where idOrderClient in  (1,2,3,4);
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (1, default,'compra via aplicativo',null,1),
                             (2,default,'compra via aplicativo',50,0),
                             (3,'Confirmado',null,null,1),
                             (4,default,'compra via web site',150,0);
                             
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (2, default,'compra via aplicativo',null,1);
                             
-- idPOproduct, idPOorder, poQuantity, poStatus
select * from productOrder;
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1,1,2,null),
                         (2,1,1,null),
                         (3,2,1,null);
                         
-- storageLocation,quantity
insert into productStorage (storageLocation,quantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);
                            
-- idLproduct, idLstorage, location
insert into storageLocation (idLproduct, idLstorage, location) values
						 (1,2,'RJ'),
                         (2,6,'GO');
                         
-- idSupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact) values 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
                            
-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);
                         
-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller (SocialName, AbsName, CNPJ, CPF, location, contact) values 
						('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
					    ('Botique Durgas',null,null,123456783,'Rio de Janeiro', 219567895),
						('Kids World',null,456789123654485,null,'São Paulo', 1198657484);
                        
insert into productSeller (idPseller, idPproduct, prodQuantity) values 
						 (1,6,80),
                         (2,7,10);
                         
insert into payments (idClient, id_payment, typePayment, limitAvailable ) values 
						 (1,5467,'boleto',500),
                         (2,7657,'cartao',400),
                         (5,3465,'boleto',550),
                         (3,8796,'cartao',300),
                         (4,8800,'cartao',250),
                         (6,4564,'dois cartoes',100);
                         

select count(*) from clients;
select * from clients c, orders o where c.idclient = idorderclient;
select concat(Fname,' ',Lname) as Client, idorder as Request, orderStatus as Status from clients c, orders o where c.idclient = idorderclient;

select count(*) from clients c, orders o 
	where c.idclient = idorderclient
	group by idorder;
    
select * from clients
	left outer join orders ON idclient = idorderclient;
    
select * from clients c inner join orders o on c.idclient = o.idorderclient
					inner join productorder p on p.idPOorder = o.idorder;
    
select count(*) from clients c inner join orders o on c.idclient = o.idorderclient
					inner join productorder p on p.idPOorder = o.idorder
                    group by idclient;

-- recuperar quantos pedidos foram realizados
select c.idclient, Fname, count(*) as Number_of_orders from clients c
					inner join orders o on c.idclient = o.idorderclient
					inner join productorder p on p.idPOorder = o.idorder
                    group by idclient;
                    
select c.idclient, Fname, count(*) as Number_of_orders from clients c
					inner join orders o on c.idclient = o.idorderclient
                    group by idclient;
                    
use desafio_ecommerce;

-- Quantas compras 'via aplicativo' houveram agrupadas por idOrder maior = a 1
select idOrder, count(*)
	from Orders
    where orderDescription = 'compra via aplicativo'
    group by idOrder
    having count(*) >= 1;
    
-- Atualizamos os limites de acordo com os pagamentos de cada cliente
update payments
	set limitAvailable =
	case
		when typePayment = 'boleto' then limitAvailable + 500
        when typePayment = 'cartao' then limitAvailable + 200
        when typePayment = 'dois cartoes' then limitAvailable + 100
        else limitAvailable + 0
	end;
select * from payments;


-- Pelas informações do local de vendedor e do estoque ordenados pelo id do vendedor
select *
	from seller, productstorage
    where Location = storagelocation
    order by idseller;
    
-- quantos pedidos foram realizados
select c.idclient, Fname, count(*) as Number_of_orders from clients c
					inner join orders o on c.idclient = o.idorderclient
					inner join productorder p on p.idPOorder = o.idorder
                    group by idclient;

select * from product;