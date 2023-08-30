-- Criação do Banco de Dados E-Commerce
drop database ecommerce;
create database ecommerce;
use ecommerce;

create table Cliente(
		id_cliente INT AUTO_INCREMENT PRIMARY KEY,
		nome VARCHAR(45) NOT NULL,
		CPF CHAR(11) NOT NULL,
		estado VARCHAR(15) NOT NULL,
		cidade VARCHAR(30) NOT NULL,
		bairro VARCHAR(20) NOT NULL,
		rua VARCHAR(45) NOT NULL,
		complemento VARCHAR(20) NOT NULL,
		data_nascimento DATE NOT NULL,
		contato VARCHAR(20),
		CONSTRAINT unique_cpf_cliente UNIQUE(cpf),
		CONSTRAINT unique_nome_cliente UNIQUE(nome)
    );

create table Pedido(
		id_pedido INT AUTO_INCREMENT PRIMARY KEY,
        status ENUM('Em andamento', 'Enviado', 'Concluído') DEFAULT 'Em andamento',
        descrição VARCHAR(45) NOT NULL,
        cliente_id_cliente INT NOT NULL,
        valor_frete FLOAT NOT NULL,
        CONSTRAINT fk_pedido_cliente FOREIGN KEY Pedido(cliente_id_cliente) REFERENCES Cliente(id_cliente)
    );

create table Produto(
		id_produto INT AUTO_INCREMENT PRIMARY KEY,
        categoria VARCHAR(25) NOT NULL,
        descrição VARCHAR(45) NOT NULL,
        avaliação FLOAT DEFAULT 0,
        valor FLOAT NOT NULL,
        peso VARCHAR(15) NOT NULL
    );

create table Terceiro_Vendedor(
		id_terceiro_vendedor INT AUTO_INCREMENT PRIMARY KEY,
        razão_social VARCHAR(45) NOT NULL,
        estado VARCHAR(15) NOT NULL,
		cidade VARCHAR(30) NOT NULL,
		bairro VARCHAR(20) NOT NULL,
		rua VARCHAR(45) NOT NULL,
		complemento VARCHAR(20) NOT NULL,
        CONSTRAINT unique_razão_social_vendedor UNIQUE(razão_social)
	);
    
create table Fornecedor(
		id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
        razão_social VARCHAR(45) NOT NULL,
        CNPJ CHAR(18) NOT NULL,
        CONSTRAINT unique_razão_social_fornecedor UNIQUE(razão_social),
        CONSTRAINT unique_CNPJ_fornecedor UNIQUE(CNPJ)
	);
    
create table Estoque(
		id_estoque INT AUTO_INCREMENT PRIMARY KEY,
        estado VARCHAR(15) NOT NULL,
		cidade VARCHAR(30) NOT NULL,
		bairro VARCHAR(20) NOT NULL,
		rua VARCHAR(45) NOT NULL,
		complemento VARCHAR(20) NOT NULL
	);

create table Produto_has_Estoque(
		estoque_id_estoque INT,
        produto_id_produto INT,
        quantidade INT NOT NULL,
        status ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
        PRIMARY KEY(estoque_id_estoque, produto_id_produto),
        CONSTRAINT fk_produto_has_estoque_estoque FOREIGN KEY Produto_has_Estoque(estoque_id_estoque) REFERENCES Estoque(id_estoque),
        CONSTRAINT fk_produto_has_estoque_produto FOREIGN KEY Produto_has_estoque(produto_id_produto) REFERENCES Produto(id_produto)
    );

create table Disponibilizando_produto(
		fornecedor_id_fornecedor INT,
        produto_id_produto INT,
        quantidade INT NOT NULL,
        valor FLOAT NOT NULL,
        PRIMARY KEY(fornecedor_id_fornecedor, produto_id_produto),
        CONSTRAINT fk_disponibilizando_produto_fornecedor FOREIGN KEY Disponibilizando_produto(fornecedor_id_fornecedor) REFERENCES Fornecedor(id_fornecedor),
        CONSTRAINT fk_disponibilizando_produto_produto FOREIGN KEY Disponibilizando_produto(produto_id_produto) REFERENCES Produto(id_produto)
	);

create table Produtos_Vendedor(
		terceiro_vendedor_id_terceiro_vendedor INT,
        produto_id_produto INT,
        quantidade INT NOT NULL,
        PRIMARY KEY(terceiro_vendedor_id_terceiro_vendedor, produto_id_produto),
        CONSTRAINT fk_produtos_vendedor_terceiro_vendedor FOREIGN KEY Produtos_Vendedor(terceiro_vendedor_id_terceiro_vendedor) REFERENCES Terceiro_Vendedor(id_terceiro_vendedor),
        CONSTRAINT fk_produtos_vendedor_produto FOREIGN KEY Produtos_vendedor(produto_id_produto) REFERENCES Produto(id_produto)
	);

create table Relação_Produto_Pedido(
		produto_id_produto INT,
        pedido_id_pedido INT,
        quantidade INT NOT NULL,
        status ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
        PRIMARY KEY(produto_id_produto, pedido_id_pedido),
        CONSTRAINT fk_relação_produto_pedido_produto FOREIGN KEY Relação_Produto_Pedido(produto_id_produto) REFERENCES Produto(id_produto),
        CONSTRAINT fk_relação_produto_pedido_pedido FOREIGN KEY Relação_Produto_Pedido(pedido_id_pedido) REFERENCES Pedido(id_pedido)
    );