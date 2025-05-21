<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listagem de Consultas</title>
    <link rel="stylesheet" href="listarConsulta.css">
</head>
<body>
    
    <%
    String tipoUsuario = (String) session.getAttribute("tipo");
    if (tipoUsuario == null || !"admin".equals(tipoUsuario)) {
        response.sendRedirect("telaLogin.jsp?erro=acessoNegado");
    }
%>


    <h2>Lista de Consultas</h2>

    <table border="1">
        <thead>
            <tr>
                <th>Nome</th>
                <th>Número</th>
                <th>RG Dono</th>
                <th>Data da Consulta</th>
                <th>Alergia</th>
                <th>Gênero</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>

        <%
            // Conexão com o Banco de Dados MySQL (XAMPP)
            String url = "jdbc:mysql://localhost:3306/clinica";
            String usuario = "root";  // Ajuste conforme seu MySQL
            String senhaDB = "root";      // Se houver senha, coloque aqui

            Connection conexao = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conexao = DriverManager.getConnection(url, usuario, senhaDB);

                // Consulta SQL para buscar os dados da consulta
                String sql = "SELECT nome, numero, rg_dono, data_consulta, alergia, genero FROM dadosconsulta";
                stmt = conexao.prepareStatement(sql);
                rs = stmt.executeQuery();

                // Percorre os resultados e exibe na tabela
                while (rs.next()) {
                    String nome = rs.getString("nome");
                    String numero = rs.getString("numero");
                    String rgDono = rs.getString("rg_dono");
                    String dataConsulta = rs.getString("data_consulta");
                    String alergia = rs.getString("alergia");
                    String genero = rs.getString("genero");
        %>

            <tr>
                <td><%= nome %></td>
                <td><%= numero %></td>
                <td><%= rgDono %></td>
                <td><%= dataConsulta %></td>
                <td><%= alergia %></td>
                <td><%= genero %></td>
                <td>
                    <button onclick="editarRegistro('<%= nome %>')">Editar</button>
                    <button onclick="excluirRegistro('<%= nome %>')">Excluir</button>
                </td>
            </tr>

        <%
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Erro ao conectar ao banco: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conexao != null) conexao.close();
            }
        %>

        </tbody>
    </table>

    <script>
        function editarRegistro(nome) {
            alert("Redirecionando para editar o registro de: " + nome);
            window.location.href = "editar.jsp?nome=" + nome;
        }

        function excluirRegistro(nome) {
            let confirmar = confirm("Tem certeza que deseja excluir o registro de: " + nome + "?");
            if (confirmar) {
                alert("Registro de " + nome + " excluído!");
                window.location.href = "excluir.jsp?nome=" + nome;
            }
        }
    </script>

</body>
</html>
