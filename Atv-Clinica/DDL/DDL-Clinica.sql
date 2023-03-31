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
