<%-- 
    Document   : cart
    Created on : Nov 23, 2015, 8:36:43 PM
    Author     : Neosony
--%>
<div id="content">
    
    <c:choose>
        <c:when test="${cart.numberOfItems > 1}">
            <h3>Your shopping cart contains  <span class="label label-default">${cart.numberOfItems} items.</span></h3>
        </c:when>
        <c:when test="${cart.numberOfItems == 1}">
            <h3>Your shopping cart contains  <span class="label label-default">${cart.numberOfItems} item.</span></h3>
        </c:when>
        <c:otherwise>
           <h3>Your shopping cart is<span class="label label-default">empty</span></h3>
        </c:otherwise>
    </c:choose>

        <div class="inner-940px">  
        <div class="btn-group btn-group-justified botones" role="group" aria-label="...">

        <%-- clear cart widget --%>
        <c:if test="${!empty cart && cart.numberOfItems != 0}">
            <a href="viewCart?clear=true" class="btn btn-default">clear cart</a>
        </c:if>

        <%-- continue shopping widget --%>
        <c:set var="value">
            <c:choose>
                <%-- if 'selectedCategory' session object exists, send user to previously viewed category --%>
                <c:when test="${!empty selectedCategory}">
                    category
                </c:when>
                <%-- otherwise send user to welcome page --%>
                <c:otherwise>
                    index.jsp
                </c:otherwise>
            </c:choose>
        </c:set>

        <a href="${value}" class="btn btn-default">continue shopping</a>

        <%-- checkout widget --%>
        <c:if test="${!empty cart && cart.numberOfItems != 0}">
            <a href="checkout" class="btn btn-default">CheckOut</a>
        </c:if>
    </div>
        </div>

    <c:if test="${!empty cart && cart.numberOfItems != 0}">
        <div class="inner-940px">   
                <h3 id="subtotal">subtotal: <span class="label label-default">$ ${cart.subtotal}</span></h3>
        </div>
      <table class="table table-striped" >

        <tr>
            <th>product</th>
            <th>name</th>
            <th>price</th>
            <th>quantity</th>
        </tr>

        <c:forEach var="cartItem" items="${cart.items}" varStatus="iter">

          <c:set var="product" value="${cartItem.product}"/>

          <tr class="${((iter.index % 2) == 0) ? 'lightBlue' : 'white'}">
            <td>
              <img src="${initParam.productImagePath}${product.name}.png"
                   alt="${product.name}">
            </td>

            <td>${product.name}</td>

            <td>
                $; ${cartItem.total}
                <br>
                <span class="smallText">( $; ${product.price} / unit )</span>
            </td>

            <td>
                <form action="updateCart" method="post">
                    <input type="hidden"
                           name="productId"
                           value="${product.id}">
                    <input type="text"
                           maxlength="2"
                           size="2"
                           value="${cartItem.quantity}"
                           name="quantity"
                           style="margin:5px">
                    <input type="submit"
                           name="submit"
                           value="update">
                </form>
            </td>
          </tr>

        </c:forEach>

      </table>

    </c:if>
</div>