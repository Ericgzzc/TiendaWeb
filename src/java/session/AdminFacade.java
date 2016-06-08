/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import entity.Admin;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Neosony
 */
@Stateless
public class AdminFacade extends AbstractFacade<Admin> {
    @PersistenceContext(unitName = "TiendaOnlinePU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AdminFacade() {
        super(Admin.class);
    }
    
    public List<Admin> findEmailAdmin(String email) {
    return em.createNamedQuery(
        "Admin.findByEmail")
        .setParameter("email", email).getResultList();
    }
    
}
