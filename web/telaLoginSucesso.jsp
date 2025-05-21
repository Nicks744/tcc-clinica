<%
    HttpSession sessao = request.getSession(false); // n�o cria nova sess�o

    if (sessao == null || sessao.getAttribute("usuarioLogado") == null) {
        response.sendRedirect("telaLogin.html"); // redireciona se n�o estiver logado
        return;
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cl�nica Veterin�ria</title>
    <link rel="stylesheet" href="telaLoginSucesso.css">
    
    <!-- Google Fonts: Dancing Script -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400..700&display=swap" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous"><!-- comment -->
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
    // Fun��o para alternar a visibilidade do menu
    function toggleNav() {
      document.querySelector("nav").classList.toggle("active");
    }
  </script>
  
  
  
        <script src="js/jquery-3.7.1.min.js"></script>
        <script src="boostrap.min.js"></script>
        <a href="https://wa.me/5511953423838" class="whatsapp-float" target="_blank">
    <img src="https://cdn-icons-png.flaticon.com/512/733/733585.png" alt="WhatsApp" />
</a>
     <!-- Nav com bot�o hamburguer para telas menores -->
<header>
    <div class="nav-conteudo">
        <img src="imgs_inicio/logo-ain.png" alt="Logo Cl�nica" class="logo-hattori">
     <nav>
    <div class="menu-toggle" onclick="toggleNav()">?</div>

    <a href="#quem-somos" class="quem">Home</a>
    <a href="#sobre-nos" class="nos">Sobre n�s</a>
    <a href="#vacinas" class="vacinas">Servi�os</a>
    <a href="#contato" class="contato">Contato</a>
    <div>
        <p class="clinica">Cl�nica</p>
        <p class="veterinaria">Veterin�ria</p>
        <p class="motivacao">Seu Pet Sempre<br>Bem e Saud�vel</p>
    </div>
    
   <div class="perfil-container">
  <img src="usuario.jpg" alt="Usu�rio" class="avatar" onclick="togglePerfil()" />
  <div id="perfilDropdown" class="perfil-dropdown d-none">
    <img src="usuario.jpg" alt="Usu�rio" class="avatar-grande">
    <h6>Nome do Usu�rio</h6>
    <p class="text-muted">email@exemplo.com</p>
    <a href="minhaConta.jsp" class="btn btn-primary btn-sm w-100">Ver Perfil</a>
    <a href="logout.jsp" class="btn btn-outline-danger btn-sm mt-2 w-100">Sair</a>
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
                    <h2 class="h2-titulo"> M�dica Veterin�ria<br> Em S�o Paulo</h2>
                    
                    <div class="sobre-caixa">
                        
                        <p class="p-">
                       
                         Oferecemos atendimento especializado 
                         para o seu pet,<br> com carinho e profissionalismo.
                         A sa�de e o bem-estar<br> do seu animalzinho
                         est�o em boas m�os!

                        </p>
                        <img src="imgs_inicio/pata.png" alt="�cone pata" class="pata-icone">
                    </div>
                
            </section>
      <section class="bloco-cuidado">
  <div class="container-texto">
    <div class="icone-pata">?</div>
    <h1>Cuidado de qualidade para os pets e aqueles divertidos cones de pesco�o tamb�m.</h1>
    <p>Tratamos seu pet com carinho, aten��o e dedica��o. Utilizamos as t�cnicas mais modernas para garantir a sa�de e o bem-estar de cada animal. Atendimento acolhedor e totalmente confi�vel.</p>
    <p><strong>Servi�o personalizado para cada pet.</strong><br>
    Oferecemos diagn�sticos precisos e tratamentos eficazes, com profissionais altamente qualificados que cuidam de seu amigo com o respeito que ele merece. Seu pet estar� sempre em boas m�os.</p>
  </div>
  <div class="imagem-dog">
    <img src="imgs_inicio/image-removebg-preview.png" alt="dog sentado bonitinho">
   
  </div>
</section>

            <section class="servicos">
  <div class="texto-esquerda">
    <h4>Cl�nica Pet & Interna��o</h4>
    <h2>Nossos Servi�os</h2>
  </div>
  <div class="texto-direita">
    <p>
      Na nossa cl�nica, oferecemos uma gama completa de servi�os veterin�rios para garantir a sa�de e o bem-estar do seu pet. Com uma equipe especializada e equipamentos de �ltima gera��o, estamos prontos para atender todas as necessidades do seu animal, desde consultas de rotina at� procedimentos mais complexos.
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
      <h3>Cl�nica Geral</h3>
      <p>Consultas e atendimentos para todas as necessidades de sa�de do seu pet. Realizamos diagn�sticos e tratamentos com precis�o e carinho.</p>
    </div>

    <!-- Card 2 -->
    <div class="card-servico ">
      <div class="img-servico">
          <img src="imgs_inicio/dogzin.jpeg" alt="Vacina��o cachorro">
      </div>
      <h3>Vacinas</h3>
      <p>Vacina��o de rotina para garantir a prote��o do seu animal contra diversas doen�as.</p>
    </div>

    <!-- Card 3 -->
    <div class="card-servico">
      <div class="img-servico">
          <img src="imgs_inicio/cachorro-vascina.jpeg" alt="Consulta gato"/>
      </div>
      <h3>Cl�nica Para Gatos</h3>
      <p>Cuidado especializado para felinos, com atendimentos voltados �s necessidades dessa esp�cie.</p>
    </div>
  </div>
</section>
            
            <section class="secao-servicos-extra">
  <div class="container-cards-extra">
    <!-- Card 1 -->
    <div class="box-servico-extra">
      <img src="imgs_inicio/cirurgia.jpeg" alt="Cirurgia Veterin�ria" class="imagem-extra">
      <h3 class="titulo-extra">Cirurgia De Alta Complexidade</h3>
      <p class="descricao-extra">Realizamos procedimentos cir�rgicos complexos com a mais alta tecnologia e cuidado para o seu animal.</p>
    </div>

    <!-- Card 2 -->
    <div class="box-servico-extra">
      <img src="imgs_inicio/exames.jpeg" alt="Exames Veterin�rios" class="imagem-extra">
      <h3 class="titulo-extra">Exames</h3>
      <p class="descricao-extra">Exames laboratoriais e de imagem para diagn�sticos r�pidos e eficazes.</p>
    </div>

    <!-- Card 3 -->
    <div class="box-servico-extra">
      <img src="imgs_inicio/microchip.jpeg" alt="Microchip em Pet" class="imagem-extra">
      <h3 class="titulo-extra">Microchip</h3>
      <p class="descricao-extra">Implante de microchip para identifica��o do seu animal de estima��o, proporcionando seguran�a e rastreabilidade em caso de perda.</p>
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
            <h2>Experi�ncia E Dedica��o � Vida Animal</h2>
          <div class="paragrafos-lado-a-lado">
        <p>
            Ol�, sou a Dra. Ananda Hattori, e minha vida � dedicada ao cuidado e bem-estar dos animais.
            Desde pequena, sempre soube que queria ser m�dica veterin�ria, e essa paix�o me guiou por toda a minha jornada educacional e profissional.
        </p>
        <p>
            Mestre pela USP, professora e cirurgi� no Veros Hospital, ofere�o um atendimento especializado e humanizado.
            Meu compromisso � com a sa�de e bem-estar dos animais, garantindo tratamentos modernos e eficientes.
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
                <h2>Sobre n�s</h2>
                <p>Petcare@gmail.com</p>
                <p>Hor�rio: Segunda a sexta, das 8h �s 18h</p>
                <p>S�bado, das 8h �s 12h</p>
            </div>

            <div class="pata">
                <img src="imgs_inicio/pata.png" alt=""/>
            </div>

            <div class="footer-right">
                <p>www.site.com</p>
                <p>@clinica_veterinaria</p>
                <p>(11) 96389-2769</p>
                <p>R. Limeira dos Anjos N�75</p>
            </div>
        </footer>   

        <div class="footer-copy">
            <p>&copy; 2025 Cl�nica Veterin�ria. Todos os direitos reservados.</p>
        </div>
     <script>
function togglePerfil() {
    const dropdown = document.getElementById("perfilDropdown");
    dropdown.classList.toggle("d-none");
}
</script>

    </body>
</html>