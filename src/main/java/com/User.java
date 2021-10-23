package com;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


import java.util.ArrayList;
import java.sql.*;

/**
 *
 * @author birse
 */
public class User {

    private String login;
    private String name;
    private String role;
    private String senha;
    private String email;
    private String telefone;
    private String cep;
    private String rua;
    private String numero;
    private String complemento;
    private String bairro;
    private String cidade;
    private String estado;
    private String tipo_cliente;

       public static ArrayList<User> getUsers() throws Exception {
        ArrayList<User> list = new ArrayList<>();
        Connection con = DbListener.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * from users ORDER BY role");
        while (rs.next()) {
            String login = rs.getString("login");
            String name = rs.getString("name");
            String role = rs.getString("role");
            String email = rs.getString("email");
            String telefone = rs.getString("telefone");
            String cep = rs.getString("cep");
            String rua = rs.getString("rua");
            String numero = rs.getString("numero");
            String complemento = rs.getString("complemento");
            String bairro = rs.getString("bairro");
            String cidade = rs.getString("cidade");
            String estado = rs.getString("estado");
            String tipo_cliente = rs.getString("tipo_cliente");
            
            list.add(new User(login, name, role, email, telefone, cep, rua, numero, complemento, bairro, cidade, estado, tipo_cliente));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }

    public static User getUser(String login, String password) throws Exception {
        User user = null;
        Connection con = DbListener.getConnection();
        String sql = "SELECT * from users WHERE login=?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, login);
        //stmt.setLong(2, password.hashCode());
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            String name = rs.getString("name");
            String role = rs.getString("role");
            user = new User(login, name, role);
        }
        rs.close();
        stmt.close();
        con.close();
        return user;
    }

    public static void insertUser(String login, String name, String role, String senha, String email, String telefone, String cep, String rua, String numero, String complemento, String bairro, String cidade, String estado, String tipo_cliente) throws Exception {
        Connection con = DbListener.getConnection();
        String sql = "INSERT INTO users(login, name, role, senha, email, telefone, cep, rua, numero, complemento, bairro, cidade, estado, tipo_cliente) "
                + "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, login);
        stmt.setString(2, name);
        stmt.setString(3, role);
        stmt.setString(4, senha);
        stmt.setString(5, email);
        stmt.setString(6, telefone);
        stmt.setString(7, cep);
        stmt.setString(8, rua);
        stmt.setString(9, numero);
        stmt.setString(10, complemento);
        stmt.setString(11, bairro);
        stmt.setString(12, cidade);
        stmt.setString(13, estado);
        stmt.setString(14, tipo_cliente);

        stmt.execute();
        stmt.close();
        con.close();
    }

    public static void deleteUser(String login) throws Exception {
        Connection con = DbListener.getConnection();
        String sql = "DELETE FROM users WHERE login = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, login);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public static void changePassword(String login, String password) throws Exception {
        Connection con = DbListener.getConnection();
        String sql = "UPDATE users SET password_hash = ? WHERE login = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setLong(1, password.hashCode());
        stmt.setString(2, login);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public User(String login, String name, String role) {
        this.login = login;
        this.name = name;
        this.role = role;
    }

    public User(String login, String name, String role, String email, String telefone, String cep, String rua, String numero, String complemento, String bairro, String cidade, String estado, String tipo_cliente) {
        this.login = login;
        this.name = name;
        this.role = role;
        this.email = email;
        this.telefone = telefone;
        this.cep = cep;
        this.rua = rua;
        this.numero = numero;
        this.complemento = complemento;
        this.bairro = bairro;
        this.cidade = cidade;
        this.estado = estado;
        this.tipo_cliente = tipo_cliente;
    }

public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    public String getRua() {
        return rua;
    }

    public void setRua(String rua) {
        this.rua = rua;
    }
        
    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getComplemento() {
        return complemento;
    }

    public void setComplemento(String complemento) {
        this.complemento = complemento;
    }

    public String getBairro() {
        return bairro;
    }

    public void setBairro(String bairro) {
        this.bairro = bairro;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getTipo_cliente() {
        return tipo_cliente;
    }

    public void setTipo_cliente(String tipo_cliente) {
        this.tipo_cliente = tipo_cliente;
    }
}
