<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%
    String url = "jdbc:mysql://localhost:3306/clinica?useUnicode=true&characterEncoding=UTF-8";
    String usuario = "root";
    String senhaBD = "root";

    // Obtendo a variável da sessão
    String cpfSessao = (String) session.getAttribute("cpf");

    if (cpfSessao == null) {
%>
        <p style='color: red;'>Erro: cpfSessao não encontrado. Por favor, faça login novamente.</p>
        <%
        return;
    }

    Connection conexao2 = null;
    PreparedStatement stmtCadastroPet = null;
    ResultSet rsPets = null;

    try {
        // Carregar o driver JDBC
        Class.forName("com.mysql.cj.jdbc.Driver");
        conexao2 = DriverManager.getConnection(url, usuario, senhaBD);

        // Recuperando os dados do pet do formulário
        String nomePet = request.getParameter("nomePet");
        String especiePet = request.getParameter("especiePet");
        String racaPet = request.getParameter("racaPet");
        int idadePet = Integer.parseInt(request.getParameter("idadePet"));
        String sexoPet = request.getParameter("sexoPet");

        // Verificar se os dados foram passados corretamente
        if (nomePet == null || especiePet == null || racaPet == null || sexoPet == null) {
%>
            <p style='color: red;'>Erro: Campos obrigatórios não foram preenchidos.</p>
<%
            return;
        }

        // SQL para inserir o novo pet no banco
        String sqlCadastroPet = "INSERT INTO animais (nome, especie, raca, idade, sexo, cpf) VALUES (?, ?, ?, ?, ?, ?)";
        stmtCadastroPet = conexao2.prepareStatement(sqlCadastroPet);
        stmtCadastroPet.setString(1, nomePet);
        stmtCadastroPet.setString(2, especiePet);
        stmtCadastroPet.setString(3, racaPet);
        stmtCadastroPet.setInt(4, idadePet);
        stmtCadastroPet.setString(5, sexoPet);
        stmtCadastroPet.setString(6, cpfSessao);

        int rowsAffected = stmtCadastroPet.executeUpdate();

        if (rowsAffected > 0) {
%>
<html>
<head>
    <title>Cadastro de Pet</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f4f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .confirm-box {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            text-align: center;
            width: 400px;
        }

        .success {
            color: #2e7d32;
            font-size: 20px;
            margin-bottom: 20px;
        }

        button {
            padding: 10px 20px;
            background-color: #1976d2;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #1565c0;
        }

        .countdown {
            margin-top: 10px;
            font-size: 14px;
            color: #555;
        }
    </style>
</head>
<body>
    <div class="confirm-box">
        <div class="success">Pet <%= nomePet %> cadastrado com sucesso!</div>
        <button onclick="voltar()">Voltar ao painel</button>
        <div class="countdown" id="countdown">Redirecionando em 5 segundos...</div>
    </div>

    <script>
        function voltar() {
            window.location.href = "minhaConta.jsp"; // Troque pela sua página de destino
        }

        let segundos = 5;
        const countdown = document.getElementById("countdown");

        const timer = setInterval(() => {
            segundos--;
            countdown.innerText = `Redirecionando em ${segundos} segundos...`;
            if (segundos === 0) {
                clearInterval(timer);
                voltar();
            }
        }, 1000);
    </script>
</body>
</html>
<%
        } else {
%>
            <p style='color: red;'>Erro: Não foi possível cadastrar o pet.</p>
<%
        }
    } catch (Exception e) {
%>
        <p style='color: red;'>Erro ao cadastrar o pet: <%= e.getMessage() %></p>
<%
        e.printStackTrace();
    } finally {
        try {
            if (rsPets != null) rsPets.close();
            if (stmtCadastroPet != null) stmtCadastroPet.close();
            if (conexao2 != null) conexao2.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
