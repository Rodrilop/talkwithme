<%-- 
    Document   : login
    Created on : 22 de set. de 2021, 10:06:57
    Author     : Rodrigo
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String requestError = null;
    if (request.getParameter("session.login") != null) {
        String login = request.getParameter("user.login");
        String senha = request.getParameter("user.senha");
        try {
            User user = User.getUser(login, senha);
            if (user == null) {
                requestError = "Usuário e/ou senha não encontrado";
            } else {
                session.setAttribute("user.login", user.getLogin());
                session.setAttribute("user.name", user.getName());
                session.setAttribute("user.role", user.getRole());
                response.sendRedirect("index.jsp");
            }
        } catch (Exception ex) {
            requestError = ex.getMessage();
        }
    }
%>
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
                <%if (requestError != null) {%>
                <div style="color: red"><%= requestError%></div>
                <%}%>
                    <p> 
                        <label for="login">Login</label>
                        <input type="text" name="user.login" required="required" placeholder="Digite seu login" autocomplete="off" /> 
                    </p>
                    <p> 
                        <label for="senha">Sua senha</label>
                        <input type="password" name="user.senha" placeholder="Digite sua senha"/>
                    <input type="submit" name="session.login" value="Acessar"/>
                    </p>
                    <div>
                        <hr>
                    </div>
                    <p>Esqueci a senha
                        <a href="esqueci-senha.jsp" >Usuário / Senha?</a>
                    <p>
                        Ainda não tem conta?
                        <a href="cadastro.jsp">Cadastre-se</a>
                </form>
            </div>
    </body>
</html>