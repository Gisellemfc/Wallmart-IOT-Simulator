

	-------------------------------------------------------------------------------

					--             		 PROYECTO 1                      --
					-- ALumnas: Nicole Brito. Carnet: 20181110056 		 --
					--			Giselle Ferreira. Carnet: 20181110399	 --

	---------------------------------------------------------------------------------


                        -- DATA MAESTRA DE LA BASE DE DATOS DEL PROYECTO --



--Reiniciar la base de datos
delete from cliente;
delete from sucursal;
delete from producto;
delete from categoria;
delete from costo;
delete from estante;
delete from carrito;
delete from categoria_producto;
delete from factura;
delete from mensaje;
delete from visita;

--Ingresando Clientes
insert into cliente (id, afiliado, puntos) values (1, false, 0);
insert into cliente (id, afiliado, puntos) values (2, true, 0);
insert into cliente (id, afiliado, puntos) values (3, false, 0);
insert into cliente (id, afiliado, puntos) values (4, false, 0);
insert into cliente (id, afiliado, puntos) values (5, false, 0);
insert into cliente (id, afiliado, puntos) values (6, false, 0);
insert into cliente (id, afiliado, puntos) values (7, true, 0);
insert into cliente (id, afiliado, puntos) values (8, true, 0);
insert into cliente (id, afiliado, puntos) values (9, false, 0);
insert into cliente (id, afiliado, puntos) values (10, true, 0);

--Ingresando Sucursales
insert into sucursal (id, nombre, ubicacion, apertura, cierre, maximo_clientes, inventario) values (1, 'Wallmart La Castellana', 'La Castellana', '09:00:00', '20:00:00', 20, 10000);
insert into sucursal (id, nombre, ubicacion, apertura, cierre, maximo_clientes, inventario) values (2, 'Wallmart El Hatillo', 'El Hatillo', '09:00:00', '20:00:00', 20, 10000);

--Ingresando Productos
insert into producto (id, nombre) values (1, 'Oven Roast Breast');
insert into producto (id, nombre) values (2, 'Kiwi');
insert into producto (id, nombre) values (3, 'Watermelon, Seedless');
insert into producto (id, nombre) values (4, 'Cabbage Red');
insert into producto (id, nombre) values (5, 'Cookie Double Choco');
insert into producto (id, nombre) values (6, 'Chicken');
insert into producto (id, nombre) values (7, 'Star Fruit');
insert into producto (id, nombre) values (8, 'Toilet Paper');
insert into producto (id, nombre) values (9, 'Cream Of Campbells');
insert into producto (id, nombre) values (10, 'V8 Pet');
insert into producto (id, nombre) values (11, 'Allspice - Jamaican');
insert into producto (id, nombre) values (12, 'Cheese - Blue');
insert into producto (id, nombre) values (13, 'Coffee - Frthy Coffee Crisp');
insert into producto (id, nombre) values (14, 'Frangelico');
insert into producto (id, nombre) values (15, 'Shrimp');
insert into producto (id, nombre) values (16, 'Bulgar');
insert into producto (id, nombre) values (17, 'Bread Bowl Plain');
insert into producto (id, nombre) values (18, 'Wine - Rhine Riesling Wolf Blass');
insert into producto (id, nombre) values (19, 'Bacardi Limon');
insert into producto (id, nombre) values (20, 'Chocolate - Semi Sweet, Calets');
insert into producto (id, nombre) values (21, 'Yogurt - Banana, 175 Gr');
insert into producto (id, nombre) values (22, 'Sprouts - Brussel');
insert into producto (id, nombre) values (23, 'Sauce - Black Current, Dry Mix');
insert into producto (id, nombre) values (24, 'Oil - Sunflower');
insert into producto (id, nombre) values (25, 'Beef - Top Butt Aaa');
insert into producto (id, nombre) values (26, 'Soup Campbells');
insert into producto (id, nombre) values (27, 'Veal - Round, Eye Of');
insert into producto (id, nombre) values (28, 'Iced Tea - Lemon, 460 Ml');
insert into producto (id, nombre) values (29, 'Flax Seed');
insert into producto (id, nombre) values (30, 'Nantuket Peach Orange');
insert into producto (id, nombre) values (31, 'Fond - Chocolate');
insert into producto (id, nombre) values (32, 'Sauce - Black Current, Dry Mix');
insert into producto (id, nombre) values (33, 'Seabream Whole Farmed');
insert into producto (id, nombre) values (34, 'Yams');
insert into producto (id, nombre) values (35, 'Raspberries - Frozen');
insert into producto (id, nombre) values (36, 'Pork - Backs - Boneless');
insert into producto (id, nombre) values (37, 'Wine - Chateau Aqueria Tavel');
insert into producto (id, nombre) values (38, 'Veal - Inside Round / Top, Lean');
insert into producto (id, nombre) values (39, 'Pork - Back, Long Cut, Boneless');
insert into producto (id, nombre) values (40, 'Isomalt');
insert into producto (id, nombre) values (41, 'Pop Shoppe Cream Soda');
insert into producto (id, nombre) values (42, 'Mushroom - King Eryingii');
insert into producto (id, nombre) values (43, 'Magnotta - Bel Paese White');
insert into producto (id, nombre) values (44, 'Smoked Paprika');
insert into producto (id, nombre) values (45, 'Sobe - Liz Blizz');
insert into producto (id, nombre) values (46, 'Carbonated Water - White Grape');
insert into producto (id, nombre) values (47, 'Spoon - Soup, Plastic');
insert into producto (id, nombre) values (48, 'Sea Bass - Fillets');
insert into producto (id, nombre) values (49, 'Plastic Table Cloth 62x120 Colour');
insert into producto (id, nombre) values (50, 'Tea - Camomele');

