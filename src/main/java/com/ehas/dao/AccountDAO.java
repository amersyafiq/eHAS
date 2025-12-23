/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.dao;

import com.ehas.model.Account;
import com.ehas.util.passwordHash;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author SYAFIQ
 */
public class AccountDAO {
    private Statement statement = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;
    
    private static final String INSERT_ACCOUNT_SQL = 
        "INSERT INTO ACCOUNT (fullName, password, ic_passport, phoneNo, email, gender, dateOfBirth, picturePath) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String SELECT_EMAIL_SQL=
        "SELECT EMAIL FROM ACCOUNT WHERE EMAIL = ?";

    // Used in 'registerServlet' for Account Registration
    // return last_inserted_id (for patient/doctor)
    public int createAccount(Account account, Connection conn) {
        int last_inserted_id = -1;
        try {
            pstmt = conn.prepareStatement(INSERT_ACCOUNT_SQL, Statement.RETURN_GENERATED_KEYS);
            
            pstmt.setString(1, account.getFullName());
            pstmt.setString(2, passwordHash.doHashing(account.getPassword()));
            pstmt.setString(3, account.getIc_passport());
            pstmt.setString(4, account.getPhoneNo());
            pstmt.setString(5, account.getEmail());
            pstmt.setString(6, account.getGender());
            pstmt.setString(7, account.getDateOfBirth());
            pstmt.setString(8, account.getPicturePath());
            pstmt.executeUpdate();

            rs = pstmt.getGeneratedKeys();
            if (rs.next()) { last_inserted_id = rs.getInt(1); }

            rs.close();
            conn.close();
            pstmt.close();

            return last_inserted_id;

        } catch (SQLException e) {
            System.err.println("Error while inserting user: " + e.getMessage());
            e.printStackTrace();
        }
        return -1;
    }

    // For account login
    public Account authenticateAccount(Account account) {
        return null;
    }

    // For validating email
    public boolean isEmailExists(String email, Connection conn) {
        try {
            pstmt = conn.prepareStatement(SELECT_EMAIL_SQL);
            pstmt.setString(1, email);

            rs = pstmt.executeQuery();
            boolean exists = rs.next();

            rs.close();
            pstmt.close();
            conn.close();

            return exists;
        } catch (SQLException e) {
            System.err.println("Error while validating email: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}
