<%-- 
    Document   : cadastro
    Created on : 21 de set. de 2021, 22:06:57
    Author     : birse
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="src/img/twm.png">
        <title>Cadastro</title>
        <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
        <!-- JavaScript Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="src/style.css"/>
        
 
    <!-- Adicionando JQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"></script>

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
        
        
    </head>
    <body>
        <%@include file="META-INF/jspf/header.jspf"%>
        <header>
           <div id="cadastro-container">
            <h1>Cadastro de Usuário</h1>
            <form action="action">
                <ul class="cadastro-usuario">
                    <li>
                        <label>
                            Nome: &nbsp;&nbsp;&nbsp;<input type="text" class="form-control col-8" placeholder="Nome" id="nome">
                        </label>
                    </li>
                    <li>
                        <label>
                            Email:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="text" class="form-control col-8" placeholder="Email" id="email">
                        </label>
                    </li>
                    <li>
                        <label>
                            Telefone: <input type="text" class="form-control col-8" placeholder="Telefone" id="telefone">
                        </label>
                    </li>
                    
                    <li>
                        Endereço: 
                    </li>
                    <li>
                        <label>CEP: &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="form-control col-8" placeholder="CEP" id="cep"value="" size="10" maxlength="9"
               onblur="pesquisacep(this.value);" />
                    </li>
                    <li>
                        <label>Rua: &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="form-control col-8" placeholder="Logradouro" id="rua" readonly></label> 
                        <input type="text" class="form-control col-4" placeholder="Número" id="numero">
                        &nbsp;<label>Complemento: <input type="text" class="form-control col-4" placeholder="Apto/Bloco" id="complemento"></label>
                    </li>
                    <li>
                        <label>Bairro: &nbsp;<input type="text" class="form-control " placeholder="Bairro" id="bairro" readonly></label>
                    </li>
                    <li>
                        <label>Cidade: <input class="form-control " type="text" name="Cidade" id="cidade" placeholder="Cidade" readonly></label>
                    </li>
                    <li>
                        <label>Estado: <input input class="form-control" type="text" id="uf"  placeholder="UF" readonly></label>
                    </li>
                    <li>
                        <label for="cliente" class="radio-button"><input type="radio" name="tipoCliente" value="cliente" id="cliente"> Cliente</label>
                        <label for="terceiro" class="radio-button"><input type="radio" name="tipoCliente" value="terceiro" id="terceiro"> Terceiro</label>
                    </li>
                    <li>
                        <input type="submit" value="Cadastrar" />
                    </li>
                </ul>
            </form>
             </div>
        </header>
    </body>
</html>
