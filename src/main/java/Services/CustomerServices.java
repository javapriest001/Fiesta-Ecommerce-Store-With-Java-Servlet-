package Services;

import models.Customer;

public interface CustomerServices {

    String registerCustomer(String name, String email, String password, String avatar);
}
