<%-- 
    Document   : login
    Created on : 22 de set. de 2021, 10:06:57
    Author     : Rodrigo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="src/img/twm.png">
        <title>Login</title>
        <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
        <!-- JavaScript Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="src/style.css"/>
    </head>
    <body>
        <%@include file="META-INF/jspf/header.jspf"%>
        <header>
            <div id="login-container">
                <form method="post" action=""> 
                    <h1>Login</h1> 
                    <p> 
                        <label for="email_login">Seu e-mail</label>
                        <input id="email_login" name="email_login" required="required" placeholder="Digite seu e-mail" autocomplete="off" /> 
                    </p>
                    <p> 
                        <label for="senha">Sua senha</label>
                        <input id="senha" name="senha" required="required" type="password" placeholder="Digite sua senha"/>
                        <input type="submit" value="Acessar" />
                    <div>
                    <hr>
                    </div>
                    <p>Esqueci a senha
                        <a href="forgot.jsp" >Usuário / Senha?</a>
                    <p class="link">
                        Ainda não tem conta?
                        <a href="cadastro.jsp">Cadastre-se</a>
                </form>
            </div>
    </body>
</html>