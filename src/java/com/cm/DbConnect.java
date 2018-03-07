package com.cm;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;

public class DbConnect {

    
    private  final ConcurrentHashMap<String, BasicDataSource> dataSources = new ConcurrentHashMap();

    public DbConnect() {
        //
    }

    public  Connection getConnection() throws SQLException, IOException {

         Properties props = new Properties();  
         props.load(new FileInputStream("C:\\Users\\Acer\\Documents\\NetBeansProjects\\CM\\web\\conf" +File.separator + "config.properties"));         
    
         String driver = props.getProperty("driver").trim();
         String url = props.getProperty("url").trim();
         String username = props.getProperty("username").trim();
         String password = props.getProperty("password").trim();
        
        BasicDataSource dataSource;

        if (dataSources.containsKey(url)) {
            dataSource = dataSources.get(url);
        } else {
            dataSource = new BasicDataSource();
            dataSource.setDriverClassName(driver);
            dataSource.setUrl(url);
            dataSource.setUsername(username);
            dataSource.setPassword(password);
            dataSources.put(url, dataSource);
        }

        return dataSource.getConnection();

    }

}