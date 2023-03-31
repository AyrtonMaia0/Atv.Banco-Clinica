create database bd_clinica;
-- drop database bd_clinica;

use bd_clinica;
-- drop database bd_clinica;

-- Ambulatorios: nroa (int) PK, andar (numeric(3)) (não nulo), capacidade(smallint)
create table if not exists tbl_ambulatorios(
	NROA int not null primary key,
    ANDAR numeric(3) not null,
    CAPACIDADE smallint
);


-- Medicos: codm (int) PK, nome (varchar(40)) (não nulo), idade (smallint) (não nulo), especialidade (char(20)), CPF (numeric(11)) (único), cidade (varchar(30)), nroa (int)
create table if not exists tbl_medicos(
	CODM int not null primary key,
    NOME varchar(40) not null, 
    IDADE smallint not null,
    ESPECIALIDADE char(20),
    CPF numeric(11) unique,
    CIDADE varchar(30),
	NROA int,
    foreign key (NROA) references tbl_ambulatorios(NROA)
--  constraint FK_NROA foreign key (NROA) references tbl_ambulatorios (NROA)
);


-- Pacientes: codp (int) PK, nome (varchar(40)) (não nulo), idade (smallint) (não nulo), cidade (char(30)), CPF (numeric(11)) (único), doenca (varchar(40)) (não nulo)
create table if not exists tbl_pacientes(
	CODP int not null primary key,
    NOME varchar(40) not null,
    IDADE smallint not null,
    CIDADE char(30),
    CPF numeric(11) unique,
    DOENCA varchar(40) not null
);


-- Funcionarios: codf (int) PK, nome (varchar(40)) (não nulo), idade (smallint), CPF (numeric(11)) (único), cidade (varchar(30)), salario (numeric(10)), cargo (varchar(20))
create table if not exists tbl_funcionarios(
	CODF int not null primary key,
    NOME varchar(40) not null,
    IDADE smallint,
    CPF numeric(11) unique,
    CIDADE varchar(30),
    SALARIO numeric(10),
    CARGO varchar(20)
);


-- Consultas: codm (int) PK FK, codp (int), data (date), hora (time)
create table if not exists tbl_consultas(
	CODM int,
	CODP int,
    DIA date, -- not null primary key,
    HORA time, -- not null primary key,
	foreign key (CODM) references tbl_medicos(CODM),
    foreign key (CODP) references tbl_pacientes(CODP) on delete cascade on update cascade
);
-- ---Multiplas Primary key------------------------------------------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx




-- Crie a coluna nroa (int) na tabela Funcionarios
alter table tbl_funcionarios add NROA int;
-- describe tbl_funcionarios;
-- drop table tbl_funcionarios;


-- Crie os seguintes índices: • Medicos: CPF (único) • Pacientes: doenca
alter table tbl_medicos add index ixCPF (CPF);
alter table tbl_pacientes add index ixDOENCA (DOENCA);



-- Remover o índice doenca em Pacientes
alter table tbl_pacientes drop index ixDOENCA;
-- describe tbl_pacientes;

-- Remover as colunas cargo e nroa da tabela de Funcionarios
alter table tbl_funcionarios drop column CARGO;
alter table tbl_funcionarios drop column nroa;
-- describe tbl_funcionarios;





/* --- POPULAR TABELAS --- */
-- Ambulatorios (NROA , ANDAR , CAPACIDADE)
insert into tbl_ambulatorios value
(1, 1, 30),
(2, 1, 50),
(3, 2, 40),
(4, 2, 25),
(5, 2, 55);


-- Medicos (CODM, NOME, IDADE, ESPECIALIDADE, CPF, CIDADE, NROA)
insert into tbl_medicos values
(1, 'Joao', 40, 'ortopedia', 10000100000, 'Florianopolis', 1),
(2, 'Maria', 42, 'traumatologia', 10000110000, 'Blumenau', 2),
(3, 'Pedro', 51, 'pediatria', 11000100000, 'São José', 2),
(4, 'Carlos', 28, 'ortopedia', 11000110000, 'Joinville', null),
(5, 'Marcia', 33, 'neurologia', 11000111000, 'Biguacu', 3);


-- Pacientes (CODP, NOME, IDADE, CIDADE, CPF, DOENCA)
insert into tbl_pacientes value
(1, 'Ana', 20, 'Florianopolis', 20000200000, 'gripe'),
(2, 'Paulo', 24, 'Palhoca', 20000220000, 'fratura'),
(3, 'Lucia', 30, 'Biguacu', 22000200000, 'tendinite'),
(4, 'Carlos', 28, 'Joinville', 11000110000, 'sarampo'); 


-- Funcionarios (CODF, NOME, IDADE, CIDADE, SALAIO, CPF)
insert into tbl_funcionarios (CODF, NOME, IDADE, CIDADE, SALARIO, CPF)
value
(1, 'Rita', 32, 'Sao Jose', 1200, 20000100000),
(2, 'Maria', 55, 'Palhoca', 1220, 30000110000),
(3, 'Caio', 45, 'Florianopolis', 1100, 41000100000),
(4, 'Carlos', 44, 'Florianopolis', 1200, 51000110000),
(5, 'Paula', 33, 'Florianopolis', 2500, 61000111000);


-- Consultas
insert into tbl_consultas (CODM, CODP, DIA, HORA)
value
(1, 1, '2006-06-12', '14:00:00'),
(1, 4, '2006-06-13', '10:00:00'),
(2, 1, '2006-06-13', '09:00:00'),
(2, 2, '2006-06-13', '11:00:00'),
(2, 3, '2006-06-14', '14:00:00'),
(2, 4, '2006-06-14', '17:00:00'),
(3, 1, '2006-06-19', '18:00:00'),
(3, 3, '2006-06-12', '10:00:00'),
(3, 4, '2006-06-19', '13:00:00'),
(4, 4, '2006-06-20', '13:00:00'),
(4, 4, '2006-06-22', '19:30:00');




/* --- REALIZAR ATUALIZAÇÕES --- */
-- 1 | O paciente Paulo mudou-se para Ilhota
update tbl_pacientes set CIDADE = 'Ilhota' where NOME = 'Paulo';


-- 2 | A consulta do médico 1 com o paciente 4 passou para às 12:00 horas do dia 4 de Julho de 2006
update tbl_consultas set DIA = '2006-07-04' where CODM = 1 and CODP = 4;
update tbl_consultas set HORA = '12:00:00' where CODM = 1 and CODP = 4;


-- 3 | A paciente Ana fez aniversário e sua doença agora é cancer
update tbl_pacientes set DOENCA = 'cancer' where NOME = 'Ana';


-- 4 | A consulta do médico Pedro (codm = 3) com o paciente Carlos (codp = 4) passou para uma hora e meia depois (13:00:00 => 14:30:00)
update tbl_consultas set HORA = '14:30:00' where CODM = 3 and CODP = 4;


-- 5 | O funcionário Carlos (codf = 4) deixou a clínica
delete from tbl_funcionarios where NOME = 'Carlos';


-- 6 | As consultas marcadas após as 19 horas foram canceladas
delete from tbl_consultas where HORA >= '19:00:00';


-- 7 | Os pacientes com câncer ou idade inferior a 10 anos deixaram a clínica
delete from tbl_pacientes where DOENCA = 'cancer' or IDADE < 10 ;
-- nao ta indo


-- 8 | Os médicos que residem em Biguacu e Palhoca deixaram a clínica
delete from tbl_medicos where CIDADE = 'Biguacu' or CIDADE = 'Palhoca';



