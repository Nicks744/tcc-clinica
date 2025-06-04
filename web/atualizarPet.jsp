<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" %>
<%
    String idStr = request.getParameter("idPet");
    String nome = request.getParameter("nomePet");
    String especie = request.getParameter("especiePet");
    String raca = request.getParameter("racaPet");
    String idadeStr = request.getParameter("idadePet");
    String sexo = request.getParameter("sexoPet");

    // Verifica se algum campo obrigatório está vazio
    if (idStr == null || idadeStr == null || nome == null || especie == null || raca == null || sexo == null) {
        out.println("Dados inválidos. Verifique se todos os campos foram preenchidos.");
        return;
    }

    int idPet = 0;
    int idade = 0;
    try {
        idPet = Integer.parseInt(idStr);
        idade = Integer.parseInt(idadeStr);
    } catch (NumberFormatException e) {
        out.println("Erro ao converter idade ou ID: " + e.getMessage());
        return;
    }

    // Conexão com o banco
    String url = "jdbc:mysql://localhost:3306/clinica?useUnicode=true&characterEncoding=UTF-8";
    String usuario = "root";
    String senhaBD = "root";

    try (
        Connection conexao = DriverManager.getConnection(url, usuario, senhaBD);
        PreparedStatement stmt = conexao.prepareStatement("UPDATE animais SET nome = ?, especie = ?, raca = ?, idade = ?, sexo = ? WHERE id = ?")
    ) {
        // Definindo os parâmetros
        stmt.setString(1, nome);
        stmt.setString(2, especie);
        stmt.setString(3, raca);
        stmt.setInt(4, idade);
        stmt.setString(5, sexo);
        stmt.setInt(6, idPet);

        // Executa a atualização no banco
        int rows = stmt.executeUpdate();
        if (rows > 0) {
            // Redireciona para a página de conta
            response.sendRedirect("minhaConta.jsp");
        } else {
            out.println("Erro ao atualizar pet. Nenhuma linha foi afetada.");
        }
    } catch (SQLException e) {
        out.println("Erro ao atualizar pet: " + e.getMessage());
    }
%>
