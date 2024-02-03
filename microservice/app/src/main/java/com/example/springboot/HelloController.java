package com.example.springboot;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.HashMap;
import java.util.Map;

@RestController
public class HelloController {

    private static final Logger logger = LoggerFactory.getLogger(HelloController.class);

    @GetMapping("/")
    public Map<String, Object> index() {
        logger.info("Received request for index");

        Map<String, Object> response = new HashMap<>();
        response.put("message", "Automate all the things! V2.0");
        response.put("timestamp", System.currentTimeMillis() / 1000);

        return response;
    }
}