--Ingresando Categorias
insert into categoria (id, nombre) values (1, 'Charcuterie');
insert into categoria (id, nombre) values (2, 'Fruit');
insert into categoria (id, nombre) values (3, 'Vegetable');
insert into categoria (id, nombre) values (4, 'Dessert');
insert into categoria (id, nombre) values (5, 'Meat');
insert into categoria (id, nombre) values (6, 'Hygiene');
insert into categoria (id, nombre) values (7, 'Soup');
insert into categoria (id, nombre) values (8, 'Pets');
insert into categoria (id, nombre) values (9, 'Condiment');
insert into categoria (id, nombre) values (10, 'Drink');
insert into categoria (id, nombre) values (11, 'Alcoholic'); 
insert into categoria (id, nombre) values (12, 'Sea food'); 
insert into categoria (id, nombre) values (13, 'Grain'); 
insert into categoria (id, nombre) values (14, 'Bakery'); 
insert into categoria (id, nombre) values (15, 'Frozen'); 
insert into categoria (id, nombre) values (16, 'Plastic'); 

--Ingresando Categoria-Producto
insert into categoria_producto (id_producto, id_categoria) values (1, 1);
insert into categoria_producto (id_producto, id_categoria) values (1, 5);
insert into categoria_producto (id_producto, id_categoria) values (2, 2);
insert into categoria_producto (id_producto, id_categoria) values (3, 2);
insert into categoria_producto (id_producto, id_categoria) values (4, 3);
insert into categoria_producto (id_producto, id_categoria) values (5, 4);
insert into categoria_producto (id_producto, id_categoria) values (5, 14);
insert into categoria_producto (id_producto, id_categoria) values (6, 1);
insert into categoria_producto (id_producto, id_categoria) values (6, 5);
insert into categoria_producto (id_producto, id_categoria) values (7, 2);
insert into categoria_producto (id_producto, id_categoria) values (8, 6);
insert into categoria_producto (id_producto, id_categoria) values (9, 7);
insert into categoria_producto (id_producto, id_categoria) values (10, 8);
insert into categoria_producto (id_producto, id_categoria) values (11, 9);
insert into categoria_producto (id_producto, id_categoria) values (12, 1);
insert into categoria_producto (id_producto, id_categoria) values (13, 10);
insert into categoria_producto (id_producto, id_categoria) values (14, 10);
insert into categoria_producto (id_producto, id_categoria) values (14, 11);
insert into categoria_producto (id_producto, id_categoria) values (15, 5);
insert into categoria_producto (id_producto, id_categoria) values (15, 12);
insert into categoria_producto (id_producto, id_categoria) values (16, 13);
insert into categoria_producto (id_producto, id_categoria) values (17, 14);
insert into categoria_producto (id_producto, id_categoria) values (18, 10);
insert into categoria_producto (id_producto, id_categoria) values (18, 11);
insert into categoria_producto (id_producto, id_categoria) values (19, 10);
insert into categoria_producto (id_producto, id_categoria) values (19, 11);
insert into categoria_producto (id_producto, id_categoria) values (20, 4);
insert into categoria_producto (id_producto, id_categoria) values (21, 4);
insert into categoria_producto (id_producto, id_categoria) values (21, 10);
insert into categoria_producto (id_producto, id_categoria) values (22, 3);
insert into categoria_producto (id_producto, id_categoria) values (23, 9);
insert into categoria_producto (id_producto, id_categoria) values (24, 9);
insert into categoria_producto (id_producto, id_categoria) values (25, 5);
insert into categoria_producto (id_producto, id_categoria) values (25, 1);
insert into categoria_producto (id_producto, id_categoria) values (26, 7);
insert into categoria_producto (id_producto, id_categoria) values (27, 5);
insert into categoria_producto (id_producto, id_categoria) values (27, 1);
insert into categoria_producto (id_producto, id_categoria) values (28, 10);
insert into categoria_producto (id_producto, id_categoria) values (29, 13);
insert into categoria_producto (id_producto, id_categoria) values (30, 10);
insert into categoria_producto (id_producto, id_categoria) values (30, 2);
insert into categoria_producto (id_producto, id_categoria) values (31, 4);
insert into categoria_producto (id_producto, id_categoria) values (32, 9);
insert into categoria_producto (id_producto, id_categoria) values (33, 5);
insert into categoria_producto (id_producto, id_categoria) values (33, 12);
insert into categoria_producto (id_producto, id_categoria) values (34, 3);
insert into categoria_producto (id_producto, id_categoria) values (35, 2);
insert into categoria_producto (id_producto, id_categoria) values (35, 15);
insert into categoria_producto (id_producto, id_categoria) values (36, 5);
insert into categoria_producto (id_producto, id_categoria) values (36, 1);
insert into categoria_producto (id_producto, id_categoria) values (37, 10);
insert into categoria_producto (id_producto, id_categoria) values (37, 11);
insert into categoria_producto (id_producto, id_categoria) values (38, 5);
insert into categoria_producto (id_producto, id_categoria) values (38, 1);
insert into categoria_producto (id_producto, id_categoria) values (39, 5);
insert into categoria_producto (id_producto, id_categoria) values (39, 1);
insert into categoria_producto (id_producto, id_categoria) values (40, 4);
insert into categoria_producto (id_producto, id_categoria) values (41, 10);
insert into categoria_producto (id_producto, id_categoria) values (42, 3);
insert into categoria_producto (id_producto, id_categoria) values (43, 10);
insert into categoria_producto (id_producto, id_categoria) values (43, 11);
insert into categoria_producto (id_producto, id_categoria) values (44, 9);
insert into categoria_producto (id_producto, id_categoria) values (45, 10);
insert into categoria_producto (id_producto, id_categoria) values (45, 11);
insert into categoria_producto (id_producto, id_categoria) values (46, 10);
insert into categoria_producto (id_producto, id_categoria) values (47, 16);
insert into categoria_producto (id_producto, id_categoria) values (48, 5);
insert into categoria_producto (id_producto, id_categoria) values (48, 12);
insert into categoria_producto (id_producto, id_categoria) values (49, 16);
insert into categoria_producto (id_producto, id_categoria) values (50, 10);

