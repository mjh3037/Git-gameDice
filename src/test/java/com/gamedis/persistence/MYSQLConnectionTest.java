package com.gamedis.persistence;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;


public class MYSQLConnectionTest {
	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://192.168.45.24:3306/gamedist_db?allowPublicKeyRetrieval=true&serverTimezone=UTC&useSSL=false";
    private static final String USER = "gamedice";
    private static final String PW = "pass";

    @Test
    public void testConnection() throws Exception{
    	System.out.println(Class.forName(DRIVER)+"...aa");
    	
    	try {
    		Connection conn = DriverManager.getConnection(URL, USER, PW); 
    		System.out.println(conn+"�����ͺ��̽� ����");
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    }
}
