/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import entity.Category;
import entity.CustomerOrder;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Neosony
 */
@Stateless
public class CategoryFacade extends AbstractFacade<Category> {
    @PersistenceContext(unitName = "TiendaOnlinePU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CategoryFacade() {
        super(Category.class);
    }
    public Category find(int id) {
        return (Category) em.createNamedQuery(
        "Category.findById")
        .setParameter("id", id).getSingleResult();
    
    }
    
}
