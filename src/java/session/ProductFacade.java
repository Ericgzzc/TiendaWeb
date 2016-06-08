/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import entity.CustomerOrder;
import entity.Product;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Neosony
 */
@Stateless
public class ProductFacade extends AbstractFacade<Product> {
    @PersistenceContext(unitName = "TiendaOnlinePU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ProductFacade() {
        super(Product.class);
    }
    public Product find(Object id) {
        Product producto = em.find(Product.class, id);
        em.refresh(producto);
       return producto;
    }
    
}
