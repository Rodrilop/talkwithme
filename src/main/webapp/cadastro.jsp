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
            String numero = request.getParameter("numero");
            String complemento = request.getParameter("complemento");
            String bairro = request.getParameter("bairro");
            String cidade = request.getParameter("Cidade");
            String estado = request.getParameter("UF");
            String tipo_cliente = request.getParameter("tipo_cliente");
            User.insertUser(login, name, role, senha, email, telefone, cep, rua, numero, complemento, bairro, cidade, estado, tipo_cliente);
            response.sendRedirect("index.jsp");
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
        $(document).ready(function () {
            function limpa_formul??rio_cep() {
                // Limpa valores do formul??rio de cep.
                $("#rua").val("");
                $("#bairro").val("");
                $("#cidade").val("");
                $("#uf").val("");
            }

            //Quando o campo cep perde o foco.
            $("#cep").blur(function () {
                //Nova vari??vel "cep" somente com d??gitos.
                var cep = $(this).val().replace(/\D/g, '');
                //Verifica se campo cep possui valor informado.
                if (cep != "") {
                    //Express??o regular para validar o CEP.
                    var validacep = /^[0-9]{8}$/;
                    //Valida o formato do CEP.
                    if (validacep.test(cep)) {
                        //Preenche os campos com "..." enquanto consulta webservice.
                        $("#rua").val("...");
                        $("#bairro").val("...");
                        $("#cidade").val("...");
                        $("#uf").val("...");
                        //Consulta o webservice viacep.com.br/
                        $.getJSON("https://viacep.com.br/ws/" + cep + "/json/?callback=?", function (dados) {
                            if (!("erro" in dados)) {
                                //Atualiza os campos com os valores da consulta.
                                $("#rua").val(dados.logradouro);
                                $("#bairro").val(dados.bairro);
                                $("#cidade").val(dados.localidade);
                                $("#uf").val(dados.uf);
                            } //end if.
                            else {
                                //CEP pesquisado n??o foi encontrado.
                                limpa_formul??rio_cep();
                                alert("CEP n??o encontrado.");
                            }
                        });
                    } //end if.
                    else {
                        //cep ?? inv??lido.
                        limpa_formul??rio_cep();
                        alert("Formato de CEP inv??lido.");
                    }
                } //end if.
                else {
                    //cep sem valor, limpa formul??rio.
                    limpa_formul??rio_cep();
                }
            });
        });
    </script>

    <script>
        function validarFormulario() {
            alert('Usu??rio cadastrado com Sucesso!');
        }
    </script>

    <body>
        <%@include file="META-INF/jspf/header.jspf"%>
        <header>
            <div id="cadastro-container">
                <h1>Cadastro de Usu??rio</h1>
                <form onsubmit="return validarFormulario()" method="post">
                    <div class="cadastro-usuario">
                        <p>
                            <label>
                                Login: &nbsp;&nbsp;&nbsp;<input type="text" class="form-control col-8" placeholder="Login" id="nome" name="login" required="required">
                            </label>
                        </p>
                        <p>
                            <label>
                                Senha: &nbsp;&nbsp;&nbsp;<input type="password" class="form-control col-8" placeholder="Senha" id="senha" name="senha" required="required">
                            </label>
                        </p>
                        <p>
                            <label>
                                Nome: &nbsp;&nbsp;&nbsp;<input type="text" class="form-control col-8" placeholder="Nome" id="nome" name="name" required="required">
                            </label>
                        </p>
                        <p>
                            <label>
                                Email:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="text" class="form-control col-8" placeholder="Email" id="email" name="email" required="required">
                            </label>
                        </p>
                        <p>
                            <label>
                                Telefone: <input type="text" class="form-control col-8" placeholder="Telefone" id="telefone" name="telefone" required="required">
                            </label>
                        </p>

                        <p>
                            <b>Endere??o: </b>
                        </p>
                        <p>
                            <label>CEP: &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="form-control col-8" placeholder="CEP" id="cep" value="" size="10" maxlength="9"
                                                                       onblur="pesquisacep(this.value);" name="cep" required="required"/>
                        </p>
                        <p>
                            <label>Rua: &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="form-control col-8" placeholder="Rua" id="rua" name="rua" readonly></label> 
                            <label>Numero: <input type="text" class="form-control col-4" placeholder="N??mero" id="numero" name="numero" required="required"></label>
                            <label>Complemento: <input type="text" class="form-control col-4" placeholder="Apto/Bloco" id="complemento" name="complemento"></label>
                        </p>
                        <p>
                            <label>Bairro: &nbsp;<input type="text" class="form-control " placeholder="Bairro" id="bairro"  name="bairro" readonly required="required"></label>
                        </p>
                        <p>
                            <label>Cidade: <input class="form-control " type="text" name="Cidade" id="cidade" placeholder="Cidade" readonly required="required"></label>
                        </p>
                        <p>
                            <label>Estado: <input  class="form-control " type="text" name="UF" id="uf" placeholder="Estado" readonly required="required"></label>
                        </p>
                        <p>
                            <label for="cliente" class="radio-button"><input type="radio"  value="cliente" id="cliente" name="tipo_cliente"> Cliente</label>
                            <label for="prestador" class="radio-button"><input type="radio" value="prestador" id="prestado" name="tipo_cliente"> Prestador</label>
                        </p>
                        <p>
                            <input type="submit" value="Cadastrar" name="insert"/>
                        </p>
                    </div>
                </form>
            </div>
        </header>
    </body>
</html>