--Ingresando Costo
insert into costo (id, costo, fecha, id_producto) values (1, 38.42, '2021-05-24 04:11:20', 1);
insert into costo (id, costo, fecha, id_producto) values (2, 83.69, '2021-05-26 19:45:23', 2);
insert into costo (id, costo, fecha, id_producto) values (3, 49.29, '2021-05-29 15:03:15', 3);
insert into costo (id, costo, fecha, id_producto) values (4, 34.85, '2021-05-28 05:18:24', 4);
insert into costo (id, costo, fecha, id_producto) values (5, 89.02, '2021-05-22 14:13:10', 5);
insert into costo (id, costo, fecha, id_producto) values (6, 23.33, '2021-05-29 23:09:24', 6);
insert into costo (id, costo, fecha, id_producto) values (7, 15.02, '2021-05-22 13:25:42', 7);
insert into costo (id, costo, fecha, id_producto) values (8, 19.5, '2021-05-20 17:23:51', 8);
insert into costo (id, costo, fecha, id_producto) values (9, 82.24, '2021-05-25 14:40:50', 9);
insert into costo (id, costo, fecha, id_producto) values (10, 65.02, '2021-05-21 11:31:46', 10);
insert into costo (id, costo, fecha, id_producto) values (11, 76.92, '2021-05-24 00:12:57', 11);
insert into costo (id, costo, fecha, id_producto) values (12, 84.43, '2021-05-23 18:07:31', 12);
insert into costo (id, costo, fecha, id_producto) values (13, 28.75, '2021-05-25 17:02:28', 13);
insert into costo (id, costo, fecha, id_producto) values (14, 29.19, '2021-05-24 15:55:35', 14);
insert into costo (id, costo, fecha, id_producto) values (15, 34.76, '2021-05-23 13:51:38', 15);
insert into costo (id, costo, fecha, id_producto) values (16, 28.31, '2021-05-28 02:35:31', 16);
insert into costo (id, costo, fecha, id_producto) values (17, 54.27, '2021-05-20 17:11:25', 17);
insert into costo (id, costo, fecha, id_producto) values (18, 87.38, '2021-05-26 13:22:23', 18);
insert into costo (id, costo, fecha, id_producto) values (19, 36.16, '2021-05-23 13:35:00', 19);
insert into costo (id, costo, fecha, id_producto) values (20, 59.1, '2021-05-21 21:12:50', 20);
insert into costo (id, costo, fecha, id_producto) values (21, 1.42, '2021-05-21 05:46:11', 21);
insert into costo (id, costo, fecha, id_producto) values (22, 32.57, '2021-05-24 11:52:00', 22);
insert into costo (id, costo, fecha, id_producto) values (23, 92.92, '2021-05-20 09:41:59', 23);
insert into costo (id, costo, fecha, id_producto) values (24, 86.03, '2021-05-21 20:41:53', 24);
insert into costo (id, costo, fecha, id_producto) values (25, 55.07, '2021-05-22 08:00:37', 25);
insert into costo (id, costo, fecha, id_producto) values (26, 22.89, '2021-05-23 12:31:19', 26);
insert into costo (id, costo, fecha, id_producto) values (27, 22.25, '2021-05-20 10:34:54', 27);
insert into costo (id, costo, fecha, id_producto) values (28, 30.63, '2021-05-20 19:46:34', 28);
insert into costo (id, costo, fecha, id_producto) values (29, 34.49, '2021-05-23 14:51:22', 29);
insert into costo (id, costo, fecha, id_producto) values (30, 13.0, '2021-05-21 22:40:39', 30);
insert into costo (id, costo, fecha, id_producto) values (31, 45.27, '2021-05-28 13:52:13', 31);
insert into costo (id, costo, fecha, id_producto) values (32, 97.98, '2021-05-28 11:57:27', 32);
insert into costo (id, costo, fecha, id_producto) values (33, 68.27, '2021-05-26 08:47:09', 33);
insert into costo (id, costo, fecha, id_producto) values (34, 86.44, '2021-05-24 22:46:02', 34);
insert into costo (id, costo, fecha, id_producto) values (35, 44.01, '2021-05-25 22:13:35', 35);
insert into costo (id, costo, fecha, id_producto) values (36, 87.36, '2021-05-29 16:21:35', 36);
insert into costo (id, costo, fecha, id_producto) values (37, 3.59, '2021-05-21 07:01:22', 37);
insert into costo (id, costo, fecha, id_producto) values (38, 9.37, '2021-05-25 07:17:12', 38);
insert into costo (id, costo, fecha, id_producto) values (39, 48.61, '2021-05-23 09:55:28', 39);
insert into costo (id, costo, fecha, id_producto) values (40, 66.49, '2021-05-29 14:06:04', 40);
insert into costo (id, costo, fecha, id_producto) values (41, 65.44, '2021-05-25 16:54:03', 41);
insert into costo (id, costo, fecha, id_producto) values (42, 16.75, '2021-05-27 14:15:23', 42);
insert into costo (id, costo, fecha, id_producto) values (43, 23.78, '2021-05-20 02:21:34', 43);
insert into costo (id, costo, fecha, id_producto) values (44, 94.89, '2021-05-20 09:25:17', 44);
insert into costo (id, costo, fecha, id_producto) values (45, 32.3, '2021-05-25 12:37:21', 45);
insert into costo (id, costo, fecha, id_producto) values (46, 12.24, '2021-05-27 00:12:21', 46);
insert into costo (id, costo, fecha, id_producto) values (47, 22.31, '2021-05-23 03:11:51', 47);
insert into costo (id, costo, fecha, id_producto) values (48, 3.67, '2021-05-22 23:59:02', 48);
insert into costo (id, costo, fecha, id_producto) values (49, 7.53, '2021-05-30 08:09:54', 49);
insert into costo (id, costo, fecha, id_producto) values (50, 63.52, '2021-05-20 01:56:44', 50);
insert into costo (id, costo, fecha, id_producto) values (51, 63.61, '2021-06-01 04:12:36', 1);
insert into costo (id, costo, fecha, id_producto) values (52, 57.06, '2021-06-04 05:03:38', 2);
insert into costo (id, costo, fecha, id_producto) values (53, 50.55, '2021-06-01 08:47:35', 3);
insert into costo (id, costo, fecha, id_producto) values (54, 50.71, '2021-06-06 12:04:11', 4);
insert into costo (id, costo, fecha, id_producto) values (55, 4.78, '2021-06-01 23:38:26', 5);
insert into costo (id, costo, fecha, id_producto) values (56, 97.81, '2021-06-05 07:31:40', 6);
insert into costo (id, costo, fecha, id_producto) values (57, 30.94, '2021-06-05 19:42:38', 7);
insert into costo (id, costo, fecha, id_producto) values (58, 60.09, '2021-06-04 14:06:57', 8);
insert into costo (id, costo, fecha, id_producto) values (59, 69.02, '2021-06-03 01:42:54', 9);
insert into costo (id, costo, fecha, id_producto) values (60, 97.4, '2021-06-01 07:34:05', 10);
insert into costo (id, costo, fecha, id_producto) values (61, 50.83, '2021-06-03 11:33:26', 11);
insert into costo (id, costo, fecha, id_producto) values (62, 12.87, '2021-06-04 05:16:22', 12);
insert into costo (id, costo, fecha, id_producto) values (63, 37.11, '2021-06-02 21:23:19', 13);
insert into costo (id, costo, fecha, id_producto) values (64, 5.78, '2021-06-02 11:53:49', 14);
insert into costo (id, costo, fecha, id_producto) values (65, 13.6, '2021-06-06 16:11:24', 15);
insert into costo (id, costo, fecha, id_producto) values (66, 17.91, '2021-06-05 05:52:06', 16);
insert into costo (id, costo, fecha, id_producto) values (67, 64.54, '2021-06-03 09:02:26', 17);
insert into costo (id, costo, fecha, id_producto) values (68, 48.57, '2021-06-06 18:57:24', 18);
insert into costo (id, costo, fecha, id_producto) values (69, 79.63, '2021-06-02 02:46:46', 19);
insert into costo (id, costo, fecha, id_producto) values (70, 40.42, '2021-06-05 07:03:41', 20);
insert into costo (id, costo, fecha, id_producto) values (71, 18.44, '2021-06-05 05:50:21', 21);
insert into costo (id, costo, fecha, id_producto) values (72, 17.71, '2021-06-04 19:43:24', 22);
insert into costo (id, costo, fecha, id_producto) values (73, 78.26, '2021-06-01 16:44:14', 23);
insert into costo (id, costo, fecha, id_producto) values (74, 78.43, '2021-06-03 16:31:45', 24);
insert into costo (id, costo, fecha, id_producto) values (75, 20.13, '2021-06-05 22:01:29', 25);
insert into costo (id, costo, fecha, id_producto) values (76, 23.55, '2021-06-04 15:10:26', 26);
insert into costo (id, costo, fecha, id_producto) values (77, 67.24, '2021-06-01 13:06:27', 27);
insert into costo (id, costo, fecha, id_producto) values (78, 22.71, '2021-06-03 02:39:28', 28);
insert into costo (id, costo, fecha, id_producto) values (79, 16.26, '2021-06-04 18:47:11', 29);
insert into costo (id, costo, fecha, id_producto) values (80, 32.36, '2021-06-05 04:13:52', 30);
insert into costo (id, costo, fecha, id_producto) values (81, 15.44, '2021-06-04 08:42:32', 31);
insert into costo (id, costo, fecha, id_producto) values (82, 8.68, '2021-06-04 19:54:52', 32);
insert into costo (id, costo, fecha, id_producto) values (83, 6.85, '2021-06-02 19:46:03', 33);
insert into costo (id, costo, fecha, id_producto) values (84, 15.74, '2021-06-04 19:06:28', 34);
insert into costo (id, costo, fecha, id_producto) values (85, 69.43, '2021-06-04 04:43:25', 35);
insert into costo (id, costo, fecha, id_producto) values (86, 3.1, '2021-06-04 12:50:51', 36);
insert into costo (id, costo, fecha, id_producto) values (87, 32.82, '2021-06-01 23:17:12', 37);
insert into costo (id, costo, fecha, id_producto) values (88, 57.26, '2021-06-02 11:07:28', 38);
insert into costo (id, costo, fecha, id_producto) values (89, 97.44, '2021-06-01 02:20:46', 39);
insert into costo (id, costo, fecha, id_producto) values (90, 24.4, '2021-06-05 17:22:45', 40);
insert into costo (id, costo, fecha, id_producto) values (91, 44.27, '2021-06-06 05:07:20', 41);
insert into costo (id, costo, fecha, id_producto) values (92, 74.86, '2021-06-04 01:45:11', 42);
insert into costo (id, costo, fecha, id_producto) values (93, 18.48, '2021-06-03 23:55:11', 43);
insert into costo (id, costo, fecha, id_producto) values (94, 61.16, '2021-06-01 17:07:59', 44);
insert into costo (id, costo, fecha, id_producto) values (95, 13.14, '2021-06-05 06:14:01', 45);
insert into costo (id, costo, fecha, id_producto) values (96, 29.11, '2021-06-05 09:03:02', 46);
insert into costo (id, costo, fecha, id_producto) values (97, 70.26, '2021-06-02 16:50:42', 47);
insert into costo (id, costo, fecha, id_producto) values (98, 3.87, '2021-06-01 23:31:34', 48);
insert into costo (id, costo, fecha, id_producto) values (99, 87.87, '2021-06-05 05:01:21', 49);
insert into costo (id, costo, fecha, id_producto) values (100, 91.66, '2021-06-04 06:03:23', 50);

