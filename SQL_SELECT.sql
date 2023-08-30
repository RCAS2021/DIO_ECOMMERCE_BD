-- Visualizar clientes
select * from Cliente;

-- Visualizar Produtos
select * from Produto;

-- Visualizar Pedidos
select * from Pedido;

-- Quantos pedidos foram feitos
select count(*) from Pedido;

-- Quantos pedidos estão em aberto
select count(*) from Pedido, Relação_Produto_Pedido where  Relação_Produto_Pedido.pedido_id_pedido = Pedido.id_pedido and Pedido.status = 'Em andamento';

-- Quais pedidos estão em aberto
select * from Pedido, Relação_Produto_Pedido where  Relação_Produto_Pedido.pedido_id_pedido = Pedido.id_pedido and Pedido.status = 'Em andamento';

-- Quantos pedidos estão a caminho
select count(*) from Pedido, Relação_Produto_Pedido where  Relação_Produto_Pedido.pedido_id_pedido = Pedido.id_pedido and Pedido.status = 'Enviado';

-- Quais pedidos estão a caminho
select * from Pedido, Relação_Produto_Pedido where  Relação_Produto_Pedido.pedido_id_pedido = Pedido.id_pedido and Pedido.status = 'Enviado';

-- Quais produtos estão em estoque, por categoria
select * from Produto, Produto_has_Estoque where Produto.id_produto = Produto_has_Estoque.produto_id_produto order by Produto.categoria;

-- Quantos produtos de uma categoria estão disponíveis
select categoria, count(*) from Produto, Produto_has_Estoque where Produto.id_produto = Produto_has_Estoque.produto_id_produto group by Produto.categoria;

-- Quantos pedidos foram feitos por um cliente
select Cliente.*, count(*) from Pedido, Cliente where Pedido.cliente_id_cliente = Cliente.id_cliente and Cliente.id_cliente = 1;

-- Quantos pedidos foram feitos por clientes agrupados / quais clientes fizeram pedidos
select Cliente.*, count(*) from Pedido, Cliente where Pedido.cliente_id_cliente = Cliente.id_cliente group by Cliente.id_cliente;

-- Selecionar clientes que fizeram mais de um pedido
select count(id_cliente), nome, id_cliente from Cliente, Pedido where cliente_id_cliente = id_cliente group by cliente_id_cliente having count(id_cliente) > 1;

-- Selecionar cliente que fizeram apenas um pedido
select count(id_cliente), nome, id_cliente from Cliente, Pedido where cliente_id_cliente = id_cliente group by cliente_id_cliente having count(id_cliente) = 1;

-- Informações dos pedidos dos clientes
select * from Cliente right join Pedido on id_cliente = cliente_id_cliente order by id_cliente;
select * from Cliente left join Pedido on id_cliente = cliente_id_cliente having id_pedido order by id_cliente;

-- Informações dos pedidos de um cliente + dados do cliente
select * from Cliente inner join Pedido on id_cliente = cliente_id_cliente where id_cliente = 1 order by id_cliente;