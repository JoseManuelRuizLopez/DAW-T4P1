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
<title>Alta Libro</title>
</head>
<body>

	<div class="container mt-4">
		<div class="row">
			<div class="col-8 text">

				<h2>Administrador</h2>

				<a href="altaLibro.jsp"><button class="btn btn-info">
						<b>Alta Libro</b>
					</button></a> <a href="modificarLibro.jsp"><button class="btn btn-info">Modificación
						Libro</button></a> <a href="autores.jsp"><button class="btn btn-info">Autores</button></a>
				<a href="editoriales.jsp"><button class="btn btn-info">Editoriales</button></a>
				<a href="pedidos.jsp"><button class="btn btn-info">Pedidos</button></a>
				<a href="index.html"><button class="btn btn-danger">LOGOUT</button></a>
				<hr>

				<form method="post" action="altaLibro.jsp">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Titulo</span>
						</div>
						<input name="titulo" type="text" class="form-control"
							aria-label="Titulo" aria-describedby="basic-addon1">
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Precio</span>
						</div>
						<input name="precio" type="text" class="form-control"
							placeholder="00.00" aria-label="Precio"
							aria-describedby="basic-addon1">
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Cantidad</span>
						</div>
						<input name="cantidad" type="text" class="form-control"
							placeholder="00" aria-label="Cantidad"
							aria-describedby="basic-addon1">
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Autores</span>
						</div>
						<select name="autor" class="form-control">
							<%@ page import="java.sql.*"%>
							<%
								ResultSet rs = es.studium.PoolConexiones.Conexiones.doSelect("*", "autores");
								while (rs.next()) {
							%>
							<option value="<%=rs.getString("idAutor")%>"><%=rs.getString("nombreAutor")%>
								<%=rs.getString("apellidosAutor")%></option>
							<%
								}
							%>
						</select>
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Editoriales</span>
						</div>
						<select name="editorial" class="form-control">
							<%@ page import="java.sql.*"%>
							<%
								ResultSet rs1 = es.studium.PoolConexiones.Conexiones.doSelect("*", "editoriales");
								while (rs1.next()) {
							%>
							<option value="<%=rs1.getString("idEditorial")%>">
								<%=rs1.getString("nombreEditorial")%>
							</option>
							<%
								}
							%>
						</select>
					</div>
					<a href="aministrador.jsp" class="btn btn-warning">Volver</a> <input
						type="submit" value="Alta" class="btn btn-success">

				</form>
				<%@ page import="java.sql.*"%>
				<%
					String titulo = request.getParameter("titulo");
					String precio = request.getParameter("precio");
					String cantidad = request.getParameter("cantidad");
					String autor = request.getParameter("autor");
					String editorial = request.getParameter("editorial");
					System.out.println("t " + titulo);
					System.out.println("p " + precio);
					System.out.println("c " + cantidad);
					if ((titulo != null && titulo != "") && (precio != null && precio != "")
							&& (cantidad != null && cantidad != "")) {

						try {
							String objeto = "libros";
							String campos = "tituloLibro, precioLibro, stockLibro, idAutorFK ,idEditorialFK";
							String valores = "'" + titulo + "'," + precio + "," + cantidad + "," + autor + "," + editorial + "";
							es.studium.PoolConexiones.Conexiones.doInsert(campos, objeto, valores);
							out.print("Libro insertado");

						} catch (Exception e) {
							out.print("Error");

							System.out.print(e);
							e.printStackTrace();
						}
					} else if (titulo == "" || precio == "" || cantidad == "") {
						out.print("Es necesario informar todos lo campos");
					}
				%>
			</div>
		</div>
	</div>
</body>
</html>