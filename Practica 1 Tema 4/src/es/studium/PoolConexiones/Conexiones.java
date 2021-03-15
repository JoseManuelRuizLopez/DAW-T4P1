package es.studium.PoolConexiones;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.sql.DataSource;

// Clase creada para crear consultas
public class Conexiones {
	private static DataSource pool;

	// Método para realizar consultas SELECT
	public static ResultSet doSelect(String campos, String objeto) throws ServletException, SQLException {
		try {
			// Crea un contexto para poder luego buscar el recurso DataSource
			InitialContext ctx = new InitialContext();
			// Busca el recurso DataSource en el contexto
			pool = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql_tienda");
			if(pool == null) {
				throw new ServletException("DataSource desconocida 'mysql_tienda' ");
			}
		}
		catch(NamingException ex){}
		
		Connection conn = null;
		Statement stmt = null;

		conn = pool.getConnection();
		stmt = conn.createStatement();
		StringBuilder sqlStr = new StringBuilder();

		sqlStr.append("SELECT "+campos+" FROM "+objeto+";");
		
		System.out.print(sqlStr.toString());
		ResultSet rset = stmt.executeQuery(sqlStr.toString());
		return rset;
	}
	
	public static void doInsert(String campos, String objeto, String values) throws ServletException, SQLException {
		try {
			// Crea un contexto para poder luego buscar el recurso DataSource
			InitialContext ctx = new InitialContext();
			// Busca el recurso DataSource en el contexto
			pool = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql_tienda");
			if(pool == null) {
				throw new ServletException("DataSource desconocida 'mysql_tienda' ");
			}
		}
		catch(NamingException ex){}
		
		Connection conn = null;
		Statement stmt = null;

		conn = pool.getConnection();
		stmt = conn.createStatement();

		String query = "INSERT INTO "+objeto+" ("+campos+") VALUES ("+values+") ;";
		System.out.println(query);
		stmt.execute(query);
	}
	
	public static void doUpdate(String campos,String objeto) throws ServletException, SQLException {
		try {
			// Crea un contexto para poder luego buscar el recurso DataSource
			InitialContext ctx = new InitialContext();
			// Busca el recurso DataSource en el contexto
			pool = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql_tienda");
			if(pool == null) {
				throw new ServletException("DataSource desconocida 'mysql_tienda' ");
			}
		}
		catch(NamingException ex){}
		
		Connection conn = null;
		Statement stmt = null;

		conn = pool.getConnection();
		stmt = conn.createStatement();
		StringBuilder sqlStr = new StringBuilder();

		sqlStr.append("UPDATE "+objeto+" SET "+campos+";");
		System.out.println(sqlStr.toString());
		stmt.executeUpdate(sqlStr.toString());
	}
	
	
	

}