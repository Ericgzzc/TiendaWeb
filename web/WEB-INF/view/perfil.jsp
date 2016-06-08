<%-- 
    Document   : perfil
    Created on : Nov 26, 2015, 4:44:35 AM
    Author     : Neosony
--%>

       <%
        //allow access only if session exists
        if(session.getAttribute("user") == null){
                response.sendRedirect("index.jsp");
         }
        %>
       

        <div id="content">
    
<div class="inner-940px">
    <div id="singleColumn" class=" buscar">
    <form class="form-horizontal" action="buscar" method="post">
        
        <div class="form-group">
            <label for="numero" class="col-sm-2 control-label">Buscar</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="numero" name="numero" placeholder="Numero de Confirmacion" value="${param.name}">
            </div>
        </div>
        
     
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-default">Submit</button>
            </div>
        </div>
    </form>
</div>
</div>
            
            <c:if test="${!empty validationErrorFlag}">
                    <span class="error smallText">
                            No se ha encontrado la orden.
                    </span>
          </c:if>
            
            <c:if test="${empty orderA}">
            <div id="confirmationText">
                <p >
                    <h1>Tu orden esta en Proceso.</h1>
                    <br><br>
                    <h3>Numero de Confirmacion: <span class="label label-default">${orderRecord.confirmationNumber}</span></h3>
                </p>
            </div>
            
            <div class="inner-940px">
    <div class="summaryColumn">
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th>Producto</th>
                <th>Cantidad</th>
                <th>Precio</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="orderedProduct" items="${orderedProducts}" varStatus="iter">

                <tr class="">
                    <td>${products[iter.index].name}</td>
                    <td class="quantityColumn">
                        ${orderedProduct.quantity}
                    </td>
                    <td class="confirmationPriceColumn">
                        $ ${products[iter.index].price * orderedProduct.quantity}
                    </td>
                </tr>

            </c:forEach>

            <tr class="lightBlue"><td colspan="3" style="padding: 0 20px"><hr></td></tr>

            <tr class="lightBlue">
                <td colspan="2" id="deliverySurchargeCellLeft"><strong>Cargo de Envio</strong></td>
                <td id="deliverySurchargeCellRight">$ ${initParam.deliverySurcharge}</td>
            </tr>

            <tr class="lightBlue">
                <td colspan="2" id="totalCellLeft"><strong>Total</strong></td>
                <td id="totalCellRight">$ ${orderRecord.amount}</td>
            </tr>

            <tr class="lightBlue"><td colspan="3" style="padding: 0 20px"><hr></td></tr>

            <tr class="lightBlue">
                <td colspan="3" id="dateProcessedRow"><strong>Fecha</strong>
                    ${orderRecord.dateCreated}
                </td>
            </tr>
            </tbody>
        </table>

    </div>

    <div class="summaryColumn" >

        <table class="table table-striped">
            <thead>
                <tr>
                    <th colspan="3">delivery address</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="info">
                        ${customer.name}
                    </td>
                </tr>
                <tr>
                    <td>
                         ${customer.address}
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>email:</strong> ${customer.email}
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>phone:</strong> ${customer.phone}
                    </td>
                </tr>
            </tbody>
        </table>
    </div>  </c:if>
                    </div>
</div>