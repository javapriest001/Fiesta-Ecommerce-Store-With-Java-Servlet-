package models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product implements Serializable {
    private int id;
    private String name;
    private String Desc;
    private String category;
    private double price;
    private String avatar;
    private int productQty;

    public Product(int id, String name, String desc, String category, double price, String avatar) {
        this.id = id;
        this.name = name;
        Desc = desc;
        this.category = category;
        this.price = price;
        this.avatar = avatar;
    }
}
