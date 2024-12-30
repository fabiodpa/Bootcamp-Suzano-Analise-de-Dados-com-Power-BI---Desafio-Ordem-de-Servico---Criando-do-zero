-- Benco de Dados para o cenário da Oficina no desafio
-- drop database Oficina_desafio;
create database Oficina_desafio;
use Oficina_desafio;


-- criar tabela Mecânico
create table Mecanico(
idMecanico int auto_increment primary key,
Nome varchar(45),
Endereço varchar(255),
Especialidade enum('Sistemas eletrônicos','Freios','Suspensão','Amortecedores','Sistemas de transmissão','Direção hidráulica','Câmbio automático','Injeção eletrônica','Carroceria e lataria','Estética automotiva') not null
);
alter table Mecanico auto_increment=1;
select * from mecanico;

-- criar tabela Veículo
create table Veiculo(
idVeiculo int auto_increment primary key,
Modelo varchar(45),
Ano int,
Placa varchar(10)
);
alter table Veiculo auto_increment=1;
select * from veiculo;

-- criar tabela Ordem_Servico
create table Ordem_Servico(
idOrdem_de_Servico int auto_increment primary key,
idOrdMecanico int,
idOrdVeiculo int,
Data_Emissao date,
Data_Entrega date,
Status enum('Incluído','Em análise','Aprovado','Reprovado','Em Execução','Pronto','Finalizado') not null,
Valor decimal(10,2),
Tipo_Atendimento enum('Conserto','Revisão') not null,
constraint fk_Os_Mecanico foreign key (idOrdMecanico) references Mecanico(idMecanico),
constraint fk_Os_Veiculo foreign key (idOrdVeiculo) references Veiculo(idVeiculo)
);
alter table Ordem_Servico auto_increment=1;
select * from Ordem_Servico;

-- criar Mão de obra
create table Mao_de_Obra(
idMao_de_Obra int auto_increment primary key,
Descricao_Mo varchar(45),
Valor decimal(10,2)
);
alter table Mao_de_Obra auto_increment=1;
select * from Mao_de_Obra;

-- criar Pecas
create table Pecas(
idPeca int auto_increment primary key,
Descricao_Peca varchar(45),
Valor decimal(10,2)
);
alter table Pecas auto_increment=1;
select * from Pecas;

-- criar Servicos
create table Servico(
idServico int auto_increment primary key,
Descricao_Servico varchar(45),
Mecanico_Responsavel varchar(45)
);
alter table Servico auto_increment=1;
select * from Servico;

show tables;

-- criar OS MO
create table OS_MO(
idOsMo_Os int,
idOsMo_Mo int,
primary key (idOsMo_Os,idOsMo_Mo),
constraint fk_OS_MO_Os foreign key (idOsMo_Os) references Ordem_Servico(idOrdem_de_Servico),
constraint fk_OS_MO_Mo foreign key (idOsMo_Mo) references Mao_de_Obra(idMao_de_Obra)
);
select * from OS_MO;

-- criar OS Peca
create table OS_Peca(
idOsPeca_Os int,
idOsPeca_Peca int,
primary key (idOsPeca_Os,idOsPeca_Peca),
constraint fk_OS_Peca_Os foreign key (idOsPeca_Os) references Ordem_Servico(idOrdem_de_Servico),
constraint fk_OS_Peca_Peca foreign key (idOsPeca_Peca) references Pecas(idPeca)
);
select * from OS_Peca;

-- criar OS Serviço
create table OS_Serv(
idOsServ_Os int,
idOsServ_Serv int,
primary key (idOsServ_Os,idOsServ_Serv),
constraint fk_OS_Serv_Os foreign key (idOsServ_Os) references Ordem_Servico(idOrdem_de_Servico),
constraint fk_OS_Serv_Serv foreign key (idOsServ_Serv) references Servico(idServico)
);
select * from OS_Serv;

-- criar Mecanico Serviço
create table Mec_Serv(
idMecServ_Os int,
idMecServ_Serv int,
primary key (idMecServ_Os,idMecServ_Serv),
constraint fk_Mec_Serv_Os foreign key (idMecServ_Os) references Mecanico(idMecanico),
constraint fk_Mec_Serv_Serv foreign key (idMecServ_Serv) references Servico(idServico)
);
select * from Mec_Serv;

