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
    public static Connection createConnection() {
        try {
            String driver = "org.apache.derby.jdbc.ClientDriver";
            String connectionString = "jdbc:derby://localhost:1527/ehasdev;create=true;user=ehas;password=ehas";
        
            Class.forName(driver);
            return DriverManager.getConnection(connectionString);
            
        } catch(ClassNotFoundException | SQLException ex) { }
        return null;
    }
}
