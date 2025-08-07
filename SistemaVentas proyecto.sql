create database SistemaVentas

use SistemaVentas

create table proveedor(
id int not null identity(1,1) primary key,
nombre varchar(30),
marca varchar(30),
telefono varchar(10) not null
)

create table producto(
id int not null identity(1,1) primary key,
nombre varchar(30),
precio float not null check(precio>0),
stock int not null check(stock>=0),
proveedor int,
constraint fk_pp foreign key (proveedor) references proveedor(id)
)

create procedure altaproducto
@nombre varchar(30),
@precio float,
@stock int,
@proveedor int,
@respuesta varchar(80) output
as
insert into producto(nombre,precio,stock,proveedor) values(@nombre,@precio,@stock,@proveedor)
if @@ERROR=0
begin
 print 'No se pudo almacenar'
set @respuesta='No almacenado'
 end
 else 
print 'Producto almacenado'
set @respuesta='Producto almacenado'
go

create table cliente(
id int not null identity(1,1) primary key,
nombre varchar(30),
apaterno varchar(15),
amaterno varchar(15),
telefono varchar(10) unique not null,
usuario varchar(12) unique not null,
correo varchar(30) unique,
password varchar(50) unique
)

create table nota(
folio int not null identity(1,1),
clave_prod int not null,
cantidad int,
subtotal float,
fecha date,
constraint fk_pn foreign key (clave_prod) references producto(id),
constraint pk_nota primary key (folio,clave_prod)
)

create procedure agregarventa
@clave_prod int,
@cantidad int,
@subtotal float,
@respuesta varchar(120) output
as
declare @idventa int
begin tran
insert into nota(clave_prod,cantidad,subtotal,fecha) values(@clave_prod,@cantidad,@subtotal,GETDATE())
UPDATE producto set stock=stock-@cantidad where id=@clave_prod
if(@@ERROR<>0)
begin
print 'Error al guardar venta'
set @respuesta = 'Error al guardar venta'
rollback tran
end
else
begin
print 'Venta almacenada'
set @respuesta='Venta almacenada'
commit tran
end 
go

create table empleados(
id int not null identity(1,1) primary key,
nombre varchar(15),
apaterno varchar(15),
amaterno varchar(15),
telefono varchar(10) unique not null,
puesto int not null check(puesto=1 or puesto=2),
usuario varchar(12) unique not null,
correo varchar(30) unique,
password varchar(50)
)


