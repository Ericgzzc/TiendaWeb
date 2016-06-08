<%-- 
    Document   : index
    Created on : Nov 23, 2015, 8:37:36 PM
    Author     : Neosony
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="categories" dataSource="jdbc/TiendaOnline">
    SELECT * FROM category
</sql:query>

<sql:query var="selectedCategory" dataSource="jdbc/TiendaOnline">
    SELECT name FROM category WHERE id = ?
    <sql:param value="${pageContext.request.queryString}"/>
</sql:query>

<sql:query var="categoryProducts" dataSource="jdbc/TiendaOnline">
    SELECT * FROM product WHERE idCategory = ?
    <sql:param value="${pageContext.request.queryString}"/>
</sql:query>--%>

<div id="content">
             
            <div id="categoryLeftColumn">

                <c:forEach var="category" items="${categories}">

                    <c:choose>
                        <c:when test="${category.id == pageContext.request.queryString}">
                            <div class="categoryButton" id="selectedCategory">
                                <span class="categoryText">
                                    ${category.name}
                                </span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="category?${category.id}" class="categoryButton">
                                <span class="categoryText">
                                    ${category.name}
                                </span>
                            </a>
                        </c:otherwise>
                    </c:choose>

                </c:forEach>

            </div>

            <div id="categoryRightColumn">

                <h1 id="categoryTitle">${selectedCategory.name}</h1>

                <table id="productTable" class="table table-striped">

                    <c:forEach var="product" items="${categoryProducts}" varStatus="iter">

                        <tr class="">
                            <td>
                                <img class="img_cat" height="170" width="200" src="${initParam.productImagePath}${product.name}.jpg"
                                    alt="image of ${product.name}">
                            </td>
                            <td>
                                ${product.name}
                                <br>
                                <span class="smallText">${product.description}</span>
                            </td>
                            <td>
                                $; ${product.price} / unit
                            </td>
                            <td>
                                <form action="addToCart" method="post">
                                    <input type="hidden"
                                           name="productId"
                                           value="${product.id}">
                                    <input type="submit"
                                           value="add to cart">
                                </form>
                            </td>
                        </tr>

                    </c:forEach>

                </table>
            </div>
                 
                 </div>