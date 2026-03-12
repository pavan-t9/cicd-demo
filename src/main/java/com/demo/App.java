package com.demo;

public class App {
    public static String greet(String name) {
        return "Hello, " + name + "! CI/CD pipeline is working.";
    }

    public static void main(String[] args) {
        System.out.println(greet("Pavan"));
        System.out.println("App is running successfully!");
    }
}