--Ingresando Estante
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (1, 780, 100, 0, 1, 1);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (2, 932, 100, 0, 1, 2);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (3, 801, 100, 0, 1, 3);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (4, 657, 100, 0, 1, 4);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (5, 715, 100, 0, 1, 5);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (6, 813, 100, 0, 1, 6);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (7, 182, 100, 0, 1, 7);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (8, 224, 100, 0, 1, 8);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (9, 181, 100, 0, 1, 9);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (10, 461, 100, 0, 1, 10);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (11, 109, 100, 0, 1, 11);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (12, 512, 100, 0, 1, 12);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (13, 853, 100, 0, 1, 13);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (14, 197, 100, 0, 1, 14);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (15, 496, 100, 0, 1, 15);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (16, 832, 100, 0, 1, 16);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (17, 738, 100, 0, 1, 17);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (18, 803, 100, 0, 1, 18);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (19, 803, 100, 0, 1, 19);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (20, 764, 100, 0, 1, 20);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (21, 584, 100, 0, 1, 21);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (22, 859, 100, 0, 1, 22);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (23, 435, 100, 0, 1, 23);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (24, 442, 100, 0, 1, 24);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (25, 146, 100, 0, 1, 25);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (26, 863, 100, 0, 1, 26);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (27, 658, 100, 0, 1, 27);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (28, 800, 100, 0, 1, 28);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (29, 101, 100, 0, 1, 29);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (30, 493, 100, 0, 1, 30);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (31, 426, 100, 0, 1, 31);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (32, 387, 100, 0, 1, 32);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (33, 380, 100, 0, 1, 33);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (34, 338, 100, 0, 1, 34);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (35, 671, 100, 0, 1, 35);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (36, 432, 100, 0, 1, 36);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (37, 499, 100, 0, 1, 37);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (38, 977, 100, 0, 1, 38);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (39, 370, 100, 0, 1, 39);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (40, 112, 100, 0, 1, 40);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (41, 871, 100, 0, 1, 41);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (42, 978, 100, 0, 1, 42);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (43, 245, 100, 0, 1, 43);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (44, 115, 100, 0, 1, 44);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (45, 275, 100, 0, 1, 45);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (46, 398, 100, 0, 1, 46);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (47, 538, 100, 0, 1, 47);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (48, 608, 100, 0, 1, 48);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (49, 300, 100, 0, 1, 49);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (50, 763, 100, 0, 1, 50);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (51, 780, 100, 0, 2, 1);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (52, 932, 100, 0, 2, 2);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (53, 801, 100, 0, 2, 3);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (54, 657, 100, 0, 2, 4);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (55, 715, 100, 0, 2, 5);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (56, 813, 100, 0, 2, 6);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (57, 182, 100, 0, 2, 7);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (58, 224, 100, 0, 2, 8);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (59, 181, 100, 0, 2, 9);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (60, 461, 100, 0, 2, 10);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (61, 109, 100, 0, 2, 11);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (62, 512, 100, 0, 2, 12);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (63, 853, 100, 0, 2, 13);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (64, 197, 100, 0, 2, 14);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (65, 496, 100, 0, 2, 15);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (66, 832, 100, 0, 2, 16);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (67, 738, 100, 0, 2, 17);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (68, 803, 100, 0, 2, 18);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (69, 803, 100, 0, 2, 19);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (70, 764, 100, 0, 2, 20);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (71, 584, 100, 0, 2, 21);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (72, 859, 100, 0, 2, 22);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (73, 435, 100, 0, 2, 23);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (74, 442, 100, 0, 2, 24);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (75, 146, 100, 0, 2, 25);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (76, 863, 100, 0, 2, 26);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (77, 658, 100, 0, 2, 27);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (78, 800, 100, 0, 2, 28);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (79, 101, 100, 0, 2, 29);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (80, 493, 100, 0, 2, 30);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (81, 426, 100, 0, 2, 31);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (82, 387, 100, 0, 2, 32);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (83, 380, 100, 0, 2, 33);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (84, 338, 100, 0, 2, 34);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (85, 671, 100, 0, 2, 35);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (86, 432, 100, 0, 2, 36);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (87, 499, 100, 0, 2, 37);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (88, 977, 100, 0, 2, 38);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (89, 370, 100, 0, 2, 39);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (90, 112, 100, 0, 2, 40);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (91, 871, 100, 0, 2, 41);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (92, 978, 100, 0, 2, 42);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (93, 245, 100, 0, 2, 43);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (94, 115, 100, 0, 2, 44);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (95, 275, 100, 0, 2, 45);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (96, 398, 100, 0, 2, 46);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (97, 538, 100, 0, 2, 47);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (98, 608, 100, 0, 2, 48);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (99, 300, 100, 0, 2, 49);
insert into estante (id, capacidad, disponible, veces_rellenado, id_sucursal, id_producto) values (100, 763, 100, 0, 2, 50);
