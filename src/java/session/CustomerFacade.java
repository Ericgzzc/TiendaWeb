/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import entity.Customer;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Neosony
 */
@Stateless
public class CustomerFacade extends AbstractFacade<Customer> {
    @PersistenceContext(unitName = "TiendaOnlinePU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CustomerFacade() {
        super(Customer.class);
    }
    
    public List<Customer> findEmail(String email) {
    return em.createNamedQuery(
        "Customer.findByEmail")
        .setParameter("email", email).getResultList();
    }
    public List<Customer> findPassword(String password) {
    return em.createNamedQuery(
        "Customer.findByPassword")
        .setParameter("password", password).getResultList();
    }
    
}
