<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Consulta</title>
</head>
<body>
    <div class="container">
        <h1>Cadastro de Consulta</h1>

        <%
            // Captura os parâmetros do formulário
            String nome = request.getParameter("nome");
            String numero = request.getParameter("numero");
            int rg_dono = Integer.parseInt(request.getParameter("rg_dono"));
            String data_consulta = request.getParameter("data_consulta");
            String genero = request.getParameter("genero");
            String raca = request.getParameter("raca");
            String sintomas = request.getParameter("sintomas");
            double peso = Double.parseDouble(request.getParameter("peso"));
            String observacoes = request.getParameter("observacoes");
            
            String mensagem = "";

            try {
                // Conexão com o banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/clinica";
                String user = "root";
                String password = "root";
                Connection conecta = DriverManager.getConnection(url, user, password);

                // Comando SQL para inserir dados
                String sql = "INSERT INTO dadosconsulta (nome, numero, rg_dono, data_consulta, genero, raca, sintomas, peso, observacoes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                
                PreparedStatement st = conecta.prepareStatement(sql);
                st.setString(1, nome);
                st.setString(2, numero);
                st.setInt(3, rg_dono);
                st.setString(4, data_consulta);
                st.setString(5, genero);
                st.setString(6, raca);
                st.setString(7, sintomas);
                st.setDouble(8, peso);
                st.setString(9, observacoes);
                
                // Executa a inserção
                int rowsAffected = st.executeUpdate();
                if (rowsAffected > 0) {
                    mensagem = "<p class='success'>Consulta cadastrada com sucesso!</p>";
                } else {
                    mensagem = "<p class='error'>Erro ao cadastrar a consulta.</p>";
                }

                // Fecha a conexão
                st.close();
                conecta.close();
            } catch (ClassNotFoundException e) {
                mensagem = "<p class='error'>Driver JDBC não encontrado! " + e.getMessage() + "</p>";
            } catch (SQLException e) {
                mensagem = "<p class='error'>Erro ao conectar ao banco de dados: " + e.getMessage() + "</p>";
            }
        %>

        <div class="message">
            <%= mensagem %>
        </div>

        <form action="indexAdm.html" method="get">
            <input type="submit" value="Voltar para o início" />
        </form>
    </div>

    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            background: white;
            padding: 20px;
            margin: 50px auto;
            width: 50%;
            border-radius: 10px;
            box-shadow: 0px 0px 10px #ccc;
        }
        .message {
            margin: 20px 0;
        }
        .success {
            color: green;
            font-weight: bold;
        }
        .error {
            color: red;
            font-weight: bold;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background: #3498db;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        input[type="submit"]:hover {
            background: #2980b9;
        }
    </style>
</body>
</html>
