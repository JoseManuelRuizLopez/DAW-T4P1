<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<title>Carro</title>
</head>
<body>

	<div class="container mt-4">
		<div class="row">
			<div class="col-8 text">

				<h2><%=session.getAttribute("idUsuario").toString() %></h2>

				<form method="post" action="pedidosUsuario.jsp">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Autores</span>
						</div>
						<select name="autor" class="form-control">
							<%@ page import="java.sql.*"%>
							<%
								ResultSet rs = es.studium.PoolConexiones.Conexiones.doSelect("*", "libros");
								while (rs.next()) {
							%>
							<option value="<%=rs.getString("idLibro")%>"><%=rs.getString("tituloLibro")%> |
								<%=rs.getString("precioLibro")%></option>
							<%
								}
							%>
						</select>
						
						<div class="input-group mt-4">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Cantidad</span>
						</div>
						<input name="cantidad" type="text" class="form-control"
							placeholder="00" aria-label="Cantidad"
							aria-describedby="basic-addon1">
					</div>
					</div>
					<a href="index.html" class="btn btn-warning">Volver</a> <input
						type="submit" value="Añadir" class="btn btn-success">

				</form>
				<%@ page import="java.sql.*"%>
				<%
					String idUsuario = session.getAttribute("idUsuario").toString();
				
					String idLibro = request.getParameter("idLibro");
					String precio = request.getParameter("precio");
					String cantidad = request.getParameter("cantidad");
					
					if ((idLibro != null && idLibro != "") && (precio != null && precio != "")
							&& (cantidad != null && cantidad != "")) {

						try {
							String objeto = "libros";
							String campos = "tituloLibro, precioLibro, stockLibro, idAutorFK ,idEditorialFK";
							String valores = "'" + idLibro + "'," + cantidad + "," + cantidad + "";
							es.studium.PoolConexiones.Conexiones.doInsert(campos, objeto, valores);
							out.print("Libro insertado");

						} catch (Exception e) {
							out.print("Error");

							System.out.print(e);
							e.printStackTrace();
						}
					} else if (idLibro == "" || precio == "" || cantidad == "") {
						out.print("Es necesario informar todos lo campos");
					}
				%>
			</div>
		</div>
	</div>
</body>
</html>