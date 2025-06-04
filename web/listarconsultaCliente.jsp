<%@ page import="java.sql.*" %>
<%
    Integer rgDono = (Integer) session.getAttribute("rg_dono");
    if (rgDono == null) {
        response.sendRedirect("telaLogin.jsp");
        return;
    }

    Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/clinica", "root", "root");
    PreparedStatement stmt = conecta.prepareStatement("SELECT * FROM dadosconsulta WHERE rg_dono = ?");
    stmt.setInt(1, rgDono);
    ResultSet rs = stmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Minhas Consultas</title>
</head>
<body>
    <h2>Minhas Consultas</h2>
    <table border="1">
        <tr>
            <th>Pet</th>
            <th>Data</th>
            <th>Status</th>
            <th>Ações</th>
        </tr>

        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("nome") %></td>
            <td><%= rs.getString("data_consulta") %></td>
            <td><%= rs.getString("status") %></td>
            <td>
                <a href="editarConsulta.jsp?id=<%= rs.getInt("id") %>">Editar</a> |
                <a href="cancelarConsulta.jsp?id=<%= rs.getInt("id") %>">Cancelar</a> |
                <a href="relatorioConsulta.jsp?id=<%= rs.getInt("id") %>">Relatório</a>
            </td>
        </tr>
        <%
            }
            rs.close();
            stmt.close();
            conecta.close();
        %>
    </table>
</body>
</html>
