<%-- 
    Document   : produto
    Created on : 5 de out. de 2021, 20:30:41
    Author     : Diego da Cunha Silva
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.Produto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String requestError = null;
    ArrayList<Produto> list = new ArrayList<>();
    try {
        if (request.getParameter("insert") != null) {
            String nm_produto = request.getParameter("nm_produto");
            Double peso = Double.parseDouble(request.getParameter("peso"));
            Double volume = Double.parseDouble(request.getParameter("volume"));
            Produto.insert(nm_produto, peso, volume);
            response.sendRedirect(request.getRequestURI());
        } else if (request.getParameter("delete") != null) {
            long id_produto = Long.parseLong(request.getParameter("id_produto"));
            Produto.delete(id_produto);
            response.sendRedirect(request.getRequestURI());
        } else if (request.getParameter("update") != null) {
            long id_produto = Long.parseLong(request.getParameter("id_produto"));
            Double peso = Double.parseDouble(request.getParameter("peso"));
            Double volume = Double.parseDouble(request.getParameter("volume"));
            Produto.update(id_produto, peso, volume);
            response.sendRedirect(request.getRequestURI());
        }
        list = Produto.getList();
    } catch (Exception ex) {
        requestError = ex.getMessage();
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Produtos</title>
        <link rel="icon" href="src/img/twm.png">
        <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <!-- JavaScript Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="src/style.css"/>

    </head>
    <body>
        <%@include file="META-INF/jspf/header.jspf"%>
        <h2>Produtos</h2>
        <%if (requestError != null) {%>
        <div style="color: red"><%= requestError%></div>
        <%}%>

        <%if (session.getAttribute("user.login") == null) {%>
        <div>Página restrita a usuários logados</div>
        <%} else {%>

        <%if (request.getParameter("prepareInsert") != null) {%>

        <fieldset>
            <legend>Cadastrar Produto</legend>
            <form method="post">
                <div class="container col-4">
                Nome Produto: <input type="text" name="nm_produto"/>
                Peso: <input type="text" name="peso"/>
                Volume: <input type="text" name="volume"/>
                <div class="container col-4">
                <input type="submit" name="insert" value="Incluir"/>
                <input type="submit" name="cancel" value="Cancelar"/>
                </div>
                </div>
            </form>
        </fieldset>

        <%} else if (request.getParameter("prepareUpdate") != null) {%>       

        <fieldset>
            <legend>Alterar Produto</legend>
            <% long id_produto = Long.parseLong(request.getParameter("id_produto")); %>
            <% Produto p = Produto.get(id_produto); %>
            <% if (p == null) { %>
            <div>O registro não foi encontrado.</div>
            <% } else {%>
            <form method="post">
                <div class="container col-4">
                Nome:
                <br/><input type="text" name="nm_produto" readonly value="<%= p.getNm_produto()%>"/>
                <br/>Peso:
                <br/><input type="text" name="peso" value="<%= p.getPeso()%>"/>
                <br/>Volume:
                <br/><input type="text" name="volume" value="<%= p.getVolume()%>"/>
                <input type="hidden" name="id_produto" value="<%= request.getParameter("id_produto")%>"/>
                <div class="container col-4">
                <input type="submit" name="update" value="Alterar"/>
                <input type="submit" name="cancel" value="Cancelar"/>
                </div>
                </div>
            </form>
            <% } %>
        </fieldset>

        <%} else if (request.getParameter("preparedelete") != null) {%>

        <fieldset>
            <legend>Remover Produto</legend>
            <form method="post">
                <div class="container col-4">
                Remover o registro <%= request.getParameter("id_produto")%>?
                <input type="hidden" name="id_produto" value="<%= request.getParameter("id_produto")%>"/>
                <div class="container col-4 btn-group">
                <input type="submit" name="delete" value="Remover"/>
                &nbsp;&nbsp;&nbsp;
                <input type="submit" name="cancel" value="Cancelar"/>
                </div>
                </div>
            </form>
        </fieldset>

        <%} else {%>

        <form method="post">
            <div class="container col-2">
            <input type="submit" name="prepareInsert" value="Incluir"/>
            </div>
        </form>

        <%}%>

        <hr/>
        <div class="container">
        <div class="row">
        <div class="table-responsive">
            <table id="produtos" class="table table-striped table-hover table-sm">
                <thead>
            <tr>
                <th scope="col">ID</th>
                <th scope="col">Nome Produto</th>
                <th scope="col">Peso</th>
                <th scope="col">Volume</th>
                <th scope="col">Comandos</th>
            </tr>
            </thead>
            <tbody>
            <%for (Produto p : list) {%>
            <tr>
                <td><%= p.getId_produto()%></td>
                <td><%= p.getNm_produto()%></td>
                <td><%= p.getPeso()%></td>
                <td><%= p.getVolume()%></td>
                <td>
                    <form method="post">
                        <input type="hidden" name="id_produto" value="<%= p.getId_produto()%>"/>
                        <div class="container col-5 btn-group">
                        <input type="submit" name="prepareUpdate" value="Alterar"/>
                        &nbsp;&nbsp;&nbsp;
                        <input type="submit" name="preparedelete" value="Excluir"/>
                        </div>
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
                $('#produtos').DataTable({
                    "language": {
                        "lengthMenu": "Mostrando _MENU_ registros por página",
                        "zeroRecords": "Nada encontrado",
                        "info": "Mostrando página _PAGE_ de _PAGES_",
                        "infoEmpty": "Nenhum registro encontrado",
                        "infoFiltered": "(filtrando de  _MAX_ registros no total)",
                        "search":"Procurar"
                    }
                });
            });
        </script>
        
    </body>
</html>