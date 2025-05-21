<%
    HttpSession sessao = request.getSession(false);

    // Verifica se o usu�rio est� logado e se � ADMIN
    if (sessao == null || !"admin".equals(sessao.getAttribute("tipo"))) {
        response.sendRedirect("telaLogin.jsp"); // ou outra p�gina de acesso negado
        return;
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel Administrativo - Cl�nica Veterin�ria</title>
    <link rel="stylesheet" href="indexAdm.css">
</head>
<body>
    <div class="sidebar">
        <h2>Administra��o</h2>
        <ul>
            <li><a href="agendarConsulta.html">Agendar Consulta</a></li>
            <li><a href="listarConsulta.jsp">Gerenciar Consultas</a></li>
           
            
            <section class="login-section">
                <button class="btn-login" onclick="window.location.href='logout.jsp'">Sair</button>
            
              
        </ul>
  
</body>
</html>

