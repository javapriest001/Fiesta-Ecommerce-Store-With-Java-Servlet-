package models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class User implements Serializable {

    private int id;
    private String Name;
    private String username;
    private String Email;
    private String password;
    private String avatar;

    //Customer
    public User(String name, String email, String password, String avatar) {
        Name = name;
        Email = email;
        this.password = password;
        this.avatar = avatar;
    }

    public User(int id ,String name, String email, String password, String avatar) {
        this.id = id;
        this.Name = name;
        this.Email = email;
        this.password = password;
        this.avatar = avatar;
    }
    //Admin
    public User(String name, String username, String password) {
        Name = name;
        Email = username;
        this.password = password;
    }
}
