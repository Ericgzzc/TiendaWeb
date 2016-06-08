/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import cart.ShoppingCart;
import entity.Category;
import entity.Customer;
import entity.CustomerOrder;
import entity.OrderedProduct;
import entity.Product;
import java.io.IOException;
import java.util.Collection;
import java.util.Map;
import javax.ejb.EJB;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import session.CategoryFacade;
import session.OrderManager;
import session.ProductFacade;
import validate.Validator;

/**
 *
 * @author Neosony
 */
@WebServlet(name = "ControladorServlet",
            loadOnStartup = 1,
            urlPatterns = {"/category",
                           "/addToCart",
                           "/viewCart",
                           "/updateCart",
                           "/checkout",
                           "/purchase",
                           "/perfil"})
public class ControladorServlet extends HttpServlet {

    private String surcharge;

    @EJB
    private CategoryFacade categoryFacade;
    @EJB
    private ProductFacade productFacade;
    @EJB
    private OrderManager orderManager;
    

    @Override
    public void init(ServletConfig servletConfig) throws ServletException {

        super.init(servletConfig);

        // initialize servlet with configuration information
        surcharge = servletConfig.getServletContext().getInitParameter("deliverySurcharge");

        // store category list in servlet context
        getServletContext().setAttribute("categories", categoryFacade.findAll());
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userPath = request.getServletPath();
        HttpSession session = request.getSession();
        Category selectedCategory;
        Collection<Product> categoryProducts;
        Customer customer;

        // if category page is requested
        if (userPath.equals("/category")) {

            // get categoryId from request
            String categoryId = request.getQueryString();

            if (categoryId != null) {

                // get selected category
                selectedCategory = categoryFacade.find(Short.parseShort(categoryId));

                // place selected category in session scope
                session.setAttribute("selectedCategory", selectedCategory);

                // get all products for selected category
                categoryProducts = selectedCategory.getProductCollection();

                // place category products in session scope
                session.setAttribute("categoryProducts", categoryProducts);
            }


        // if cart page is requested
        } else if (userPath.equals("/viewCart")) {

            String clear = request.getParameter("clear");

            if ((clear != null) && clear.equals("true")) {

                ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
                cart.clear();
            }

            userPath = "/cart";


        // if checkout page is requested
        } else if (userPath.equals("/checkout")) {

            ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

            // calculate total
            cart.calculateTotal(surcharge);

            // forward to checkout page and switch to a secure channel


        // if user switches language
        } else if(userPath.equals("/perfil")){
                request.setAttribute("orderA", false);
            
            userPath = "/perfil";
            
         }if (userPath.equals("/addProduct")){
         
         
             
             
             userPath = "/addProduct";
         }
        

        // use RequestDispatcher to forward request internally
        String url = "/WEB-INF/view" + userPath + ".jsp";

        try {
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }


    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userPath = request.getServletPath();
        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        Validator validator = new Validator();
        int producto;

        // if addToCart action is called
        if (userPath.equals("/addToCart")) {

            // if user is adding item to cart for first time
            // create cart object and attach it to user session
            if (cart == null) {

                cart = new ShoppingCart();
                session.setAttribute("cart", cart);
            }

            // get user input from request
            String productId = request.getParameter("productId");

            if (!productId.isEmpty()) {

                Product product = productFacade.find(Integer.parseInt(productId));
                cart.addItem(product);
            }

            userPath = "/category";


        // if updateCart action is called
        } else if (userPath.equals("/updateCart")) {

            // get input from request
            String productId = request.getParameter("productId");
            String quantity = request.getParameter("quantity");

            boolean invalidEntry = validator.validateQuantity(productId, quantity);

                if (!invalidEntry) {

                Product product = productFacade.find(Integer.parseInt(productId));
                cart.update(product, quantity);
            }

            userPath = "/cart";


        // if purchase action is called
        } else if (userPath.equals("/purchase")) {
            if (cart != null) {

                // extract user data from request
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String password = request.getParameter("password");

                // validate user data
                boolean validationErrorFlag = false;
                validationErrorFlag = validator.validateForm(name, email,password, phone, address, request);

                // if validation error found, return user to checkout
                if (validationErrorFlag == true) {
                    request.setAttribute("validationErrorFlag", validationErrorFlag);
                    userPath = "/checkout";

                    // otherwise, save order to database
                } else {

                    int orderId = orderManager.placeOrder(name, email, password, phone, address, cart);

                    // if order processed successfully send user to confirmation page
                    if (orderId != 0) {

                        // dissociate shopping cart from session
                        cart = null;

                        // end session
                        session.invalidate();

                        // get order details
                        Map orderMap = orderManager.getOrderDetails(orderId);

                        // place order details in request scope
                        request.setAttribute("customer", orderMap.get("customer"));
                        request.setAttribute("products", orderMap.get("products"));
                        request.setAttribute("orderRecord", orderMap.get("orderRecord"));
                        request.setAttribute("orderedProducts", orderMap.get("orderedProducts"));
                        request.setAttribute("ordeA", true);
                        userPath = "/confirmation";

                    // otherwise, send back to checkout page and display error
                    } else {
                        userPath = "/checkout";
                        request.setAttribute("orderFailureFlag", true);
                    }
                }
            }
        } else if (userPath.equals("/agregar")) {
                  // extract user data from request
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                int category = Integer.parseInt(request.getParameter("categoryId"));
               
                producto = orderManager.addProduct(name, description, price, category);
                
                productFacade.find(producto);
                
                userPath = "/addProduct";
        } else if (userPath.equals("/buscar"))  {
            
            String numero = request.getParameter("numero");
            CustomerOrder order = orderManager.getOrder(Integer.parseInt(numero));
            int orderId = 0;
            if(order != null){
                orderId = order.getId();
            }
            
            if (orderId != 0) {

                        Map orderMap = orderManager.getOrderDetails(orderId);

                        // place order details in request scope
                        request.setAttribute("customer", orderMap.get("customer"));
                        request.setAttribute("products", orderMap.get("products"));
                        request.setAttribute("orderRecord", orderMap.get("orderRecord"));
                        request.setAttribute("orderedProducts", orderMap.get("orderedProducts"));
                        request.setAttribute("ordeA", true);
                        userPath = "/perfil";

                    // otherwise, send back to checkout page and display error
                    } else {
                        userPath = "/checkout";
                        request.setAttribute("orderFailureFlag", true);
                    }
            
            userPath = "/perfil";
        }  
        // use RequestDispatcher to forward request internally
        String url = "/WEB-INF/view" + userPath + ".jsp";
        
        try {
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}