/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ehas.dao;

import com.ehas.model.Account;
import com.ehas.util.DBConnection;
import com.ehas.util.passwordHash;

import java.time.*;
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
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    
    private static final String INSERT_ACCOUNT_SQL = 
        "INSERT INTO ACCOUNT (fullName, password, ic_passport, phoneNo, email, gender, dateOfBirth, picturePath) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String SELECT_EMAIL_SQL =
        "SELECT EMAIL FROM ACCOUNT WHERE EMAIL = ?";

    private static final String SELECT_ACCOUNT_SQL =
        "SELECT * FROM ACCOUNT WHERE EMAIL = ? AND PASSWORD = ?";

    private static final String UPDATE_ACCOUNT_TYPE =
        "UPDATE ACCOUNT SET ACCOUNTTYPE = ? WHERE ACCOUNTID = ? ";

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
            pstmt.setDate(7, java.sql.Date.valueOf(account.getDateOfBirth()));
            pstmt.setString(8, account.getPicturePath());
            pstmt.executeUpdate();

            rs = pstmt.getGeneratedKeys();
            if (rs.next()) { last_inserted_id = rs.getInt(1); }

            rs.close();
            pstmt.close();

            return last_inserted_id;

        } catch (SQLException e) {
            System.err.println("Error while inserting user: " + e.getMessage());
            e.printStackTrace();
        }
        return -1;
    }

    // For account login
    public Account authenticateAccount(String email, String password, Connection conn) {
        String hashedPassword = passwordHash.doHashing(password);
        try {
            pstmt = conn.prepareStatement(SELECT_ACCOUNT_SQL);
            pstmt.setString(1, email);
            pstmt.setString(2, hashedPassword);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractAccount(rs);
            }
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            System.err.println("Error while finding account: " + e.getMessage());
            e.printStackTrace();
        }
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

            return exists;
        } catch (SQLException e) {
            System.err.println("Error while validating email: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateAccountType(int accountID, String type) {
        try {
            conn = DBConnection.createConnection();
            pstmt = conn.prepareStatement(UPDATE_ACCOUNT_TYPE);
            
            pstmt.setString(1, type);
            pstmt.setInt(2, accountID);
            
            int rowsAffected = pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Account extractAccount(ResultSet rs) throws SQLException {

        int accountID = rs.getInt("accountID");
        String fullName = rs.getString("fullName");
        String password = rs.getString("password");
        String ic_passport = rs.getString("ic_passport");
        String email = rs.getString("email");
        String phoneNo = rs.getString("phoneNo");
        String gender = rs.getString("gender");
        LocalDate dateOfBirth = rs.getObject("dateOfBirth", LocalDate.class);
        String accountType = rs.getString("accountType");
        String picturePath = rs.getString("picturePath");
        LocalDateTime createdAt = rs.getObject("createdAt", LocalDateTime.class);
        LocalDateTime updatedAt = rs.getObject("updatedAt", LocalDateTime.class);

        return new Account(accountID, fullName, password, ic_passport, email, phoneNo, gender, dateOfBirth, accountType, picturePath, createdAt, updatedAt);
    }
}
