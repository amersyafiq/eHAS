/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author ASUS
 */
public class DBConnection {
    private static final String JDBC_URL = "jdbc:postgresql://aws-1-ap-southeast-2.pooler.supabase.com:5432/postgres";
    private static final String USER = "postgres.hsnmkvymudhpkbobwhtc";
    private static final String PASSWORD = "uOOogouybBFbvMIU";
    
    public static Connection createConnection() {
        
        try {
            String driver = "org.postgresql.Driver";        
            Class.forName(driver);
            return DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
        } catch(ClassNotFoundException | SQLException ex) {     
            ex.printStackTrace();
        }
        return null;
    }
}