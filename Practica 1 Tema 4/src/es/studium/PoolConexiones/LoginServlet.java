package es.studium.PoolConexiones;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
@WebServlet(
		name = "LoginServlet",
		urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	// Pool de conexiones a la base de datos
	private DataSource pool;
	public LoginServlet()
	{
		super();
	}
	public void init(ServletConfig config) throws ServletException
	{
		try
		{
			// Crea un contexto para poder luego buscar el recurso DataSource
			InitialContext ctx = new InitialContext();
			// Busca el recurso DataSource en el contexto
			pool = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql_tienda");
			if(pool == null)
			{
				throw new ServletException("DataSource desconocida 'mysql_tienda'");
			}
		}catch(NamingException ex){}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse
			response) throws ServletException, IOException
	{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		Connection conn = null;
		Statement stmt = null;
		try
		{
			out.println("<!DOCTYPE html>\r\n" + 
					"<html>\r\n" + 
					"<head>\r\n" + 
					"    <meta charset=\"utf-8\">\r\n" + 
					"    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\">\r\n" + 
					"\r\n" + 
					"    <link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css\" integrity=\"sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm\" crossorigin=\"anonymous\">\r\n" + 
					"    <title>Login</title>\r\n" + 
					"</head>\r\n" + 
					"<body>\r\n" + 
					"	<div class=\"container mt-4\">\r\n" + 
					"      <div class=\"row\">\r\n" + 
					"        <div class=\"col-8 text\">            \r\n" + 
					"          <form id=\"contactform\" method=\"get\" action=\"login\">\r\n" + 
					"            <div class=\"form-group\">");
			// Obtener una conexión del pool
			conn = pool.getConnection();
			stmt = conn.createStatement();
			// Recuperar los parámetros usuario y password de la petición request
			String usuario = request.getParameter("usuario");
			//out.println(usuario);
			String password = request.getParameter("password");
			// Validar los parámetros de la petición request
			if(usuario.length()==0)
			{
				out.println("<h3>Debes introducir tu usuario</h3>");
			}
			else if(password.length()==0)
			{
				out.println("<h3>Debes introducir tu contraseña</h3>");
			}
			else 
			{
				// Verificar que existe el usuario y su correspondiente clave
				StringBuilder sqlStr = new StringBuilder();
				sqlStr.append("SELECT * FROM usuarios WHERE ");
				sqlStr.append("STRCMP(usuarios.nombreUsuario,'").append(usuario).append("') = 0");
				sqlStr.append(" AND STRCMP(usuarios.claveUsuario, MD5('").append(password).append("')) = 0");
				ResultSet rset = stmt.executeQuery(sqlStr.toString());
				if(!rset.next())
				{
					// Si el resultset no está vacío
					out.println("<h3>Nombre de usuario o contraseña incorrectos</h3>");
					out.println("<p><a href='index.html'>Volver a Login</a></p>");
				}
				else 
				{
					int tipoUsuario = rset.getInt("tipoUsuario");
					System.out.println(tipoUsuario);
					// Si los datos introducidos son correctos
					// Crear una sesión nueva y guardar el usuario como variable de sesión
					// Primero, invalida la sesión si ya existe 

					HttpSession session = request.getSession(false);
					if(session != null)
					{
						session.invalidate();
					}
					session = request.getSession(true);
					synchronized (session) {
						session.setAttribute("idUsuario", rset.getString("idUsuario"));
					}

					if (tipoUsuario == 0)
					{
						out.print("<a href='administrador.jsp'><h3><b>Pulsa aquí Administrador</b></h2></a>");

					} else {

						out.print("<a href='shopping'><h3><b>Usuario</b></h2></a>");
					}

				}

				out.println("</body></html>");
			}
		}
		catch(SQLException ex)
		{
			out.println("<p>Servicio no disponible:</p>");
			out.println("<p>"+ex.getMessage()+"</p>");
			out.println("</body>");
			out.println("</html>");
		}
		finally
		{
			// Cerramos objetos
			out.close();
			try
			{
				if(stmt != null)
				{
					stmt.close();
				}
				if(conn != null)
				{
					// Esto devolvería la conexión al pool
					conn.close();
				}
			}
			catch(SQLException ex){}
		}
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
} 
