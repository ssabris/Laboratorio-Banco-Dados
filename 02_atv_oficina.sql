create database oficina;
use oficina;

create table oficina(
	codigoOficina bigint primary key,
	cnpj varchar(30) not null,
	nome varchar(100) not null,
	telefone varchar(30),
	email varchar(100) not null unique
);

create table fabricante(
	codigoFabricante bigint primary key,
	nome varchar(100) not null,
	telefone varchar(30),
	email varchar(100) not null unique,
	responsavel varchar(100)
);

create table modelo(
	codigoModelo bigint primary key,
	tipo varchar(100) not null,
	peso decimal(12,4) default(1),
	fkCodigoFabricante bigint,
	horaTeste int default(100),
	
	foreign key (fkCodigoFabricante)
	references fabricante(codigoFabricante)
);

create table maquina(
	numeroRegistro varchar(100) primary key,
	ano char(4),
	horasUso int default(0),
	fkCodigoModelo bigint,
	
	foreign key (fkCodigoModelo)
	references modelo(codigoModelo)
);

create table tecnico(
	codigoFuncional bigint primary key,
	endereco varchar(100),
	telefone varchar(30),
	salario decimal(9,2) default(0),
	qualificacao varchar(300),
	fkCodigoOficina bigint,
	
	foreign key (fkCodigoOficina)
	references oficina(codigoOficina)
);

create table teste(
	codigoTeste bigint primary key,
	pontuacao decimal(5,2) default(0),
	resultado varchar(400) not null,
	recomendacoes varchar(300),
	fkCodigoOficina bigint,
	fkCodigoFuncional bigint,
	
	foreign key (fkCodigoOficina)
	references oficina(codigoOficina),
	
	foreign key (fkCodigoFuncional)
	references tecnico(codigoFuncional)
);

create table modelo_oficina(
	fkCodigoOficina bigint,
	fkCodigoModelo bigint,
	
	primary key (fkCodigoOficina, fkCodigoModelo),
	
	foreign key (fkCodigoOficina)
	references oficina(codigoOficina),
	
	foreign key (fkCodigoModelo)
	references modelo(codigoModelo)
);

create table tecnico_modelo(
	fkCodigoModelo bigint,
	fkCodigoFuncional bigint,
	
	primary key (fkCodigoModelo, fkCodigoFuncional),
	
	foreign key (fkCodigoModelo)
	references modelo(codigoModelo),
	
	foreign key (fkCodigoFuncional)
	references tecnico(codigoFuncional)
);
