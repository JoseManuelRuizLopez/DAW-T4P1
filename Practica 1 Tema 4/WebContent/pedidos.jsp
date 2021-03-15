<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<title>Modificación Libro</title>
</head>
<body>
	<div class="container mt-4">
		<div class="row">
			<div class="col-8 text">

				<h2>Administrador</h2>

				<a href="altaLibro.jsp"><button class="btn btn-info">Alta
						Libro</button></a> <a href="modificarLibro.jsp"><button
						class="btn btn-info">Modificación Libro</button></a> <a
					href="autores.jsp"><button class="btn btn-info">Autores</button></a>
				<a href="editoriales.jsp"><button class="btn btn-info">Editoriales</button></a>
				<a href="pedidos.jsp"><button class="btn btn-info">Pedidos</button></a>
				<a href="index.html"><button class="btn btn-danger">LOGOUT</button></a>

				<table class=" table table-hover table-striped mt-4">
					<thead class="bg-secondary text-white">
						<tr>
							<td>Fecha del pedido</td>
							<td>Fecha de Envio</td>
							<td>Usuario</td>
							<td></td>
						</tr>
					</thead>
					<tbody>
						<%@ page import="java.sql.*"%>
						<%
							ResultSet rs = es.studium.PoolConexiones.Conexiones.doSelect("*",
									"pedidos, usuarios where idUsuarioFK = idUsuario");
							while (rs.next()) {
						%>
						<tr>
							<td><%=rs.getString("fechaPedido")%></td>
							<td><%=rs.getString("fechaEnvioPedido")%></td>
							<td><%=rs.getString("nombreUsuario")%></td>
							<td><a
								href="detallesPedidos.jsp?idPedido=<%=rs.getString("idPedido")%>">Detalles</a></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>

				<a href="administrador.jsp"><button class="btn btn-primary">Volver</button></a>
			</div>
		</div>
	</div>
</body>
</html>