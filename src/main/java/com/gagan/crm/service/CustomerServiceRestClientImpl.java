package com.gagan.crm.service;

import com.gagan.crm.entity.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.logging.Logger;

@Service
public class CustomerServiceRestClientImpl implements CustomerService {

    private RestTemplate restTemplate;
    private String crmRestUrl;

    private Logger logger = Logger.getLogger(getClass().getName());

    @Autowired
    public CustomerServiceRestClientImpl(
            RestTemplate theRestTemplate,
            @Value("${crm.rest.url}") String theUrl
    ) {
        restTemplate = theRestTemplate;
        crmRestUrl = theUrl;

        logger.info("Loaded property: crm.rest.url=" + crmRestUrl);
    }

    @Override
    public List<Customer> getCustomers() {
        logger.info("in getCustomers(): Calling REST API ");

        ResponseEntity<List<Customer>> responseEntity =
                restTemplate.exchange(crmRestUrl,
                        HttpMethod.GET,
                        null,
                        new ParameterizedTypeReference<List<Customer>>() {}
                );
        logger.info("body:" + responseEntity.getBody());
        List<Customer> customers = responseEntity.getBody();
        logger.info("in getCustomers(): customers: " + customers);

        return customers;
    }

    @Override
    public void saveCustomer(Customer theCustomer) {
        logger.info("in saveCustomer(): Calling REST API " + crmRestUrl);

        int employeeId = theCustomer.getId();
        if(employeeId == 0) {
            restTemplate.postForEntity(crmRestUrl, theCustomer, String.class);
        }
        else {
            restTemplate.put(crmRestUrl, theCustomer);
        }
        logger.info("in saveCustomer(): success");
    }

    @Override
    public Customer getCustomer(int theId) {
        logger.info("in getCustomer(): Calling REST API " + crmRestUrl);

        Customer theCustomer = restTemplate.getForObject(crmRestUrl + "/" + theId, Customer.class);
        logger.info("in getCustomer(): theCustomer: " + theCustomer);

        return theCustomer;
    }

    @Override
    public void deleteCustomer(int theId) {
        logger.info("in deleteCustomer(): Calling REST API " + crmRestUrl);
        restTemplate.delete(crmRestUrl + "/" + theId);
        logger.info("in deleteCustomer(): deleted customer theId: " + theId);
    }
}
