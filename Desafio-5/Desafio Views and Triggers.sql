-- Desafio 5 - Modulo 4 SQL Specialista DIO - 

-- 1 - Views, privilegios
-- 2 - Triggers

-- 1 - Views em Company_constraints

-- Número de empregados por departamento e localidade 

CREATE VIEW employees_by_dep_loc AS
	SELECT d.Dnumber AS Dept_number, dl.Dlocation AS Location, COUNT(*) AS Quantidade
	FROM Employee e
	INNER JOIN Departament d ON e.Dno = d.Dnumber
	INNER JOIN Dept_locations dl ON d.Dnumber = dl.Dnumber
	GROUP BY d.Dnumber, dl.Dlocation
	ORDER BY Quantidade;

select * from employees_by_dep_loc;

-- Lista de departamentos e seus gerentes

CREATE VIEW dpt_mngr_list AS
	SELECT d.Dname AS Department_Name, e.Ssn AS Manager_SSN, d.Dnumber AS Department_Number
	FROM Departament d
	INNER JOIN Employee e ON d.Mgr_ssn = e.Ssn
	INNER JOIN Dept_locations dl ON d.Dnumber = dl.Dnumber
	ORDER BY Department_Name;

select * from dpt_mngr_list;

-- Projetos com maior número de empregados por ordenação desc

CREATE VIEW works_employee AS
	SELECT w.Essn, COUNT(*) AS Qtd_employees
	FROM works_on w
	INNER JOIN Employee e ON e.Ssn = w.Essn
	INNER JOIN Departament d on  d.Dnumber = e.Dno
	GROUP BY e.Dno
	ORDER BY COUNT(*) DESC;

select * from dpt_mngr_list;

-- Lista de projetos, departamentos e gerentes 
 
 CREATE VIEW works_dep_mgr AS
	SELECT d.Dname AS Department, p.Pname AS Project, e.Fname AS Manager
	FROM Departament d
	INNER JOIN Employee e ON d.Mgr_ssn = e.Ssn
	INNER JOIN Departament dp ON dp.Mgr_ssn = e.Ssn
	INNER JOIN works_on w ON p.Pnumber = w.Pno AND e.Ssn = w.Essn
	GROUP BY d.Dname, p.Pname, e.Fname
	ORDER BY e.Fname;
    
select * from works_dep_mgr;

-- Quais empregados possuem dependentes e se são gerentes

drop view mgr_with_dependent;

CREATE VIEW mgr_with_dependent AS
SELECT e.Fname AS Manager, 
CASE WHEN e.Dno IS NOT NULL 
	THEN 'Yes' 
	ELSE 'No' 
    END AS Is_Manager
FROM Employee e
INNER JOIN Dependent d ON d.Essn = e.Ssn
GROUP BY e.Fname, e.Dno
ORDER BY e.Fname;
    
select * from mgr_with_dependent;


-- -1 Privilegios ao user; Criação de usuário gerente que terá acesso as informações de employee e departamento na Company_constraints

use company_constraints;

create user 'manager'@localhost identified by '123456789';
grant all privileges on manager.employees_by_dep_loc to 'manager'@localhost;

-- 2 Before update statement em Company Constraints
# Atribuindo aumento de salario para dpt especifico = 1 salary * 1.20; 

select * from employee;



delimiter \\
create trigger up_salary_dp_4 before insert on employee
for each row
	begin
		case new.Dno
			when 4 then set new.Salary = Salary*1.20;
		end case;
	end \\
delimiter ;

-- before delete statement
# salvando m outra tabela os employees demitidos
# old.attribute

drop table fired_employees;
CREATE TABLE fired_employees (
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    Ssn char(9) NOT NULL,
    Dno int NOT NULL
);

delimiter \\
CREATE TRIGGER trigger_nome
BEFORE DELETE ON employee
FOR EACH ROW
BEGIN
    INSERT INTO fired_employees (Fname, Ssn, Dno)
VALUES (OLD.Fname, OLD.Ssn, OLD.Dno);
END;
delimiter ;

select * from fired_employees;