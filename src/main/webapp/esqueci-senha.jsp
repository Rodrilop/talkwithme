<%-- 
    Document   : esqueci-senha
    Created on : 22 de set. de 2021, 10:06:57
    Author     : Rodrigo
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.User"%>
<%@page import="com.DbListener"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String requestError = null;
    try {
        if (request.getParameter("esqueciSenha") != null) {
            String email = request.getParameter("email");
             if (User.getUsers() == null) {
                requestError = "Email não cadastrado";
            } else {
                User.esqueciSenha(email);
                response.sendRedirect("nova-senha.jsp");
            }
        }
    } catch (Exception ex) {
        requestError = ex.getMessage();
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="src/img/twm.png">
        <title>Esqueci Senha</title>
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
                <form method="post">
                    <h1>Esqueci Senha</h1> 
                <%if (requestError != null) {%>
                <div style="color: red"><%= requestError%></div>
                <%}%>
                    <p> 
                        <label for="login">Email</label>
                        <input type="text" name="user.email" required="required" placeholder="Digite seu email" autocomplete="off" /> 
                    </p>
                    <input type="submit" name="redefinirSenha" value="Enviar"/>
                </form>
            </div>
    </body>
</html>