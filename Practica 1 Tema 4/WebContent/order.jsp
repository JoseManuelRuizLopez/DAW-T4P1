<%-- Página de órdenes de pedido --%>
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
<title>Pedido</title>
</head>
<body>
	<div class="container mt-4">
		<div class="row">
			<div class="col-8 text">
				<h1>Librería MVC</h1>
				<hr />
				<br />
				<p>
					<strong>Elegir un libro y la cantidad:</strong>
				</p>
				<form name="AgregarForm" action="shopping" method="POST">
					<input type="hidden" name="todo" value="add"> Título: <select
						name="idLibro">
						<%
							int tamanio = LibreriaMVC.tamano();
							System.out.println(LibreriaMVC.tamano());
							// Scriplet 1: Carga los libros en el SELECT
							for (int i = 0; i < tamanio; i++) {
								out.println("<option value='" + i + "'>");
								out.println(LibreriaMVC.getTitulo(i) + " | " + LibreriaMVC.getPrecio(i));
								out.println("</option>");
							}
						%>
					</select> Cantidad: <input type="text" name="cantidad" size="10" value="1">
					<input class="btn btn-primary" type="submit" value="Añadir a la cesta">
				</form>
				<hr />
				<br />
				<%
					// Scriplet 2: Chequea el contenido de la cesta
					ArrayList<ElementoPedido> cesta = (ArrayList<ElementoPedido>) session.getAttribute("carrito");
					if (cesta != null && cesta.size() > 0) {
				%>
				<p>
					<strong>Tu cesta contiene:</strong>
				</p>
				<table class=" table table-hover table-striped mt-4">
					<thead class="bg-secondary text-white">
						<tr>
							<th>Título</th>
							<th>Precio</th>
							<th>Cantidad</th>
							<th></th>
						</tr>
					</thead>
					<%
						// Scriplet 3: Muestra los libros del carrito
							for (int i = 0; i < cesta.size(); i++) {
								ElementoPedido elementoPedido = cesta.get(i);
					%>
					<tr>
						<form name="borrarForm" action="shopping" method="POST">
							<input type="hidden" name="todo" value="remove"> <input
								type="hidden" name="indiceElemento" value="<%=i%>">
							<td><%=elementoPedido.getTitulo()%></td>
							<td><%=elementoPedido.getPrecio()%> €</td>
							<td><%=elementoPedido.getCantidad()%></td>
							<td><input class="btn btn-primary" type="submit" value="Eliminar de la cesta"></td>
						</form>
					</tr>
					<%
						}
					%>
				</table>
				<br />
				<form name="checkoutForm" action="shopping" method="POST">
					<input type="hidden" name="todo" value="checkout"> <input
						class="btn btn-primary" type="submit" value="Confirmar compra">
				</form>
				<%
		}
	%>
			</div>
		</div>
	</div>
</body>
</html>
