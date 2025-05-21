<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*, javax.servlet.http.HttpSession" %>
<%
    HttpSession sessao = request.getSession(false);
    if (sessao == null || sessao.getAttribute("usuarioLogado") == null) {
        response.sendRedirect("telaLogin.jsp");
        return;
    }

    String emailSessao = (String) sessao.getAttribute("usuarioLogado");
    String rg = (String) sessao.getAttribute("rg"); // Aqui estamos pegando o RG da sessão

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
    <title>Minha Conta - Clínica Veterinária</title>
    <link rel="stylesheet" href="minhaConta.css">
</head>
<body>

<!-- Modal para Cadastrar Pet -->
<div id="modalCadastroPet" class="modal">
    <div class="modal-content">
        <span class="close" onclick="fecharModal('modalCadastroPet')">&times;</span>
        <h2>Cadastrar Pet</h2>
        <form action="cadastrarPet.jsp" method="POST">
            <label for="nomePet">Nome:</label>
            <input type="text" id="nomePet" name="nomePet" required><br>

            <select name="especiePet" id="especiePet" required>
                <option value="" disabled selected>Selecione a espécie</option>
                <option value="Cachorro">Cachorro</option>
                <option value="Gato">Gato</option>
                <option value="Outro">Outro</option>
            </select><br>

            <label for="racaPet">Raça:</label>
            <input type="text" id="racaPet" name="racaPet" required><br>

            <label for="idadePet">Idade:</label>
            <input type="number" id="idadePet" name="idadePet" required><br>

            <label for="sexoPet">Sexo:</label>
            <select name="sexoPet" id="sexoPet" required>
                <option value="" disabled selected>Selecione o sexo</option>
                <option value="Macho">Macho</option>
                <option value="Femea">Fêmea</option>
            </select><br>

            <button type="submit">Cadastrar</button>
        </form>
    </div>
</div>

<script>
    function abrirModal(modalId) {
        document.getElementById(modalId).style.display = "block";
    }

    function fecharModal(modalId) {
        document.getElementById(modalId).style.display = "none";
    }
</script>

<div class="container">
    <h1>Minha Conta</h1>

    <section class="user-info">
        <h2>Dados do Cliente</h2>
        <p><strong>Nome:</strong> <%= nome %></p>
        <p><strong>Email:</strong> <%= emailSessao %></p>
    </section>

    <section class="pets">
        <h2>Meus Pets</h2>
        <%
            Connection conexao2 = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conexao2 = DriverManager.getConnection(url, usuario, senhaBD);

                // Aqui a consulta agora utiliza o RG da sessão
                String sqlPets = "SELECT id, nome, especie, raca, idade, sexo FROM animais WHERE rg_dono = ?";
                PreparedStatement stmtPets = conexao2.prepareStatement(sqlPets);
                stmtPets.setString(1, rg); // Utilizando o RG da sessão
                ResultSet rsPets = stmtPets.executeQuery();

                while (rsPets.next()) {
                    int idPet = rsPets.getInt("id");
                    String nomePet = rsPets.getString("nome");
                    String especie = rsPets.getString("especie");
                    String raca = rsPets.getString("raca");
                    int idade = rsPets.getInt("idade");
                    String sexo = rsPets.getString("sexo");
        %>
            <div class="pet-card">
                <p><strong>Nome:</strong> <%= nomePet %></p>
                <p><strong>Espécie:</strong> <%= especie %></p>
                <p><strong>Raça:</strong> <%= raca %></p>
                <p><strong>Idade:</strong> <%= idade %> anos</p>
                <p><strong>Sexo:</strong> <%= sexo %></p>
                <button onclick="abrirModalEditar(<%= idPet %>, '<%= nomePet %>', '<%= especie %>', '<%= raca %>', <%= idade %>, '<%= sexo %>')">
                    Editar dados
                </button>
                    
                    <button onclick="excluirPet(<%= idPet %>, '<%= nome %>')">Excluir Pet</button>

            </div>
        <%
                }

                rsPets.close();
                stmtPets.close();
                conexao2.close();
            } catch (Exception e) {
                out.println("<p style='color: red;'>Erro ao buscar pets: " + e.getMessage() + "</p>");
            }
        %>

        <button onclick="abrirModal('modalCadastroPet')">Cadastrar novo pet</button>

    </section>

    <section class="consultas">
        <h2>Consultas Futuras</h2>
        <div class="consulta-card">
            <p><strong>Data:</strong> 20/04/2025</p>
            <p><strong>Veterinário:</strong> Dra. Camila</p>
            <p><strong>Status:</strong> Confirmada</p>
        </div>

        <h2>Histórico de Consultas</h2>
        <div class="consulta-card">
            <p><strong>Data:</strong> 15/03/2025</p>
            <p><strong>Diagnóstico:</strong> Vermifugação</p>
            <p><strong>Veterinário:</strong> Dr. Pedro</p>
        </div>
    </section>

    <div class="actions">
        <button onclick="window.location.href='logout.jsp'" class="logout">Sair da Conta</button>
    </div>
</div>

<!-- Modal para Editar Pet -->
<div id="modalEditarPet" class="modal">
    <div class="modal-content">
        <span class="close" onclick="fecharModal('modalEditarPet')">&times;</span>
        <h2>Editar Pet</h2>
        <form action="atualizarPet.jsp" method="POST">
            <input type="hidden" id="idPetEditar" name="idPet">
            <label for="nomePetEditar">Nome:</label>
            <input type="text" id="nomePetEditar" name="nomePet" required><br>

            <select name="especiePet" id="especiePetEditar" required>
                <option value="" disabled selected>Selecione a espécie</option>
                <option value="Cachorro">Cachorro</option>
                <option value="Gato">Gato</option>
                <option value="Outro">Outro</option>
            </select><br>

            <label for="racaPetEditar">Raça:</label>
            <input type="text" id="racaPetEditar" name="racaPet" required><br>

            <label for="idadePetEditar">Idade:</label>
            <input type="number" id="idadePetEditar" name="idadePet" required><br>

            <label for="sexoPetEditar">Sexo:</label>
            <select name="sexoPet" id="sexoPetEditar" required>
                <option value="" disabled selected>Selecione o sexo</option>
                <option value="Macho">Macho</option>
                <option value="Femea">Fêmea</option>
            </select><br>

            <button type="submit">Atualizar</button>
        </form>
    </div>
</div>

<script>
    function abrirModalEditar(idPet, nomePet, especiePet, racaPet, idadePet, sexoPet) {
        document.getElementById('idPetEditar').value = idPet;
        document.getElementById('nomePetEditar').value = nomePet;
        document.getElementById('especiePetEditar').value = especiePet;
        document.getElementById('racaPetEditar').value = racaPet;
        document.getElementById('idadePetEditar').value = idadePet;
        document.getElementById('sexoPetEditar').value = sexoPet;

        document.getElementById('modalEditarPet').style.display = "block";
    }
</script>

<script>
function excluirPet(idPet, nomePet) {
    if (confirm("Tem certeza que deseja excluir o pet?")) {
        // Cria um formulário invisível e envia a exclusão
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = 'excluirPet.jsp';

        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'idPet';
        input.value = idPet;

        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }
}
</script>


</body>
</html>