show tables;

-- inserção de dados
-- Popular tabela Mecanico
INSERT INTO Mecanico (Nome, Endereço, Especialidade) VALUES
('Carlos Silva', 'Rua das Flores, 123, São Paulo, SP', 'Sistemas eletrônicos'),
('Ana Pereira', 'Avenida Brasil, 456, Rio de Janeiro, RJ', 'Freios'),
('João Souza', 'Rua das Palmeiras, 789, Belo Horizonte, MG', 'Suspensão'),
('Mariana Oliveira', 'Rua dos Pinheiros, 101, Curitiba, PR', 'Amortecedores'),
('Pedro Santos', 'Avenida Paulista, 202, São Paulo, SP', 'Sistemas de transmissão'),
('Lucas Costa', 'Rua das Acácias, 303, Porto Alegre, RS', 'Direção hidráulica'),
('Fernanda Lima', 'Rua das Hortênsias, 404, Salvador, BA', 'Câmbio automático'),
('Rafael Almeida', 'Avenida Atlântica, 505, Florianópolis, SC', 'Injeção eletrônica'),
('Juliana Rocha', 'Rua das Magnólias, 606, Recife, PE', 'Carroceria e lataria'),
('Gustavo Ferreira', 'Avenida das Américas, 707, Brasília, DF', 'Estética automotiva');

-- Popular tabela Veiculo
INSERT INTO Veiculo (Modelo, Ano, Placa) VALUES
('Fiat Uno', 2010, 'ABC-1234'),
('Volkswagen Gol', 2015, 'DEF-5678'),
('Chevrolet Onix', 2018, 'GHI-9012'),
('Ford Ka', 2012, 'JKL-3456'),
('Renault Sandero', 2016, 'MNO-7890'),
('Hyundai HB20', 2019, 'PQR-2345'),
('Toyota Corolla', 2020, 'STU-6789'),
('Honda Civic', 2017, 'VWX-0123'),
('Nissan Kicks', 2021, 'YZA-4567'),
('Jeep Renegade', 2022, 'BCD-8901');

-- Popular tabela Ordem_Servico
INSERT INTO Ordem_Servico (idOrdMecanico, idOrdVeiculo, Data_Emissao, Data_Entrega, Status, Valor, Tipo_Atendimento) VALUES
(1, 1, '2024-01-01', '2024-01-05', 'Em Execução', 500.00, 'Conserto'),
(2, 2, '2024-01-02', '2024-01-06', 'Pronto', 300.00, 'Revisão'),
(1, 3, '2024-01-03', '2024-01-07', 'Em Execução', 450.00, 'Conserto'),
(4, 4, '2024-01-04', '2024-01-08', 'Aprovado', 600.00, 'Revisão'),
(5, 5, '2024-01-05', '2024-01-09', 'Incluído', 700.00, 'Conserto'),
(6, 6, '2024-01-06', '2024-01-10', 'Em análise', 800.00, 'Revisão'),
(7, 7, '2024-01-07', '2024-01-11', 'Reprovado', 200.00, 'Conserto'),
(8, 8, '2024-01-08', '2024-01-12', 'Finalizado', 900.00, 'Revisão'),
(9, 9, '2024-01-09', '2024-01-13', 'Pronto', 1000.00, 'Conserto'),
(10, 10, '2024-01-10', '2024-01-14', 'Em Execução', 1100.00, 'Revisão');

-- Popular tabela Mao_de_Obra
INSERT INTO Mao_de_Obra (Descricao_Mo, Valor) VALUES
('Troca de óleo', 100.00),
('Alinhamento', 150.00),
('Balanceamento', 120.00),
('Revisão de freios', 200.00),
('Troca de amortecedores', 250.00),
('Revisão de suspensão', 300.00),
('Troca de correia dentada', 350.00),
('Revisão de injeção eletrônica', 400.00),
('Troca de embreagem', 450.00),
('Revisão de direção hidráulica', 500.00);

