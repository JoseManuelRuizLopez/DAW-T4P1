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
<title>Modificando</title>
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
				<hr>

				<form method="post" action="modificar.jsp">


					<%@ page import="java.sql.*"%>
					<%
						String id = request.getParameter("idLibro");
						ResultSet rs = es.studium.PoolConexiones.Conexiones.doSelect("*",
								"libros, autores, editoriales where idAutorFK = idAutor and idEditorialFK = idEditorial and idLibro = "
										+ id);
						while (rs.next()) {
					%>

					<div class="input-group mb-3">
						<input type=hidden name="id" value="<%=id%>">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Titulo</span>
						</div>
						<input name="titulo" type="text" class="form-control"
							value="<%=rs.getString("tituloLibro")%>" aria-label="Titulo"
							aria-describedby="basic-addon1">
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Precio</span>
						</div>
						<input name="precio" type="text" class="form-control"
							value="<%=rs.getString("precioLibro")%>" aria-label="Precio"
							aria-describedby="basic-addon1">
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Cantidad</span>
						</div>
						<input name="cantidad" type="text" class="form-control"
							value="<%=rs.getString("stockLibro")%>" aria-label="Cantidad"
							aria-describedby="basic-addon1">
					</div>

					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Autor</span>
						</div>
						<select name="autor" class="form-control">
							<%@ page import="java.sql.*"%>
							<%
								ResultSet rs2 = es.studium.PoolConexiones.Conexiones.doSelect("*", "autores");
									while (rs2.next()) {
										System.out.println(rs.getString("idAutor"));

										if (rs.getString("idAutor").equals((rs2.getString("idAutor")))) {
											out.print("<option value=\"" + rs2.getString("idAutor") + "\" selected=\"selected\">"
													+ rs2.getString("nombreAutor") + " " + rs2.getString("apellidosAutor") + "</option>");
										} else {
											out.print("<option value=\"" + rs2.getString("idAutor") + "\">" + rs2.getString("nombreAutor")
													+ " " + rs2.getString("apellidosAutor") + "</option>");

										}
									}
							%>
						</select>
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Editorial</span>
						</div>
						<select name="editorial" class="form-control">
							<%@ page import="java.sql.*"%>
							<%
								ResultSet rs3 = es.studium.PoolConexiones.Conexiones.doSelect("*", "editoriales");
									while (rs3.next()) {
										System.out.println(rs.getString("idEditorial"));

										if (rs.getString("idEditorial").equals((rs3.getString("idEditorial")))) {
											out.print("<option value=\"" + rs3.getString("idEditorial") + "\" selected=\"selected\">"
													+ rs3.getString("nombreEditorial") + "</option>");
										} else {
											out.print("<option value=\"" + rs3.getString("idEditorial") + "\">"
													+ rs3.getString("nombreEditorial") + "</option>");

										}
									}
							%>
						</select>
					</div>
					<input type="submit" value="Modificar" class="btn btn-success">
					<%
					
						}
					%>
					<a href="modificarLibro.jsp" class="btn btn-warning">Volver</a>
				</form>
				<%@ page import="java.sql.*"%>
				<%
					String id2 = request.getParameter("id");
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
							String campos = "tituloLibro = '" + titulo + "', precioLibro = " + precio + ", stockLibro = "
									+ cantidad + ", idAutorFK = " + autor + ",idEditorialFK = " + editorial
									+ " where idLibro = " + id2;
							es.studium.PoolConexiones.Conexiones.doUpdate(campos, objeto);
							out.print("Libro actualizado");

						} catch (Exception e) {
							out.print("Error update");

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