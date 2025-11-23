package com.example.banking.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TransactionController {

    @GetMapping("/health")
    public String health() {
        return "OK";
    }

    @GetMapping("/api/transactions/sample")
    public String sample() {
        return "sample-transaction";
    }
}
