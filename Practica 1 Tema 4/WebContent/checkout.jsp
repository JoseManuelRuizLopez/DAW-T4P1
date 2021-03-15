<%-- Página de confirmación del pedido --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"
	import="java.util.*, es.studium.PoolConexiones.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<title>Confirmación</title>
</head>
<body>
	<div class="container mt-4">
		<div class="row">
			<div class="col-8 text">

				<h1>Librería MVC: Confirmación</h1>
				<hr />
				<br />
				<p>
					<strong>Has comprado los siguientes libros:</strong>
				</p>
				<table class=" table table-hover table-striped mt-4">
					<thead class="bg-secondary text-white">
						<tr>
							<th>Título</th>
							<th>Precio</th>
							<th>Cantidad</th>
						</tr>
					</thead>
					<%@ page import="java.sql.*"%>
					<%@ page import="java.time.LocalDateTime"%>
					<%@ page import="javax.servlet.http.HttpSession "%>

					<%
						String idUsuario = session.getAttribute("idUsuario").toString();
						LocalDateTime fechaPedido = LocalDateTime.now();
						String valores = "'" + fechaPedido + "', " + idUsuario;
						String idPedido;

						es.studium.PoolConexiones.Conexiones.doInsert(" fechaPedido, idUsuarioFK ", "pedidos", valores);
						ResultSet rsetPedido = es.studium.PoolConexiones.Conexiones.doSelect("*",
								"pedidos ORDER BY idPedido desc ");
						rsetPedido.next();
						idPedido = rsetPedido.getString("idPedido");

						// Muestra los elementos del carrito
						ArrayList<ElementoPedido> cesta = (ArrayList<ElementoPedido>) session.getAttribute("carrito");
						for (ElementoPedido item : cesta) {

							String valoresIncluyen = idPedido + ", " + item.getIdLibro() + ", " + item.getCantidad();
							System.out.println(valoresIncluyen);
							es.studium.PoolConexiones.Conexiones.doInsert("idPedidoFK, idLibroFK, cantidad", "tienen",
									valoresIncluyen);
					%>
					<tr>
						<td><%=item.getTitulo()%></td>
						<td><%=item.getPrecio()%> €</td>
						<td><%=item.getCantidad()%></td>
					</tr>
					<%
						}
						session.invalidate();
					%>
					<tr>
					</tr>
				</table>
				<th>Precio Total: <%=request.getAttribute("precioTotal")%></th><br/>
				<th>Cantidad Total: <%=request.getAttribute("cantidadTotal")%></th> <br /> <a
					href="shopping">Pulsa aquí para realizar otro pedido</a>
			</div>
		</div>
	</div>
</body>
</html>