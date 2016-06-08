/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package validate;

import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author tgiunipero
 */
public class Validator {

    // ensures that quantity input is number between 0 and 99
    // applies to quantity fields in cart page
    public boolean validateQuantity (String productId, String quantity) {

        boolean errorFlag = false;

        if (!productId.isEmpty() && !quantity.isEmpty()) {

            int i = -1;

            try {

                i = Integer.parseInt(quantity);
            } catch (NumberFormatException nfe) {

                System.out.println("User did not enter a number in the quantity field");
            }

            if (i < 0 || i > 99) {

                errorFlag = true;
            }
        }

        return errorFlag;
    }


    // performs simple validation on checkout form
    public boolean validateForm(String name,
                                String email,
                                String phone,
                                String address,
                                String password,
                                HttpServletRequest request) {

        boolean errorFlag = false;
        boolean nameError;
        boolean emailError;
        boolean phoneError;
        boolean addressError;
        boolean passwordError;

        if (name == null
                || name.equals("")
                || name.length() > 45) {
            errorFlag = true;
            nameError = true;
            request.setAttribute("nameError", nameError);
        }
        if (email == null
                || email.equals("")
                || !email.contains("@")) {
            errorFlag = true;
            emailError = true;
            request.setAttribute("emailError", emailError);
        }
        if (phone == null
                || phone.equals("")
                || phone.length() < 4) {
            errorFlag = true;
            phoneError = true;
            request.setAttribute("phoneError", phoneError);
        }
        if (address == null
                || address.equals("")
                || address.length() > 45) {
            errorFlag = true;
            addressError = true;
            request.setAttribute("addressError", addressError);
        }
        if (password == null
                || password.equals("")
                || password.length() < 5) {
            errorFlag = true;
            passwordError = true;
            request.setAttribute("passwordError", passwordError);
        }
        
        return errorFlag;
    }

}