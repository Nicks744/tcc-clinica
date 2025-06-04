<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*, javax.servlet.http.HttpSession" %>
<%
    HttpSession sessao = request.getSession(false);
    if (sessao == null || sessao.getAttribute("usuarioLogado") == null) {
        response.sendRedirect("telaLogin.jsp");
        return;
    }

    String emailSessao = (String) sessao.getAttribute("usuarioLogado");
    String cpf = (String) sessao.getAttribute("cpf"); // Aqui estamos pegando o cpf da sessão

    // Conexão com o banco
    String url = "jdbc:mysql://localhost:3306/clinica?useUnicode=true&characterEncoding=UTF-8";
    String usuario = "root";
    String senhaBD = "root";
    Connection conexao = null;

    String nome = "";
    String telefone = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conexao = DriverManager.getConnection(url, usuario, senhaBD);

        String sql = "SELECT nome, email FROM usuarios WHERE email = ?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setString(1, emailSessao);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            nome = rs.getString("nome") != null ? rs.getString("nome") : "";
            emailSessao = rs.getString("email");
        }

        rs.close();
        stmt.close();
        conexao.close();
    } catch (Exception e) {
        out.println("Erro ao buscar dados do usuário: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clínica Veterinária</title>
    <link rel="stylesheet" href="telaLoginSucesso.css">
    
    <!-- Google Fonts: Dancing Script -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400..700&display=swap" rel="stylesheet">
  <!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Bundle com Popper (necessário para dropdown funcionar) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>

</head>

<script>
  function togglePerfil() {
    const dropdown = document.getElementById('perfilDropdown');
    dropdown.classList.toggle('d-none');
  }

  // Fecha o menu se clicar fora
  window.addEventListener('click', function (e) {
    const dropdown = document.getElementById('perfilDropdown');
    const avatar = document.querySelector('.avatar');
    if (!dropdown.contains(e.target) && !avatar.contains(e.target)) {
      dropdown.classList.add('d-none');
    }
  });
</script>


    <body>
        
         <script>
    // Função para alternar a visibilidade do menu
    function toggleNav() {
      document.querySelector("nav").classList.toggle("active");
    }
  </script>
  
  
  
        <script src="js/jquery-3.7.1.min.js"></script>
        <script src="boostrap.min.js"></script>
        <a href="https://wa.me/5511953423838" class="whatsapp-float" target="_blank">
    <img src="https://cdn-icons-png.flaticon.com/512/733/733585.png" alt="WhatsApp" />
</a>
     <!-- Nav com botão hamburguer para telas menores -->
<header>
    <div class="nav-conteudo">
        <img src="imgs_inicio/logo-ain.png" alt="Logo Clínica" class="logo-hattori">
     <nav>
    <div class="menu-toggle" onclick="toggleNav()">?</div>

    <a href="#quem-somos" class="quem">Home</a>
    <a href="#sobre-nos" class="nos">Sobre nós</a>
    <a href="#vacinas" class="vacinas">Serviços</a>
    <a href="#contato" class="contato">Contato</a>
    <div>
        <p class="clinica">Clínica</p>
        <p class="veterinaria">Veterinária</p>
        <p class="motivacao">Seu Pet Sempre<br>Bem e Saudável</p>
    </div>
 <div class="dropdown">
  <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="dropdownUser" data-bs-toggle="dropdown" aria-expanded="false">
    <img src="imagens/usuario.png" alt="Usuário" class="avatar rounded-circle" width="40" height="40">
  </a>
  <ul class="dropdown-menu dropdown-menu-end text-small shadow" aria-labelledby="dropdownUser">
    <li class="text-center px-3 py-2">
      <img src="imagens/usuario.png" alt="Usuário" class="avatar-grande rounded-circle mb-2" width="60" height="60">
      <h6 class="mb-0"><%= nome %></h6>
      <p class="text-muted small mb-0"><%= emailSessao %></p>
    </li>
    <li><hr class="dropdown-divider"></li>
    <li><a class="dropdown-item" href="minhaConta.jsp">Ver Perfil</a></li>
    <li><a class="dropdown-item text-danger" href="logout.jsp">Sair</a></li>
  </ul>
</div>

</div>

    
</nav>

    </div>
</header>


        <main>
            <div class="quadrado-verde">
                <div class="doutora">
                    <img src="imgs_inicio/doutora.jpeg" alt="Doutora" />
                </div>
            </div>
            

            <section class="sobre-clinica">
               
                    <h2 class="h2-">Dra. Ananda Hattori Rodrigues</h2>
                    <h2 class="h2-titulo"> Médica Veterinária<br> Em São Paulo</h2>
                    
                    <div class="sobre-caixa">
                        
                        <p class="p-">
                       
                         Oferecemos atendimento especializado 
                         para o seu pet,<br> com carinho e profissionalismo.
                         A saúde e o bem-estar<br> do seu animalzinho
                         estão em boas mãos!

                        </p>
                        <img src="imgs_inicio/pata.png" alt="Ícone pata" class="pata-icone">
                    </div>
                
            </section>
      <section class="bloco-cuidado">
  <div class="container-texto">
    <div class="icone-pata">?</div>
    <h1>Cuidado de qualidade para os pets e aqueles divertidos cones de pescoço também.</h1>
    <p>Tratamos seu pet com carinho, atenção e dedicação. Utilizamos as técnicas mais modernas para garantir a saúde e o bem-estar de cada animal. Atendimento acolhedor e totalmente confiável.</p>
    <p><strong>Serviço personalizado para cada pet.</strong><br>
    Oferecemos diagnósticos precisos e tratamentos eficazes, com profissionais altamente qualificados que cuidam de seu amigo com o respeito que ele merece. Seu pet estará sempre em boas mãos.</p>
  </div>
  <div class="imagem-dog">
    <img src="imgs_inicio/image-removebg-preview.png" alt="dog sentado bonitinho">
   
  </div>
</section>

            <section class="servicos">
  <div class="texto-esquerda">
    <h4>Clínica Pet & Internação</h4>
    <h2>Nossos Serviços</h2>
  </div>
  <div class="texto-direita">
    <p>
      Na nossa clínica, oferecemos uma gama completa de serviços veterinários para garantir a saúde e o bem-estar do seu pet. Com uma equipe especializada e equipamentos de última geração, estamos prontos para atender todas as necessidades do seu animal, desde consultas de rotina até procedimentos mais complexos.
    </p>
  </div>
</section>
            
            <section class="servicos-pet">

  <div class="cards-servicos">
    <!-- Card 1 -->
    <div class="card-servico">
      <div class="img-servico">
        <img src="imgs_inicio/cachorro coracao.jpeg" alt="Consulta cachorro">
      </div>
      <h3>Clínica Geral</h3>
      <p>Consultas e atendimentos para todas as necessidades de saúde do seu pet. Realizamos diagnósticos e tratamentos com precisão e carinho.</p>
    </div>

    <!-- Card 2 -->
    <div class="card-servico ">
      <div class="img-servico">
          <img src="imgs_inicio/dogzin.jpeg" alt="Vacinação cachorro">
      </div>
      <h3>Vacinas</h3>
      <p>Vacinação de rotina para garantir a proteção do seu animal contra diversas doenças.</p>
    </div>

    <!-- Card 3 -->
    <div class="card-servico">
      <div class="img-servico">
          <img src="imgs_inicio/cachorro-vascina.jpeg" alt="Consulta gato"/>
      </div>
      <h3>Clínica Para Gatos</h3>
      <p>Cuidado especializado para felinos, com atendimentos voltados às necessidades dessa espécie.</p>
    </div>
  </div>
</section>
            
            <section class="secao-servicos-extra">
  <div class="container-cards-extra">
    <!-- Card 1 -->
    <div class="box-servico-extra">
      <img src="imgs_inicio/cirurgia.jpeg" alt="Cirurgia Veterinária" class="imagem-extra">
      <h3 class="titulo-extra">Cirurgia De Alta Complexidade</h3>
      <p class="descricao-extra">Realizamos procedimentos cirúrgicos complexos com a mais alta tecnologia e cuidado para o seu animal.</p>
    </div>

    <!-- Card 2 -->
    <div class="box-servico-extra">
      <img src="imgs_inicio/exames.jpeg" alt="Exames Veterinários" class="imagem-extra">
      <h3 class="titulo-extra">Exames</h3>
      <p class="descricao-extra">Exames laboratoriais e de imagem para diagnósticos rápidos e eficazes.</p>
    </div>

    <!-- Card 3 -->
    <div class="box-servico-extra">
      <img src="imgs_inicio/microchip.jpeg" alt="Microchip em Pet" class="imagem-extra">
      <h3 class="titulo-extra">Microchip</h3>
      <p class="descricao-extra">Implante de microchip para identificação do seu animal de estimação, proporcionando segurança e rastreabilidade em caso de perda.</p>
    </div>
  </div>
</section>

            <section class="sobre-ananda">
    <div class="conteudo-sobre">
        <div class="img-sobre">
            <img src="imgs_inicio/ananda.jpeg" alt="Dra. Ananda Hattori">
        </div>
        <div class="texto-sobre">
            <h4>Sobre mim</h4>
            <h2>Experiência E Dedicação À Vida Animal</h2>
          <div class="paragrafos-lado-a-lado">
        <p>
            Olá, sou a Dra. Ananda Hattori, e minha vida é dedicada ao cuidado e bem-estar dos animais.
            Desde pequena, sempre soube que queria ser médica veterinária, e essa paixão me guiou por toda a minha jornada educacional e profissional.
        </p>
        <p>
            Mestre pela USP, professora e cirurgiã no Veros Hospital, ofereço um atendimento especializado e humanizado.
            Meu compromisso é com a saúde e bem-estar dos animais, garantindo tratamentos modernos e eficientes.
        </p>
    </div>
          <div class="logo-sobre">
            <img src="imgs_inicio/logo-ain.png" alt="Dra. Ananda Hattori">
        </div>
        </div>
    </div>
</section>
        </main>

        <footer class="footer">
            <div class="footer-left">
                <h2>Sobre nós</h2>
                <p>Petcare@gmail.com</p>
                <p>Horário: Segunda a sexta, das 8h às 18h</p>
                <p>Sábado, das 8h às 12h</p>
            </div>

            <div class="pata">
                <img src="imgs_inicio/pata.png" alt=""/>
            </div>

            <div class="footer-right">
                <p>www.site.com</p>
                <p>@clinica_veterinaria</p>
                <p>(11) 96389-2769</p>
                <p>R. Limeira dos Anjos Nº75</p>
            </div>
        </footer>   

        <div class="footer-copy">
            <p>&copy; 2025 Clínica Veterinária. Todos os direitos reservados.</p>
        </div>
     <script>
function togglePerfil() {
    const dropdown = document.getElementById("perfilDropdown");
    dropdown.classList.toggle("d-none");
}
</script>

    </body>
</html>