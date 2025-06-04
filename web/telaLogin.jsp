<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/clinica";
    String usuario = "root"; // Usu�rio padr�o do XAMPP
    String senhaBD = "root"; // Senha padr�o (vazia)
    Connection conexao = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conexao = DriverManager.getConnection(url, usuario, senhaBD);
    } catch (Exception e) {
        out.println("Erro na conex�o: " + e.getMessage());
        return; // Encerra a execu��o se n�o conseguir conectar
    }

    String email = request.getParameter("username");
    String senha = request.getParameter("password");

    if (email != null && senha != null) {
        try {
            // Buscar usu�rio no banco (sem hash de senha)
            String sql = "SELECT tipo, cpf FROM usuarios WHERE email = ? AND senha = ?";
            PreparedStatement stmt = conexao.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, senha); // Comparar senha diretamente (sem hash)

            ResultSet resultado = stmt.executeQuery();

            if (resultado.next()) {
                String tipoUsuario = resultado.getString("tipo");
                String cpf = resultado.getString("cpf"); // Busca o rg do usu�rio

                // Criar sess�o para armazenar login e rg
                session.setAttribute("usuarioLogado", email);
                session.setAttribute("tipo", tipoUsuario);
                session.setAttribute("cpf", cpf); // Armazenando o rg na sess�o

                if ("admin".equals(tipoUsuario)) {
                    response.sendRedirect("indexAdm.jsp"); // Painel do Admin
                } else {
                    response.sendRedirect("telaLoginSucesso.jsp?login=sucesso"); // Cliente normal
                }
            } else {
                response.sendRedirect("telaLogin.jsp?erro=1"); // Erro de login
            }

            // Fechar a conex�o e os recursos
            resultado.close();
            stmt.close();
        } catch (Exception e) {
            out.println("Erro: " + e.getMessage());
        } finally {
            // Fechar a conex�o no bloco finally para garantir que seja fechado
            try {
                if (conexao != null && !conexao.isClosed()) {
                    conexao.close();
                }
            } catch (SQLException e) {
                out.println("Erro ao fechar a conex�o: " + e.getMessage());
            }
        }
    } else {
        out.println("Email ou senha inv�lidos.");
    }
%>