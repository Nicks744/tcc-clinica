<%
    HttpSession sessao = request.getSession(false);

    // Verifica se o usuário está logado e se é ADMIN
    if (sessao == null || !"admin".equals(sessao.getAttribute("tipo"))) {
        response.sendRedirect("telaLogin.jsp"); // ou outra página de acesso negado
        return;
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel Administrativo - Clínica Veterinária</title>
    <link rel="stylesheet" href="indexAdm.css">
</head>
<body>
    <div class="sidebar">
        <h2>Administração</h2>
        <ul>
            <li><a href="agendarConsulta.html">Agendar Consulta</a></li>
            <li><a href="listarConsulta.jsp">Gerenciar Consultas</a></li>
           
            
            <section class="login-section">
                <button class="btn-login" onclick="window.location.href='logout.jsp'">Sair</button>
            
              
        </ul>
  
</body>
</html>

