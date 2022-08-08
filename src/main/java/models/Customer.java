package models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Customer implements Serializable {

    private int id;
    private String Name;
    private String Email;
    private String password;
    private String avatar;

}
