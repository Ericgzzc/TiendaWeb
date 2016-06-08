/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import cart.ShoppingCart;
import cart.ShoppingCartItem;
import entity.Customer;
import entity.CustomerOrder;
import entity.OrderedProduct;
import entity.OrderedProductPK;
import entity.Product;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.ejb.SessionContext;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Neosony
 */
@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)

public class OrderManager {

    @PersistenceContext(unitName = "TiendaOnlinePU")
   private EntityManager em;
    @Resource
    private SessionContext context;
    @EJB
    private ProductFacade productFacade;
    @EJB
    private CustomerOrderFacade customerOrderFacade;
    @EJB
    private OrderedProductFacade orderedProductFacade;
    @EJB
    private CategoryFacade categoryFacade;

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public int placeOrder(String name, String email,String password, String phone, String address, ShoppingCart cart) {

        try {
            Customer customer = addCustomer(name, email, password, phone, address);
            CustomerOrder order = addOrder(customer, cart);
            addOrderedItems(order, cart);
            return order.getId();
        } catch (Exception e) {
            context.setRollbackOnly();
            return 0;
        }
    }

    public Customer addCustomer(String name, String email, String password, String phone, String address) {

        Customer customer = new Customer();
        customer.setName(name);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setAddress(address);
        customer.setPassword(password);

        em.persist(customer);
        return customer;
    }

    public CustomerOrder addOrder(Customer customer, ShoppingCart cart) {

        // set up customer order
        CustomerOrder order = new CustomerOrder();
        order.setCustomerId(customer);
        order.setAmount(BigDecimal.valueOf(cart.getTotal()));

        // create confirmation number
        Random random = new Random();
        int i = random.nextInt(999999999);
        order.setConfirmationNumber(i);

        em.persist(order);
        return order;
    }
    
    public void addOrderedItems(CustomerOrder order, ShoppingCart cart) {

        em.flush();

        List<ShoppingCartItem> items = cart.getItems();

        // iterate through shopping cart and create OrderedProducts
        for (ShoppingCartItem scItem : items) {

            int productId = scItem.getProduct().getId();

            // set up primary key object
            OrderedProductPK orderedProductPK = new OrderedProductPK();
            orderedProductPK.setCustomerOrderId(order.getId());
            orderedProductPK.setProductId(productId);

            // create ordered item using PK object
            OrderedProduct orderedItem = new OrderedProduct(orderedProductPK);

            // set quantity
            orderedItem.setQuantity(scItem.getQuantity());

            em.persist(orderedItem);
        }
    }
    
    public Map getOrderDetails(int orderId) {

        Map orderMap = new HashMap();

        // get order
        CustomerOrder order = customerOrderFacade.find(orderId);

        // get customer
        Customer customer = order.getCustomerId();

        // get all ordered products
        List<OrderedProduct> orderedProducts = orderedProductFacade.findByOrderId(orderId);

        // get product details for ordered items
        List<Product> products = new ArrayList<Product>();

        for (OrderedProduct op : orderedProducts) {

            Product p = (Product) productFacade.find(op.getOrderedProductPK().getProductId());
            products.add(p);
        }

        // add each item to orderMap
        orderMap.put("orderRecord", order);
        orderMap.put("customer", customer);
        orderMap.put("orderedProducts", orderedProducts);
        orderMap.put("products", products);

        return orderMap;
    }
    
    
    public CustomerOrder getOrder(int confirmation){
        List<CustomerOrder> list = customerOrderFacade.findByOrder(confirmation);
        CustomerOrder order = null;
        if(list!=null){
            order = list.get(0);
        }
        return order;
    }

    
    public int addProduct(String name, String description, double price, int category){
        Product product = new Product();
        product.setName(name);
        product.setDescription(description);
        product.setPrice(BigDecimal.valueOf(price));
        product.setCategoryId(categoryFacade.find(category));
        product.setLastUpdate(new Date());
        em.persist(product);
        return product.getId();
        
    }


}