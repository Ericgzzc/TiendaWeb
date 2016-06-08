<%-- 
    Document   : checkout
    Created on : Nov 23, 2015, 8:37:05 PM
    Author     : Neosony
--%>

<script src="js/jquery.validate.js" type="text/javascript"></script>

<script type="text/javascript">

    $(document).ready(function(){
        $("#checkoutForm").validate({
            rules: {
                name: "required",
                email: {
                    required: true,
                    email: true
                },
                phone: {
                    required: true,
                    number: true,
                    minlength: 9
                },
                address: {
                    required: true
                },
                password: {
                    required: true,
                    creditcard: true
                }
            }
        });
    });
</script>

<div id="content">

    <h2>Checkout</h2>

    <p>Para completar la orden, Ingresa los siguientes datos.</p>
    
    <c:if test="${!empty validationErrorFlag}">
                    <span class="error smallText">Alguno de estos campos estan incorrectos:

                      <c:if test="${!empty nameError}">
                        <br><span class="indent"><strong>name</strong> (e.g., Eric Gonzalez)</span>
                      </c:if>
                      <c:if test="${!empty emailError}">
                        <br><span class="indent"><strong>email</strong> (e.g., eric@mail.com)</span>
                      </c:if>
                      <c:if test="${!empty phoneError}">
                        <br><span class="indent"><strong>phone</strong> (e.g., 222333444)</span>
                      </c:if>
                      <c:if test="${!empty addressError}">
                        <br><span class="indent"><strong>address</strong> (e.g., Korunní 56)</span>
                      </c:if>
                      <c:if test="${!empty password}">
                        <br><span class="indent"><strong>city region</strong> (e.g., password)</span>
                      </c:if>
                    </span>
          </c:if>
    
    <div class="inner-940px">
    <div id="singleColumn" class="forma">
    <form class="form-horizontal" action="purchase" method="post">
        
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">Nombre</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="name" name="name" placeholder="Nombre" value="${param.name}">
            </div>
        </div>
            
        <div class="form-group">
            <label for="email" class="col-sm-2 control-label">Email</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="email" name="email" placeholder="Email" value="${param.email}">
            </div>
        </div>
            
        <div class="form-group">
            
                <label for="password" class="col-sm-2 control-label">Contraseña</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="password" name="password" placeholder="Contraseña" value="${param.password}">
                </div>
            
        </div>

        <div class="form-group">
           
                <label for="phone" class="col-sm-2 control-label">Telefono</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="phone" name="phone" placeholder="Telefono" value="${param.phone}">
                </div>
            
        </div>
        <div class="form-group">
            
                <label for="address" class="col-sm-2 control-label">Direccion</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="address" name="address" placeholder="Direccion" value="${param.address}">
                </div>
            
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-default">Submit</button>
            </div>
        </div>
    </form>
</div>
    <div id="infoBox">

        

        <table id="priceBox" class="table table-striped table-bordered">
            <tr>
                <td>subtotal:</td>
                <td class="checkoutPriceColumn">
                    $; ${cart.subtotal}</td>
            </tr>
            <tr>
                <td>cargo por entrega</td>
                <td class="checkoutPriceColumn">
                    $; ${initParam.deliverySurcharge}</td>
            </tr>
            <tr>
                <td class="total">Total:</td>
                <td class="total checkoutPriceColumn">
                    $; ${cart.total}</td>
            </tr>
        </table>
    </div>
            </div>
</div>