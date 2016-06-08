<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>--%>

<%-- 
    Document   : index
    Created on : Nov 23, 2015, 8:37:36 PM
    Author     : Neosony
--%>

<!--    <sql:query var="categories" dataSource="jdbc/TiendaOnline">
        SELECT * FROM category
    </sql:query>-->
        
        <div id="content">
            
            <div class="inner-940px">

                <div id="indexRightColumn" class="">
                    <c:forEach var="category" items="${categories}">
                        <div class="categoryBox">
                            <a href="category?${category.id}">
                                <span class="categoryLabelText">${category.name}</span>

                                <img class="img_cat" height="170" width="200" src="${initParam.categoryImagePath}${category.name}.png"
                                     alt="${category.name}" class="categoryImage">
                            </a>
                        </div>
                    </c:forEach>

                </div>
            </div>
        </div>


