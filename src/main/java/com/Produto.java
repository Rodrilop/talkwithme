/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import java.util.ArrayList;
import com.DbListener;
import java.sql.*;

/**
 *
 * @author RodrigoLopes
 */
public class Produto {

    private long id_produto;
    private String nm_produto;
    private double peso;
    private double volume;
       
    public static ArrayList<Produto> getList() throws Exception{
        ArrayList<Produto> list = new ArrayList<>();
        Connection con = DbListener.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM produtos ORDER BY id_produto");
        while(rs.next()){
            long id_produto = rs.getLong("id_produto");
            String nm_produto = rs.getString("nm_produto");
            double peso = rs.getDouble("peso");
            double volume = rs.getDouble("volume");
            list.add(new Produto(id_produto, nm_produto, peso, volume));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }
    
        public static Produto get(long id_produto) throws Exception{
        Produto d = null;
        Connection con = DbListener.getConnection();
        PreparedStatement stmt = con.prepareStatement("SELECT * FROM produtos WHERE id_produto = ?");
        stmt.setLong(1, id_produto);
        ResultSet rs = stmt.executeQuery();
        if(rs.next()){
            String nm_produto = rs.getString("nm_produto");
            double peso = rs.getDouble("peso");
            double volume = rs.getDouble("volume");
            d = new Produto(id_produto, nm_produto, peso, volume);
        }
        rs.close();
        stmt.close();
        con.close();
        return d;
    }
 
    public static void insert(String nm_produto, double peso, double volume) throws Exception{
        Connection con = DbListener.getConnection();
        String sql = "INSERT INTO produtos(nm_produto, peso, volume)"
                + "VALUES(?,?,?)";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, nm_produto);
        stmt.setDouble(2, peso);
        stmt.setDouble(3, volume);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void update(long id_produto, double peso, double volume) throws Exception{
        Connection con = DbListener.getConnection();
        String sql = "UPDATE produtos SET peso = ?, volume = ? WHERE id_produto = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setDouble(1, peso);
        stmt.setDouble(2, volume);
        stmt.setLong(3, id_produto);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void delete(long id_produto) throws Exception{
        Connection con = DbListener.getConnection();
        String sql = "DELETE FROM produtos WHERE id_produto = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setLong(1, id_produto);
        stmt.execute();
        stmt.close();
        con.close();
    }    
  
    public Produto(long id_produto, String nm_produto, double peso, double volume) {
        this.id_produto = id_produto;
        this.nm_produto = nm_produto;
        this.peso = peso;
        this.volume = volume;
    }
    public long getId_produto() {
        return id_produto;
    }

    public void setId_produto(long id_produto) {
        this.id_produto = id_produto;
    }

    public String getNm_produto() {
        return nm_produto;
    }

    public void setNm_produto(String nm_produto) {
        this.nm_produto = nm_produto;
    }

    public Double getPeso() {
        return peso;
    }

    public void setPeso(Double peso) {
        this.peso = peso;
    }

    public Double getVolume() {
        return volume;
    }

    public void setVolume(Double volume) {
        this.volume = volume;
    }
 
}
