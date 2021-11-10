<%-- 
    Document   : nova-senha
    Created on : 12 de jun. de 2021, 19:49:36
    Author     : RodrigoLopes
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String requestError = null;
    try {
        if (request.getParameter("novaSenha") != null) {
            String email = request.getParameter("email");
            String novaSenha1 = request.getParameter("novaSenha1");
            String novaSenha2 = request.getParameter("novaSenha2");
            if (!novaSenha1.equals(novaSenha2)) {
                requestError = "Confirmação de nova senha inválida";
            } else {
                User.novaSenha(email, novaSenha1);
                response.sendRedirect("users.jsp");
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
        <title>Alterar Senha</title>
        <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
        <!-- JavaScript Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="src/style.css"/>
    
   </head>
    <body>
        <%@include file="META-INF/jspf/header.jspf" %>
        <div id="login-container">
        <h2>Esqueci Senha</h2>
        <fieldset>
            <form method="post">
                <%if (requestError != null) {%>
                <div style="color: red"><%= requestError%></div>
                <%}%>
               <p> 
                    <label for="senha">Nova Senha</label>
                    <input type="password" name="novaSenha1" placeholder="Digite nova senha"/>
               </p>
               <p> 
                    <label for="senha">Confirmação da nova senha:</label>
                    <input type="password" name="novaSenha2" placeholder="Confirme sua nova senha"/>
               </p>
                <input type="submit" name="novaSenha" value="Alterar senha"/>
            </form>
        </fieldset>
        <%}%>
        </div>
    </body>
</html>