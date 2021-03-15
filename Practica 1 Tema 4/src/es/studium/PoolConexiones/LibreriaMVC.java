package es.studium.PoolConexiones;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
/**
 *
 * @author Jorge
 * LibrosMVC
 * Encapsula la comunicación con la base de datos
 * Almacena títulos, autores y precios en tres tablas
 *
 */
public class LibreriaMVC
{
	static ArrayList<Libro> tabla = new ArrayList<Libro>();
	public static void cargarDatos()
	{
		// Creamos objetos para la conexión
		Connection conn = null;
		Statement stmt = null;
		try
		{
			// Paso 1: Cargamos el driver
			Class.forName("com.mysql.cj.jdbc.Driver");
			// Paso 2: Conectarse a la base de datos utilizando un objeto de la clase Connection
			String userName = "root";
			String password = "Studium2019;";
			// URL de la base de datos
			String url =
					"jdbc:mysql://localhost:3306/tienda?useSSL=false&serverTimezone=UTC";
			conn = DriverManager.getConnection(url, userName, password);
			// Paso 3: Crear las sentencias SQL utilizando objetos de la clase Statement
			stmt = conn.createStatement();
			// Paso 4: Ejecutar las sentencias
			String sqlStr = "SELECT * FROM libros";
			System.out.println(sqlStr);
			ResultSet rs = stmt.executeQuery(sqlStr);
			Libro libro;
			while(rs.next())
			{
				System.out.println(rs.getInt("idLibro"));
				System.out.println(rs.getString("tituloLibro"));

				libro = new Libro(rs.getInt("idLibro"), rs.getString("tituloLibro"), rs.getDouble("precioLibro"));
				tabla.add(libro);
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		finally
		{
			try
			{
				// Cerramos el resto de recursos
				if(stmt != null)
				{
					stmt.close();
				}
				if(conn != null)
				{
					conn.close();
				}
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
		}
	}
	/**
	 * Devuelve el número de libros obtenidos
	 */
	public static int tamano()
	{
		return tabla.size();
	}
	/**
	 * Devuelve el título del libro identificado con idLibro
	 */
	public static String getTitulo(int idLibro)
	{
		return tabla.get(idLibro).getTitulo();
	}
	/**
	 * Devuelve el autor del libro identificado con idLibro
	 */

	/**
	 * Devuelve el precio del libro identificado con idLibro
	 */
	public static double getPrecio(int idLibro)
	{
		return tabla.get(idLibro).getPrecio();
	}
}
