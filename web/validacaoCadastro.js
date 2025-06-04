document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("cadastro-form").addEventListener("submit", function (event) {
        let senha = document.getElementById("senhaUsuario").value;
        let confirmarSenha = document.getElementById("confirm-password").value;
        let erroSenha = document.getElementById("erro-senha");
        let erroConfirmarSenha = document.getElementById("erro-confirmar-senha");
        const rgDono = document.getElementById("rg_dono"); 
        const erroRG = document.getElementById("erro-rg"); 

        // Resetando mensagens de erro
        erroSenha.innerHTML = "";
        erroConfirmarSenha.textContent = "";
        erroRG.textContent = "";

        // Função para validar RG
        function validarRG(rg) {
            if (rg.length < 8 || rg.length > 9) return false;

            let soma = 0;
            let multiplicador = rg.length + 1;

            for (let i = 0; i < rg.length - 1; i++) {
                soma += parseInt(rg.charAt(i)) * multiplicador;
                multiplicador--;
            }

            let resto = soma % 11;
            let digitoVerificador = resto < 2 ? 0 : 11 - resto;

            return digitoVerificador === parseInt(rg.charAt(rg.length - 1));
        }

        let formValido = true;
        let erros = [];

        // 🔒 Validação RG
        const rgValor = rgDono.value.trim();
        if (!/^\d{8,9}$/.test(rgValor)) {
            erroRG.textContent = "O RG deve conter entre 8 e 9 dígitos numéricos.";
            erroRG.style.display = "block";
            formValido = false;
        } else if (!validarRG(rgValor)) {
            erroRG.textContent = "RG inválido.";
            erroRG.style.display = "block";
            formValido = false;
        }

        // Verificação de senha
        if (senha.length < 8) erros.push("A senha deve ter pelo menos 8 caracteres.");
        if (!/[A-Z]/.test(senha)) erros.push("A senha deve conter pelo menos uma letra maiúscula.");
        if (!/\d/.test(senha)) erros.push("A senha deve conter pelo menos um número.");
        if (!/[\W_]/.test(senha)) erros.push("A senha deve conter pelo menos um caractere especial.");

        if (erros.length > 0) {
            erros.forEach(erro => {
                let li = document.createElement("li");
                li.textContent = erro;
                erroSenha.appendChild(li);
            });
            erroSenha.style.display = "block";
            formValido = false;
        }

        if (senha !== confirmarSenha) {
            erroConfirmarSenha.textContent = "As senhas não correspondem.";
            erroConfirmarSenha.style.display = "block";
            formValido = false;
        }

        if (!formValido) {
            event.preventDefault();
        }
    });
});