-- Popular tabela Pecas
INSERT INTO Pecas (Descricao_Peca, Valor) VALUES
('Filtro de óleo', 50.00),
('Pastilha de freio', 80.00),
('Amortecedor', 150.00),
('Correia dentada', 100.00),
('Velas de ignição', 60.00),
('Bateria', 200.00),
('Filtro de ar', 40.00),
('Filtro de combustível', 70.00),
('Disco de freio', 120.00),
('Pneu', 300.00);

-- Popular tabela Servico
INSERT INTO Servico (Descricao_Servico, Mecanico_Responsavel) VALUES
('Troca de óleo', 'Carlos Silva'),
('Alinhamento', 'Ana Pereira'),
('Balanceamento', 'João Souza'),
('Revisão de freios', 'Mariana Oliveira'),
('Troca de amortecedores', 'Pedro Santos'),
('Revisão de suspensão', 'Lucas Costa'),
('Troca de correia dentada', 'Fernanda Lima'),
('Revisão de injeção eletrônica', 'Rafael Almeida'),
('Troca de embreagem', 'Juliana Rocha'),
('Revisão de direção hidráulica', 'Gustavo Ferreira');

-- Popular tabela OS_MO
INSERT INTO OS_MO (idOsMo_Os, idOsMo_Mo) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Popular tabela OS_Peca
INSERT INTO OS_Peca (idOsPeca_Os, idOsPeca_Peca) VALUES
(1, 1),
(2, 1), 
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Popular tabela OS_Serv
INSERT INTO OS_Serv (idOsServ_Os, idOsServ_Serv) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Popular tabela Mec_Serv
INSERT INTO Mec_Serv (idMecServ_Os, idMecServ_Serv) VALUES
(1, 1),
(1, 2), 
(1, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);


-- inserção de queries
-- Das ordens de serviço cadastradas, me informe a quantidade por tipo de atendimento.
use oficina_desafio;
select * from Ordem_Servico;
select Tipo_Atendimento, COUNT(idOrdem_de_Servico) as Qtde_OC
from Ordem_Servico
group by Tipo_Atendimento;

-- Das ordens de serviço cadastradas, me informe a quantidade por Status.
select Os.Status, COUNT(idOrdem_de_Servico) as Qtde_OC
from Ordem_Servico Os
group by Os.Status
Order by Os.Status;

select * from Ordem_Servico;
select * from Pecas;
select * from Os_Peca;

-- nome do mecanico por Os
select distinct m.Nome as Nome_Mecanico, idOrdem_de_servico as Numero_OS
from Mecanico m
inner join Ordem_Servico os on m.idMecanico = os.idOrdMecanico
order by m.Nome;

-- Nome dos mecanicos nas Os em excecução
select os.idOrdem_de_Servico as Numero_OS, m.Nome as Nome_Mecanico
from Ordem_Servico os
inner join Mecanico m on os.idOrdMecanico = m.idMecanico
where os.status = 'Em Execução'
order by os.idOrdem_de_Servico;

-- Os em execução com tipo de atendimento e mecânico e sua especialidade
select os.idOrdem_de_Servico as Numero_OS, os.Tipo_Atendimento, m.Nome as Nome_Mecanico, m.Especialidade
from Ordem_Servico os
inner join Mecanico m on os.idOrdMecanico = m.idMecanico
where os.status = 'Em Execução'
order by os.idOrdem_de_Servico;

-- Mecanico que tem mais de uma ordem de serviço em execução
select m.Nome as Nome_Mecanico, m.Especialidade, COUNT(os.idOrdem_de_Servico) as Qtde_OS_Em_Execucao
from Ordem_Servico os
inner join Mecanico m on os.idOrdMecanico = m.idMecanico
where os.Status = 'Em Execução'
group by m.Nome, m.Especialidade
having COUNT(os.idOrdem_de_Servico) > 1
order by m.Nome;

-- Qual peça foi utilizado nas OSs finalizadas.
select os.idOrdem_de_Servico as ordem_servico, os.data_entrega, p.Descricao_peca as Nome_peca
from ordem_servico os
inner join os_peca pos on os.idOrdem_de_Servico = pos.idOsPeca_Peca
inner join pecas p on pos.idOsPeca_Peca = p.idpeca 
where 
os.status = 'Finalizado';


                            
                            
                         








