<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String mensagem = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) { 
        String nomeUsuario = request.getParameter("username");
        String email = request.getParameter("email");
        String senhaUsuario = request.getParameter("password");
        String cpf = request.getParameter("cpf");  

        if (nomeUsuario == null || email == null || senhaUsuario == null || cpf == null) {
            mensagem = "<p class='error'>Erro ao receber os dados do formulário.</p>";
        } else {
            nomeUsuario = nomeUsuario.trim();
            email = email.trim();
            senhaUsuario = senhaUsuario.trim();
            cpf = cpf.trim();

            if (!nomeUsuario.isEmpty() && !email.isEmpty() && !senhaUsuario.isEmpty() && !cpf.isEmpty()) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    String url = "jdbc:mysql://localhost:3306/clinica";
                    String user = "root";
                    String password = "root";

                    try (
                        Connection conexao = DriverManager.getConnection(url, user, password);
                        PreparedStatement verificaEmail = conexao.prepareStatement("SELECT * FROM usuarios WHERE email = ?");
                    ) {
                        verificaEmail.setString(1, email);
                        ResultSet resultado = verificaEmail.executeQuery();

                        if (resultado.next()) {
                            // E-mail já existe
                            mensagem = "<p class='error'>E-mail já cadastrado. Use outro.</p>";
                        } else {
                            // Inserir novo usuário
                            try (PreparedStatement stmt = conexao.prepareStatement(
                                "INSERT INTO usuarios (nome, email, senha, cpf) VALUES (?, ?, ?, ?)")  // troquei rg por cpf
                            ) {
                                stmt.setString(1, nomeUsuario);
                                stmt.setString(2, email);
                                stmt.setString(3, senhaUsuario);
                                stmt.setString(4, cpf);  

                                int rowsAffected = stmt.executeUpdate();

                                if (rowsAffected > 0) {
                                    mensagem = "<p class='success'>Conta cadastrada com sucesso!</p>";
                                } else {
                                    mensagem = "<p class='error'>Erro ao cadastrar a conta.</p>";
                                }
                            }
                        }
                    }
                } catch (ClassNotFoundException e) {
                    mensagem = "<p class='error'>Erro: Driver JDBC não encontrado.</p>";
                    e.printStackTrace();
                } catch (SQLException e) {
                    mensagem = "<p class='error'>Erro ao conectar ao banco de dados: " + e.getMessage() + "</p>";
                    e.printStackTrace();
                }
            } else {
                mensagem = "<p class='error'>Por favor, preencha todos os campos corretamente.</p>";
            }
        }
    } else {
        mensagem = "<p class='error'>Método de requisição inválido.</p>";
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Conta</title>
    <style>
.message {
    text-align: center;
    font-size: 16px;
    font-weight: bold;
    padding: 10px;
    margin: 10px 0;
    border-radius: 5px;
}
.success {
    background-color: #d4edda;
    color: #155724;
    border: 1px solid #c3e6cb;
}
.error {
    background-color: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
}
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}
.message {
    animation: fadeIn 0.5s ease-in-out;
}
    </style>
</head>
<body>
    <div class="container">
        <h1>Cadastro de Conta</h1>

        <div class="message">
            <%= mensagem %>
        </div>

        <form action="telaCadastro.html" method="get">
            <input type="submit" value="Voltar" />
        </form>
    </div>
</body>
</html>
