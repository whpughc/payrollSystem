<!DOCTYPE html>
<html lang="en">
<head>
    <script src="/static/js/jquery-3.4.1.min.js"></script>
    <script src="/static/layui/layui.js"></script>
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <style>

    </style>
</head>
<body>

<!-- 卡片搜索面板-->

<div style="padding: 10px; background-color: #F2F2F2;/*height: 180px;*/">
    <div class="layui-row layui-col-space15">
        <div>
            <div class="layui-card">
                <div class="layui-card-header"><span style="margin-right: 10px; margin-bottom: 2px" class="layui-badge-dot"></span>快速搜索</div>
                <div class="layui-card-body layui-form-item layui-form">

                    <div class=" layui-col-md4" style="margin-bottom: 10px;">
                        <label class="layui-form-label">部门</label>
                        <div class="layui-input-block" style="width: 200px">
                            <select lay-search lay-filter="depart-select"  id="depart-select" name="department"  style="width:200px;height:38px;border-color: #e6e6e6" >
                                <option style="" value="">请选择部门</option>
                            </select>
                        </div>
                    </div>


                    <div class="layui-col-md4" style="margin-bottom: 10px">
                        <label class="layui-form-label">型号</label>
                        <div class="layui-input-block" style="width: 200px">
                            <select lay-search lay-filter="product-select" id="product-select" name="position" lay-verify="required" style="width:200px;height:38px;border-color: #e6e6e6">
                                <option value="">请选择型号</option>
                            </select>
                        </div>
                    </div>

                    <div class="layui-col-md4" style="margin-bottom: 10px">
                        <label class="layui-form-label">工序名称</label>
                        <div class="layui-input-block" style="width: 200px">
                            <input id="search-input-name" type="text" name="title"  placeholder="请输入工序名称" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>


<table class="layui-hide" id="process-table" lay-filter="process-table"></table>

<script type="text/html" id="toolbar">
    <div class="layui-btn-container" style="float: left;">
        <button class="layui-btn layui-btn-sm" lay-event="addProcess" style="float: left;">添加工序</button>
    </div>
</script>

<script type="text/html" id="barTpl">
    <a class="layui-btn layui-btn-xs" lay-event="edit">保存</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<style type="text/css">
    .layui-table-cell{
        height:36px;
        line-height: 36px;
    }
</style>


