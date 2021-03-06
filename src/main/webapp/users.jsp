<%-- 
    Document   : users
    Created on : 14 de jun. de 2021, 16:30:56
    Author     : RodrigoLopes
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String requestError = null;
    ArrayList<User> users = new ArrayList<>();
    try {
            if (request.getParameter("insert") != null) {
            response.sendRedirect("cadastro.jsp");
    
    } else if (request.getParameter("delete") != null) {
            String login = request.getParameter("login");
            User.deleteUser(login);
            response.sendRedirect(request.getRequestURI());
        }
        users = User.getUsers();
    } catch (Exception ex) {
        requestError = ex.getMessage();
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuários</title>
        <link rel="icon" href="src/img/twm.png">
        <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <!-- JavaScript Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="src/style.css"/>
    </head>
    <body>
        <%@include file="META-INF/jspf/header.jspf" %>
        <h2>Usuários</h2>
        <%if (requestError != null) {%>
        <div style="color: red"><%= requestError%></div>
        <%}%>

        <%if (session.getAttribute("user.login") == null) {%>
        <div>Página restrita a usuários logados</div>
        <%} else if (!session.getAttribute("user.role").equals("ADM")) {%>
        <div>Página restrita a administradores</div>

       <%} else if (request.getParameter("preparedelete") != null) {%>

        <fieldset>
            <legend>Remover Usuário</legend>
            <form method="post">
                <div align="center" class="container col-2">
                Remover o registro <%= request.getParameter("login")%>?
                <input type="hidden" name="login" value="<%= request.getParameter("login")%>"/>
                  <input type="submit" name="delete" value="Remover"/>
                &nbsp;&nbsp;&nbsp;
                <input type="submit" name="cancel" value="Cancelar"/>
                </div>
            </form>
                 <%} else {%>      
        </fieldset>
        <hr/>
            <div class="container col-2">
                <input type="submit"  name="insert" value="Cadastrar"/>
        </div>
        <div class="container">
        <div class="row">
        <div class="table-responsive">
            <table id="users" class="table table-striped table-hover table-sm table-condensed" style="width:100%">
              <thead>
                <tr>
                <th>Login</th>
                <th>Name</th>
                <th>Role</th>
                <th>Email</th>
                <th>Telefone</th>
                <th>CEP</th>
                <th>Rua</th>
                <th>Número</th>
                <th>Complemento</th>
                <th>Bairro</th>
                <th>Cidade</th>
                <th>Estado</th>
                <th>Tipo Cliente</th>
                <th>Exclusão</th>
            </tr>
            </thead>
            <tbody>
            <%for (User user : users) {%>
            <tr>
                <td><%= user.getLogin()%></td>
                <td><%= user.getName()%></td>
                <td><%= user.getRole()%></td>
                <td><%= user.getEmail()%></td>
                <td><%= user.getTelefone()%></td>
                <td><%= user.getCep()%></td>
                <td><%= user.getRua()%></td>
                <td><%= user.getNumero()%></td>
                <td><%= user.getComplemento()%></td>
                <td><%= user.getBairro()%></td>
                <td><%= user.getCidade()%></td>
                <td><%= user.getEstado()%></td>
                <td><%= user.getTipo_cliente()%></td>
                <td>
                    <form method="post">
                        <input type="hidden" name="login" value="<%= user.getLogin()%>"/>
                        <input type="submit" name="preparedelete" value="Excluir"/>
                    </form>
                </td>
            </tr>
            <%}%>
                        </tbody>
        </table>
        </div>
        </div>
        </div>
        <%}%>
            

        <link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap5.min.css">
        
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap5.min.js"></script>
        

        <script>
            $(document).ready(function () {
                $('#users').DataTable({
                    "language": {
                        "lengthMenu": "Mostrando _MENU_ registros por página",
                        "zeroRecords": "Nada encontrado",
                        "info": "Mostrando página _PAGE_ de _PAGES_",
                        "infoEmpty": "Nenhum registro encontrado",
                        "infoFiltered": "(filtrando de  _MAX_ registros no total)",
                        "search":"Procurar",
                        "paginate": {
                            "next": "Próximo",
                            "previous": "Anterior",
                            "first": "Primeiro",
                            "last": "Último"
                        }
                    }
                });
            });
        </script>
    </body>
</html>
