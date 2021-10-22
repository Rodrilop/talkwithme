<%-- 
    Document   : servicos
    Created on : 5 de out. de 2021, 19:50:58
    Author     : Diego da Cunha Silva
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.Servico"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String requestError = null;
    ArrayList<Servico> list = new ArrayList<>();
    try {
        if (request.getParameter("insert") != null) {
            String nm_servico = request.getParameter("nm_servico");
            String nm_prestador = request.getParameter("nm_prestador");
            String nm_cliente = request.getParameter("nm_cliente");
            String dt_servico = request.getParameter("dt_servico");
            Servico.insert(nm_servico, nm_prestador, nm_cliente, dt_servico);
            response.sendRedirect(request.getRequestURI());
        } else if (request.getParameter("delete") != null) {
            long id_produto = Long.parseLong(request.getParameter("id_servico"));
            Servico.delete(id_produto);
            response.sendRedirect(request.getRequestURI());
        } else if (request.getParameter("update") != null) {
            long id_servico = Long.parseLong(request.getParameter("id_servico"));
            String dt_servico = request.getParameter("dt_servico");
            Servico.update(id_servico, dt_servico);
            response.sendRedirect(request.getRequestURI());
        }
        list = Servico.getList();
    } catch (Exception ex) {
        requestError = ex.getMessage();
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Serviços</title>
        <link rel="icon" href="src/img/twm.png">
        <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <!-- JavaScript Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="src/style.css"/>
        <style>
            ul{
                list-style-type: none;
                line-height: 280%
            }
            input{
                line-height: 100%
            }
        </style>
    </head>
    <body>
        <%@include file="META-INF/jspf/header.jspf"%>
        <h2>Serviços</h2>
        <%if (requestError != null) {%>
        <div style="color: red"><%= requestError%></div>
        <%}%>

        <%if (session.getAttribute("user.login") == null) {%>
        <div>Página restrita a usuários logados</div>
        <%} else {%>

        <%if (request.getParameter("prepareInsert") != null) {%>
        <fieldset>
            <legend>Cadastrar Serviço</legend>
            <form method="post">
               <div class="container col-4">
                Nome Serviço: <input type="text" name="nm_servico"/>
                Nome do Prestador <input type="text" name="nm_prestador"/>
                Nome do Cliente <input type="text" name="nm_cliente"/>
                Data do Serviço: <input type="date" name="dt_servico"/>
                <div class="container col-4">
                <input type="submit" name="insert" value="Incluir"/>
                <input type="submit" name="cancel" value="Cancelar"/>
                </div>
                </div>
            </form>
        </fieldset>
            
        <%} else if (request.getParameter("prepareUpdate") != null) {%>       

        <fieldset>
            <legend>Alterar Serviço</legend>
            <% long id_servico = Long.parseLong(request.getParameter("id_servico")); %>
            <% Servico s = Servico.get(id_servico); %>
            <% if (s == null) { %>
            <div>O registro não foi encontrado.</div>
            <% } else {%>
            <form method="post">
                <div class="container col-4">
                Nome:
                <br/><input type="text" name="nm_servico" readonly value="<%= s.getNm_servico()%>"/>
                <br/>Data do Serviço:
                <br/><input type="text" name="dt_servico" value="<%= s.getDt_servico()%>"/>
                <input type="hidden" name="id_servico" value="<%= request.getParameter("id_servico")%>"/>
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
            <legend>Remover Serviço</legend>
            <form method="post">
                <div class="container col-2">
                Remover o registro <%= request.getParameter("id_servico")%>?
                <input type="hidden" name="id_servico" value="<%= request.getParameter("id_servico")%>"/>
                <div class="container col-4">
                <input type="submit" name="delete" value="Remover"/>
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
            <table class="table table-striped table-hover table-sm">
            <tr>
                <th scope="col">ID</th>
                <th scope="col">Nome Serviço</th>
                <th scope="col">Nome do Prestador</th>
                <th scope="col">Nome do Cliente</th>
                <th scope="col">Data do Serviço</th>
                <th scope="col">Comandos</th>
            </tr>
            <%for (Servico s : list) {%>
            <tr>
                <td><%= s.getId_servico()%></td>
                <td><%= s.getNm_servico()%></td>
                <td><%= s.getNm_cliente()%></td>
                <td><%= s.getNm_prestador()%></td>
                <td><%= s.getDt_servico()%></td>
                <td>
                    <form method="post">
                        <input type="hidden" name="id_servico" value="<%= s.getId_servico()%>"/>
                        <div class="container col-8 btn-group">
                        <input type="submit" name="prepareUpdate" value="Alterar"/>
                        &nbsp;&nbsp;&nbsp;
                        <input type="submit" name="preparedelete" value="Excluir"/>
                        </div>
                    </form>
                </td>
            </tr>
            <%}%>
        </table>
        </div>
        </div>
        </div>
        <%}%>
    </body>
</html>