<script>

    var departs = [];
    var products = [];
    <!-- 向子页面进行数据传递 (下拉框选项, 及主键 -> 不一定连续)-->
    <#list productList as product>
     products.push({
        'id' : '${product.productUuid}',
        'productNumber' : '${product.productNumber}'
    });
    </#list>

    <#list departList as depart>
    departs.push({
        'id' : '${depart.departUuid}',
        'name' : '${depart.departName}'
    });
    </#list>

    for (var i = 0; i < products.length; i++) {
        $("#product-select").append('<option value=' + products[i].id + '>' + products[i].productNumber + '</option>');
    }
    for (var i = 0; i < departs.length; i++) {
        $("#depart-select").append('<option value=' + departs[i].id + '>' + departs[i].name + '</option>');
    }


    function sotitle(id,arr){
        var title;
        $.each(arr, function (index, obj) {
            if(obj.id==id){
                title=obj.name;
            }
        });
        if(title==null){
            return "";
        }else{
            return title;
        }
    };

    function sotitle2(id,arr){
        var title;
        $.each(arr, function (index, obj) {
            if(obj.id==id){
                title=obj.productNumber;
            }
        });
        if(title==null){
            return "";
        }else{
            return title;
        }
    };

    var tableContent = [];
    layui.use(['table', 'form'], function(){
        var form = layui.form;
        var table = layui.table;

        // 下拉框搜索
        // 部门搜索下拉框
        form.on('select(depart-select)', function(data){
            // 用来传递到后台的查询参数MAP
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qprocessName = $("#search-input-name").val();
            var qdepartUuid = $("#depart-select").val();
            var qproductUuid = $("#product-select").val();
            if (qprocessName.length > 0) whereData["qprocessName"] = qprocessName;
            if (qdepartUuid.length > 0) whereData["qdepartUuid"] = qdepartUuid;
            if (qproductUuid.length > 0) whereData["qproductUuid"] = qproductUuid;
            table.reload("process-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 1
                }
            });
            //最后再渲柒一次
            form.render('select');//select是固定写法 不是选择器
        });

        // 产品搜索
        form.on('select(product-select)', function(data){
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qprocessName = $("#search-input-name").val();
            var qdepartUuid = $("#depart-select").val();
            var qproductUuid = $("#product-select").val();
            if (qprocessName.length > 0) whereData["qprocessName"] = qprocessName;
            if (qdepartUuid.length > 0) whereData["qdepartUuid"] = qdepartUuid;
            if (qproductUuid.length > 0) whereData["qproductUuid"] = qproductUuid;
            table.reload("process-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 1
                }
            });
            //最后再渲柒一次
            form.render('select');//select是固定写法 不是选择器
        });

        table.render({
            elem: '#process-table',
            url:'/processs',
            toolbar: '#toolbar',
            parseData: function (res) {
                console.log(res);
                tableContent = res.data;
                return {
                    "code": 0,
                    "msg": "",
                    "count": res.size,
                    data: res.data
                }
            }
            ,cols: [[
                {field:'id', width:30, title: 'ID',hide:true},
                {field:'processUuid', width:30, title: '唯一标识',hide:true},
                {field:'departUuid', width:120, title: '部门',templet:'<div>{{sotitle(d.departUuid,departs)}}</div>'},
                {field:'productUuid', width:120, title: '产品',templet:'<div>{{sotitle2(d.productUuid,products)}}</div>'},
                {field:'processNumber', width:120, title: '工序序号'},
                {field:'processName', width:120, title: '工序名称',edit:true},
                {field:'price', width:120, title: '工序价格',edit:true},
        /*        {field:'remark', width:150, title: '描述',edit:true},*/
                {field:'status', width:130, title: '状态', templet:function (row) {
                        return [
                            '<input type="checkbox" lay-filter="admin_switch" lay-skin="switch" lay-text="有效|无效" ',
                            row.status == true ? "checked />" : " />"
                        ].join('');
                        /*return [
                            '<input type="checkbox" name="admin_switch" id="admin_switch" lay-skin="switch" lay-text="是|否"/>'
                        ].join('');*/
                    }},
                {field:'createAt', width: 160, title: '创建时间', sort: true},
                {fixed: 'right', width:150,title: '操作', align:'center', toolbar: '#barTpl'}
            ]]
            ,page: {
                limits:[10,20,30,40,100000]
            }
        });

        /* 搜索实现, 使用reload, 进行重新请求 */
        $("#search-input-name").on('input',function () {
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qprocessName = $("#search-input-name").val();
            var qdepartUuid = $("#depart-select").val();
            var qproductUuid = $("#product-select").val();
            if (qprocessName.length > 0) whereData["qprocessName"] = qprocessName;
            if (qdepartUuid.length > 0) whereData["qdepartUuid"] = qdepartUuid;
            if (qproductUuid.length > 0) whereData["qproductUuid"] = qproductUuid;
            table.reload("process-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 1
                }
            });
        });

        var temp;
        form.on('switch(admin_switch)', function (obj) {
            temp = obj.elem.checked;
        });

        table.on('toolbar(process-table)', function (obj) {
            // 回调函数
            layerCallback= function() {
                /*// 执行局部刷新, 获取之前的TABLE内容, 再进行填充
                var dataBak = [];
                var tableBak = table.cache.process-table;
                for (var i = 0; i < tableBak.length; i++) {
                    dataBak.push(tableBak[i]);      //将之前的数组备份
                }
                // 添加到表格缓存
                dataBak.push(callbackData);
                //console.log(dataBak);
                table.reload("process-table",{
                    data:dataBak   // 将新数据重新载入表格
                });*/
                table.render({
                    elem: '#process-table',
                    url:'/processs',
                    toolbar: '#toolbar',
                    parseData: function (res) {
                        console.log(res);
                        tableContent = res.data;
                        return {
                            "code": 0,
                            "msg": "",
                            "count": res.size,
                            data: res.data
                        }
                    }
                    ,cols: [[
                        {field:'id', width:30, title: 'ID',hide:true},
                        {field:'processUuid', width:30, title: '唯一标识',hide:true},
                        {field:'departUuid', width:120, title: '部门',templet:'<div>{{sotitle(d.departUuid,departs)}}</div>'},
                        {field:'productUuid', width:120, title: '产品',templet:'<div>{{sotitle2(d.productUuid,products)}}</div>'},
                        {field:'processNumber', width:120, title: '工序数'},
                        {field:'processName', width:120, title: '工序名称'},
                        {field:'price', width:120, title: '工序价格',edit:true},
                        {field:'remark', width:150, title: '描述',edit:true},
                        {field:'status', width:130, title: '状态', templet:function (row) {
                                return [
                                    '<input type="checkbox" lay-filter="admin_switch" lay-skin="switch" lay-text="有效|无效" ',
                                    row.status == true ? "checked />" : " />"
                                ].join('');
                                /*return [
                                    '<input type="checkbox" name="admin_switch" id="admin_switch" lay-skin="switch" lay-text="是|否"/>'
                                ].join('');*/
                            }},
                        {field:'createAt', width: 120, title: '创建时间', sort: true},
                        {fixed: 'right', width:150,title: '操作', align:'center', toolbar: '#barTpl'}
                    ]]
                    ,page: {
                        limits:[10,20,30,40,100000]
                    }
                });
            };
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            switch(obj.event){
                case 'addProcess':
                    layer.open({
                        title: '新建工序',
                        content: 'static/html/layers/process-insert.html',
                        type: 2,
                        offset: 't',
                        area: ["1200px", "100%"],
                        success: function (layero, index) {
                            var iframe = window['layui-layer-iframe' + index];
                            var departs = [];
                            var products = [];
                            <!-- 向子页面进行数据传递 (下拉框选项, 及主键 -> 不一定连续)-->
                            <#list departList as depart>
                            departs.push({
                                'id' : '${depart.departUuid}',
                                'name' : '${depart.departName}'
                            });
                            </#list>
                            <#list productList as product>
                            products.push({
                                'id' : '${product.productUuid}',
                                'productNumber' : '${product.productNumber}'
                            });
                            </#list>
                            var dataDict = {
                                'departs': departs,
                                'products': products
                            };
                            iframe.child(dataDict);
                        }
                    });
            }
        });

        //监听工具条(右侧)
        table.on('tool(process-table)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            if(layEvent === 'edit'){ //编辑
                console.log($("#depart-select").val());
                // 发送更新请求
                $.ajax({
                    url: '/processs',
                    method: 'put',
                    data: JSON.stringify({
                        id: data.id,
                        processName:data.processName,
                        price:data.price,
                        remark:data.remark,
                        status: temp == null ? data.status : temp
                    }),
                    contentType: "application/json",

                    success: function (res) {
                        console.log(res);
                        if (res.code == 200) {
                            layer.msg('更改工序信息成功', {icon: 1});
                            obj.update({
                                id: data.id,
                                processName:data.processName,
                                price:data.price,
                                remark:data.remark,
                            });
                        } else {
                            layer.msg('更改工序信息失败', {icon: 2});
                        }
                    }
                });
            } else if (layEvent == 'del') {
                layer.confirm('删除工序' + data.processName + '?', {skin: 'layui-layer-molv',offset:'c', icon:'0'},function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
                        url: '/processs/' + data.id,
                        type: 'delete',
                        success: function (res) {
                            console.log(res);
                            if (res.code == 200) {
                                layer.msg('删除成功', {icon: 1, skin: 'layui-layer-molv', offset:'c'});
                            } else {
                                layer.msg('删除失败', {icon: 2, skin: 'layui-layer-molv', offset:'c'});
                            }
                        }
                    })
                });
            }
        });
    });
</script>
</body>
</html>