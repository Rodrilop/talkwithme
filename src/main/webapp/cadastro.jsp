<%-- 
    Document   : cadastro
    Created on : 21 de set. de 2021, 22:06:57
    Author     : birse
--%>


<%@page import="java.util.ArrayList"%>
<%@page import="com.User"%>
<%@page import="com.DbListener"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String requestError = null;
    ArrayList<User> users = new ArrayList<>();
    try {
        if (request.getParameter("insert") != null) {
            String login = request.getParameter("login");
            String name = request.getParameter("name");
            String role = request.getParameter("tipo_cliente");
            String senha = request.getParameter("senha");
            String email = request.getParameter("email");
            String telefone = request.getParameter("telefone");
            String cep = request.getParameter("cep");
            String rua = request.getParameter("rua");
            String complemento = request.getParameter("complemento");
            String bairro = request.getParameter("bairro");
            String cidade = request.getParameter("Cidade");
            String estado = request.getParameter("UF");
            String tipo_cliente = request.getParameter("tipo_cliente");
            User.insertUser(login, name, role, senha, email, telefone, cep, rua, complemento, bairro, cidade, estado, tipo_cliente);
            response.sendRedirect(request.getRequestURI());
        } else if (request.getParameter("delete") != null) {
            String login = request.getParameter("login");
            User.deleteUser(login);
            response.sendRedirect(request.getRequestURI());
        }
       // users = User.getUsers();
    } catch (Exception ex) {
        requestError = ex.getMessage();
    }
%>
<html>
    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="src/img/twm.png">
        <title>Cadastro</title>
        <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <!-- JavaScript Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="src/style.css"/>
 
    <!-- Adicionando JQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>

    <!-- Adicionando Javascript -->
    <script>
        $(document).ready(function() {
            function limpa_formulário_cep() {
                // Limpa valores do formulário de cep.
                $("#rua").val("");
                $("#bairro").val("");
                $("#cidade").val("");
                $("#uf").val("");
            }
            
            //Quando o campo cep perde o foco.
            $("#cep").blur(function() {
                //Nova variável "cep" somente com dígitos.
                var cep = $(this).val().replace(/\D/g, '');
                //Verifica se campo cep possui valor informado.
                if (cep != "") {
                    //Expressão regular para validar o CEP.
                    var validacep = /^[0-9]{8}$/;
                    //Valida o formato do CEP.
                    if(validacep.test(cep)) {
                        //Preenche os campos com "..." enquanto consulta webservice.
                        $("#rua").val("...");
                        $("#bairro").val("...");
                        $("#cidade").val("...");
                        $("#uf").val("...");
                        //Consulta o webservice viacep.com.br/
                        $.getJSON("https://viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {
                            if (!("erro" in dados)) {
                                //Atualiza os campos com os valores da consulta.
                                $("#rua").val(dados.logradouro);
                                $("#bairro").val(dados.bairro);
                                $("#cidade").val(dados.localidade);
                                $("#uf").val(dados.uf);
                            } //end if.
                            else {
                                //CEP pesquisado não foi encontrado.
                                limpa_formulário_cep();
                                alert("CEP não encontrado.");
                            }
                        });
                    } //end if.
                    else {
                        //cep é inválido.
                        limpa_formulário_cep();
                        alert("Formato de CEP inválido.");
                    }
                } //end if.
                else {
                    //cep sem valor, limpa formulário.
                    limpa_formulário_cep();
                }
            });
        });
    </script>   

    <body>
        <%@include file="META-INF/jspf/header.jspf"%>
        <header>
           <div id="cadastro-container">
            <h1>Cadastro de Usuário</h1>
            <form method="post">
                <ul class="cadastro-usuario">
                    <li>
                        <label>
                            Login: &nbsp;&nbsp;&nbsp;<input type="text" class="form-control col-8" placeholder="Nome" id="nome" name="login">
                        </label>
                    </li>
                                        <li>
                        <label>
                            Senha: &nbsp;&nbsp;&nbsp;<input type="text" class="form-control col-8" placeholder="Nome" id="nome" name="senha">
                        </label>
                    </li>
                    <li>
                        <label>
                            Nome: &nbsp;&nbsp;&nbsp;<input type="text" class="form-control col-8" placeholder="Nome" id="nome" name="name">
                        </label>
                    </li>
                    <li>
                        <label>
                            Email:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="text" class="form-control col-8" placeholder="Email" id="email" name="email">
                        </label>
                    </li>
                    <li>
                        <label>
                            Telefone: <input type="text" class="form-control col-8" placeholder="Telefone" id="telefone" name="telefone">
                        </label>
                    </li>
                    
                    <li>
                        Endereço: 
                    </li>
                    <li>
                        <label>CEP: &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="form-control col-8" placeholder="CEP" id="cep" value="" size="10" maxlength="9"
               onblur="pesquisacep(this.value);" name="cep"/>
                    </li>
                    <li>
                        <label>Rua: &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="form-control col-8" placeholder="Logradouro" id="rua" name="rua"></label> 
                        <input type="text" class="form-control col-4" placeholder="Número" id="numero" name="numero">
                        &nbsp;<label>Complemento: <input type="text" class="form-control col-4" placeholder="Apto/Bloco" id="complemento" name="complemento"></label>
                    </li>
                    <li>
                        <label>Bairro: &nbsp;<input type="text" class="form-control " placeholder="Bairro" id="bairro"  name="bairro"></label>
                    </li>
                    <li>
                        <label>Cidade: <input class="form-control " type="text" name="Cidade" id="cidade" placeholder="Cidade" ></label>
                    </li>
                    <li>
                        <label>Estado: <input  class="form-control " type="text" name="UF" id="estado" placeholder="Estado" name="estado"></label>
                    </li>
                    <li>
                        <label for="cliente" class="radio-button"><input type="radio"  value="cliente" id="cliente" name="tipo_cliente"> Cliente</label>
                        <label for="terceiro" class="radio-button"><input type="radio" value="terceiro" id="terceiro" name="tipo_cliente"> Terceiro</label>
                    </li>
                    <li>
                        <input type="submit" value="Cadastrar" name="insert"/>
                    </li>
                </ul>
            </form>
             </div>
        </header>
    </body>
</html>