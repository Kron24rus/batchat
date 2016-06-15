package com.fireway.batchat;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.orm.jpa.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * @author Alexander Mikheev
 */

@SpringBootApplication
@EnableScheduling
@EnableJpaRepositories(basePackages = "com.fireway.batchat.repository")
@EntityScan(basePackages = "com.fireway.batchat.entity")
public class Application {

    public static void main(String[] args) throws Throwable {
        SpringApplication.run(Application.class, args);
    }

}
