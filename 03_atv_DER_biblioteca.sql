CREATE DATABASE biblioteca;
USE biblioteca;

-- 1. TABELAS INDEPENDENTES (Entidades Fortes)

CREATE TABLE Categoria_Leitor (
    ID_CategoriaLeitor INT PRIMARY KEY,
    descricaoCategoria VARCHAR(100),
    numMaxDiasEmprestarCategoriaLeitor INT
);

CREATE TABLE Categoria_Obras (
    ID_Categoria INT PRIMARY KEY,
    Taxa_Multa DECIMAL(10, 2)
);

CREATE TABLE Funcionario (
    codigoFuncionario INT PRIMARY KEY,
    nomeFuncionario VARCHAR(100),
    enderecoFuncionario VARCHAR(200),
    cidadeFuncionario VARCHAR(100),
    estadoFuncionario CHAR(2),
    telefoneFuncionario VARCHAR(20),
    dataNascimentoFuncionario DATE
);

-- 2. TABELAS COM RELACIONAMENTOS 1:N

CREATE TABLE Leitor (
    ID_Leitor INT PRIMARY KEY,
    nomeLeitor VARCHAR(100),
    enderecoLeitor VARCHAR(200),
    cidadeLeitor VARCHAR(100),
    estadoLeitor CHAR(2),
    telefoneLeitor VARCHAR(20),
    emailLeitor VARCHAR(100),
    documentoIDLeitor VARCHAR(20),
    dataNascimentoLeitor DATE,
    ID_CategoriaLeitor INT, -- Relacionamento 'Pertence' (Categoria -> Leitor)
    FOREIGN KEY (ID_CategoriaLeitor) REFERENCES Categoria_Leitor(ID_CategoriaLeitor)
);

CREATE TABLE Obras (
    ID_Obra INT PRIMARY KEY,
    ISBNObra VARCHAR(20),
    tituloObra VARCHAR(150),
    autorObra VARCHAR(100), -- Simplificado (DER indica multivalorado 1,n)
    palavrasChaveObra VARCHAR(200),
    dataPublicacaoObra DATE,
    numeroEdicaoObra INT,
    editoraObra VARCHAR(100),
    numeroPaginasObra INT,
    ID_Categoria INT, -- Relacionamento 'Tem' (Categoria Obras -> Obras)
    FOREIGN KEY (ID_Categoria) REFERENCES Categoria_Obras(ID_Categoria)
);

-- 3. ENTIDADE FRACA (Exemplar depende de Obra)

CREATE TABLE Exemplar (
    ID_Exemplar INT,
    ID_Obra INT,
    PRIMARY KEY (ID_Exemplar, ID_Obra), -- Chave Composta
    FOREIGN KEY (ID_Obra) REFERENCES Obras(ID_Obra)
);

-- 4. RELACIONAMENTOS N:N E ENTIDADES ASSOCIATIVAS (Losangos Duplos)

CREATE TABLE Reserva (
    ID_Obra INT,
    ID_Leitor INT,
    codigoFuncionario INT,
    dataReserva DATE, -- Atributo implícito comum em reservas
    PRIMARY KEY (ID_Obra, ID_Leitor, codigoFuncionario),
    FOREIGN KEY (ID_Obra) REFERENCES Obras(ID_Obra),
    FOREIGN KEY (ID_Leitor) REFERENCES Leitor(ID_Leitor),
    FOREIGN KEY (codigoFuncionario) REFERENCES Funcionario(codigoFuncionario)
);

CREATE TABLE Emprestimo (
    ID_Emprestimo INT PRIMARY KEY,
    dataEmprestimo DATE,
    dataDevolucaoEmprestimo DATE,
    ID_Leitor INT,
    codigoFuncionario INT,
    ID_Exemplar INT,
    ID_Obra INT,
    FOREIGN KEY (ID_Leitor) REFERENCES Leitor(ID_Leitor),
    FOREIGN KEY (codigoFuncionario) REFERENCES Funcionario(codigoFuncionario),
    FOREIGN KEY (ID_Exemplar, ID_Obra) REFERENCES Exemplar(ID_Exemplar, ID_Obra)
);
