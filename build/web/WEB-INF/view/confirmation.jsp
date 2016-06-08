<%--
    Document   : confirmation
    Created on : Sep 9, 2009, 12:20:30 AM
    Author     : tgiunipero
--%>


<div id="content">
    
    <div id="confirmationText">
        <p >
            <h1>Tu orden ha sido procesada.</h1>
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
    </div>
                    </div>
</div>