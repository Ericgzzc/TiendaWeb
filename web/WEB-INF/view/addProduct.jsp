<%-- 
    Document   : addProduct
    Created on : Nov 26, 2015, 6:32:51 AM
    Author     : Neosony
--%>
<div id="content">
    
<div class="inner-940px">
    <div id="singleColumn" class="forma">
    <form class="form-horizontal" action="agregar" method="post">
        
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">Nombre</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="name" name="name" placeholder="Nombre" value="${param.name}">
            </div>
        </div>
            
        <div class="form-group">
            <label for="price" class="col-sm-2 control-label">Precio</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="price" name="price" placeholder="Precio" value="${param.precio}">
            </div>
        </div>
            
        <div class="form-group">
            <label for="description" class="col-sm-2 control-label">Descripcion</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="description" name="description" placeholder="Descripcion" value="${param.desciption}">
            </div>
        </div>
        
        <div class="form-group">
           
                <label for="categoryId" class="col-sm-2 control-label">Categoria</label>
                <div class="col-sm-10">
                    <select class="form-control" name="categoryId">
                        <option value="1">Peliculas</option>
                        <option value="2">Ropa</option>
                        <option value="3">Dispositivos</option>
                        <option value="4">Casa</option>
                      </select>
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
</div>