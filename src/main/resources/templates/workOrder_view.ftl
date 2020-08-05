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
        <div >
            <div class="layui-card ">
                <div class="layui-card-header"><span style="margin-right: 10px; margin-bottom: 2px" class="layui-badge-dot"></span>快速搜索</div>
                <div class="layui-card-body layui-form-item layui-form">

                    <div class=" layui-col-md3" style="margin-bottom: 10px;">
                        <label class="layui-form-label ">部门</label>
                        <div class="layui-input-block" style="width: 200px">
                            <select  lay-filter="depart-select"   id="depart-select" name="department" lay-search  style="width:200px;height:38px;border-color: #e6e6e6" >
                                <option style="" value="">请选择部门</option>
                            </select>
                        </div>
                    </div>

                    <div class="layui-col-md3" style="margin-bottom: 10px">
                        <label class="layui-form-label">产品</label>
                        <div class="layui-input-block" style="width: 200px">
                            <select lay-filter="product-select" id="product-select" name="position" lay-search  style="width:200px;height:38px;border-color: #e6e6e6">
                                <option value="">请选择型号</option>
                            </select>
                        </div>
                    </div>

                    <div class="layui-col-md3" style="margin-bottom: 10px">
                        <label class="layui-form-label">计件单号</label>
                        <div class="layui-input-block" style="width: 200px">
                            <input id="search-input-orderNumber" type="text" name="title"  placeholder="请输入计件单号" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-col-md3" style="margin-bottom: 10px">
                        <label class="layui-form-label">工序号</label>
                        <div class="layui-input-block" style="width: 200px">
                            <input id="search-input-processNumber" type="text" name="title"  placeholder="请输入工序号" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-col-md3" style="margin-bottom: 10px">
                        <label class="layui-form-label">员工工号</label>
                        <div class="layui-input-block" style="width: 200px">
                            <input id="search-input-employeeNumber" type="text" name="title"  placeholder="请输入员工工号" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-col-md3 " style="margin-bottom: 10px;">
                        <label class="layui-form-label">开始日期</label>
                        <div class="layui-input-block">
                            <input id="search-input-startTime" type="text" name="date"  lay-verify="date"  autocomplete="off" class="layui-input" style="width: 200px">
                        </div>
                    </div>

                    <div class="layui-col-md3 " style="margin-bottom: 10px;">
                        <label class="layui-form-label">结束日期</label>
                        <div class="layui-input-block">
                            <input id="search-input-endTime" type="text" name="date"  lay-verify="date"  autocomplete="off" class="layui-input" style="width: 200px">
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>



<table class="layui-hide" id="workOrder-table" lay-filter="workOrder-table"></table>

<script type="text/html" id="toolbar">
    <div class="layui-btn-container" style="float: left;">
        <button class="layui-btn layui-btn-sm" lay-event="addProcess" style="float: left;">新增计件单</button>
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
    layui.use(['table', 'form', 'layedit', 'laydate'], function(){

        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;

        // 下拉框搜索
          // 部门搜索下拉框
        form.on('select(depart-select)', function(data){
          // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qorderNumber = $("#search-input-orderNumber").val();
            var qdepartUuid = $("#depart-select").val();
            var qproductUuid = $("#product-select").val();
            var qprocessNumber = $("#search-input-processNumber").val();
            var qemployeeNumber = $("#search-input-employeeNumber").val();
            var qstartTime = $("#search-input-startTime").val();
            var qendTime = $("#search-input-endTime").val();
            if (qorderNumber.length > 0) whereData["qorderNumber"] = qorderNumber;
            if (qdepartUuid.length > 0) whereData["qdepartUuid"] = qdepartUuid;
            if (qproductUuid.length > 0) whereData["qproductUuid"] = qproductUuid;
            if (qemployeeNumber.length > 0) whereData["qemployeeNumber"] = qemployeeNumber;
            if (qstartTime.length > 0) whereData["qstartTime"] = qstartTime;
            if (qendTime.length > 0) whereData["qendTime"] = qendTime;
            if (qprocessNumber.length > 0) whereData["qprocessNumber"] = qprocessNumber;
            table.reload("workOrder-table", {
                where: {
                    query: JSON.stringify(whereData)
                }
                , page: {
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
            var qorderNumber = $("#search-input-orderNumber").val();
            var qdepartUuid = $("#depart-select").val();
            var qproductUuid = $("#product-select").val();
            var qprocessNumber = $("#search-input-processNumber").val();
            var qemployeeNumber = $("#search-input-employeeNumber").val();
            var qstartTime = $("#search-input-startTime").val();
            var qendTime = $("#search-input-endTime").val();
            if (qorderNumber.length > 0) whereData["qorderNumber"] = qorderNumber;
            if (qdepartUuid.length > 0) whereData["qdepartUuid"] = qdepartUuid;
            if (qproductUuid.length > 0) whereData["qproductUuid"] = qproductUuid;
            if (qemployeeNumber.length > 0) whereData["qemployeeNumber"] = qemployeeNumber;
            if (qstartTime.length > 0) whereData["qstartTime"] = qstartTime;
            if (qendTime.length > 0) whereData["qendTime"] = qendTime;
            if (qprocessNumber.length > 0) whereData["qprocessNumber"] = qprocessNumber;
            table.reload("workOrder-table",{
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

        //日期
        laydate.render({
            elem: '#search-input-startTime'
            ,type: 'datetime'
            ,theme: 'molv'
            ,done:function(value){//value, date, endDate点击日期、清空、现在、确定均会触发。回调返回三个参数，分别代表：生成的值、日期时间对象、结束的日期时间对象
                startTime(value);
            }
        });
        laydate.render({
            elem: '#search-input-endTime'
            ,type: 'datetime'
            ,theme: 'molv'
            ,done:function(value){//value, date, endDate点击日期、清空、现在、确定均会触发。回调返回三个参数，分别代表：生成的值、日期时间对象、结束的日期时间对象
                endTime(value);
            }
        });

        /*var form = layui.form;*/
        var table = layui.table;
        table.render({
            elem: '#workOrder-table',
            url:'/workOrders',
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
                {field:'orderUuid', width:30, title: '唯一标识',hide:true},
                {field:'orderNumber', width:100, title: '计件单号'},
                {field:'departUuid', width:100, title: '部门',templet:'<div>{{sotitle(d.departUuid,departs)}}</div>'},
                {field:'productUuid', width:100, title: '产品',templet:'<div>{{sotitle2(d.productUuid,products)}}</div>'},
                {field:'color', width:150, title: '颜色'},
                {field:'skuName', width:100, title: '尺码'},
                {field:'number', width:100, title: '数量'},
                {field:'processNumber', width:100, title: '工序号'},
                {field:'employeeNumber', width:100, title: '员工'},
                {field:'money', width:100, title: '金额'},
                {field:'createAt', width:200, title: '创建时间', sort: true},
                {fixed: 'right', width:150,title: '操作', align:'center', toolbar: '#barTpl'}
            ]]
            ,page: true
        });


        function startTime(value)
        {
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qorderNumber = $("#search-input-orderNumber").val();
            var qdepartUuid = $("#depart-select").val();
            var qproductUuid = $("#product-select").val();
            var qemployeeNumber = $("#search-input-employeeNumber").val();
            var qprocessNumber = $("#search-input-processNumber").val();
            var qstartTime = value;
            var qendTime = $("#search-input-endTime").val();
            if (qorderNumber.length > 0) whereData["qorderNumber"] = qorderNumber;
            if (qdepartUuid.length > 0) whereData["qdepartUuid"] = qdepartUuid;
            if (qproductUuid.length > 0) whereData["qproductUuid"] = qproductUuid;
            if (qemployeeNumber.length > 0) whereData["qemployeeNumber"] = qemployeeNumber;
            if (qstartTime.length > 0) whereData["qstartTime"] = qstartTime;
            if (qendTime.length > 0) whereData["qendTime"] = qendTime;
            if (qprocessNumber.length > 0) whereData["qprocessNumber"] = qprocessNumber;
            table.reload("workOrder-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 1
                }
            });
        }

        function endTime(value)
        {
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qorderNumber = $("#search-input-orderNumber").val();
            var qdepartUuid = $("#depart-select").val();
            var qproductUuid = $("#product-select").val();
            var qemployeeNumber = $("#search-input-employeeNumber").val();
            var qprocessNumber = $("#search-input-processNumber").val();
            var qstartTime = $("#search-input-startTime").val();
            var qendTime = value;
            if (qorderNumber.length > 0) whereData["qorderNumber"] = qorderNumber;
            if (qdepartUuid.length > 0) whereData["qdepartUuid"] = qdepartUuid;
            if (qproductUuid.length > 0) whereData["qproductUuid"] = qproductUuid;
            if (qemployeeNumber.length > 0) whereData["qemployeeNumber"] = qemployeeNumber;
            if (qstartTime.length > 0) whereData["qstartTime"] = qstartTime;
            if (qendTime.length > 0) whereData["qendTime"] = qendTime;
            if (qprocessNumber.length > 0) whereData["qprocessNumber"] = qprocessNumber;
            table.reload("workOrder-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 1
                }
            });
        }


        /* 搜索实现, 使用reload, 进行重新请求 */
        $("#search-input-processNumber").on('input',function () {
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qorderNumber = $("#search-input-orderNumber").val();
            var qdepartUuid = $("#depart-select").val();
            var qproductUuid = $("#product-select").val();
            var qprocessNumber = $("#search-input-processNumber").val();
            var qemployeeNumber = $("#search-input-employeeNumber").val();
            var qstartTime = $("#search-input-startTime").val();
            var qendTime = $("#search-input-endTime").val();
            if (qorderNumber.length > 0) whereData["qorderNumber"] = qorderNumber;
            if (qdepartUuid.length > 0) whereData["qdepartUuid"] = qdepartUuid;
            if (qproductUuid.length > 0) whereData["qproductUuid"] = qproductUuid;
            if (qemployeeNumber.length > 0) whereData["qemployeeNumber"] = qemployeeNumber;
            if (qstartTime.length > 0) whereData["qstartTime"] = qstartTime;
            if (qendTime.length > 0) whereData["qendTime"] = qendTime;
            if (qprocessNumber.length > 0) whereData["qprocessNumber"] = qprocessNumber;
            table.reload("workOrder-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 1
                }
            });
        });

        $("#search-input-orderNumber").on('input',function () {
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qorderNumber = $("#search-input-orderNumber").val();
            var qdepartUuid = $("#depart-select").val();
            var qproductUuid = $("#product-select").val();
            var qprocessNumber = $("#search-input-processNumber").val();
            var qemployeeNumber = $("#search-input-employeeNumber").val();
            var qstartTime = $("#search-input-startTime").val();
            var qendTime = $("#search-input-endTime").val();
            if (qorderNumber.length > 0) whereData["qorderNumber"] = qorderNumber;
            if (qdepartUuid.length > 0) whereData["qdepartUuid"] = qdepartUuid;
            if (qproductUuid.length > 0) whereData["qproductUuid"] = qproductUuid;
            if (qemployeeNumber.length > 0) whereData["qemployeeNumber"] = qemployeeNumber;
            if (qstartTime.length > 0) whereData["qstartTime"] = qstartTime;
            if (qendTime.length > 0) whereData["qendTime"] = qendTime;
            if (qprocessNumber.length > 0) whereData["qprocessNumber"] = qprocessNumber;
            table.reload("workOrder-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 1
                }
            });
        });

        $("#search-input-employeeNumber").on('input',function () {
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qorderNumber = $("#search-input-orderNumber").val();
            var qdepartUuid = $("#depart-select").val();
            var qproductUuid = $("#product-select").val();
            var qprocessNumber = $("#search-input-processNumber").val();
            var qemployeeNumber = $("#search-input-employeeNumber").val();
            var qstartTime = $("#search-input-startTime").val();
            var qendTime = $("#search-input-endTime").val();
            if (qorderNumber.length > 0) whereData["qorderNumber"] = qorderNumber;
            if (qdepartUuid.length > 0) whereData["qdepartUuid"] = qdepartUuid;
            if (qproductUuid.length > 0) whereData["qproductUuid"] = qproductUuid;
            if (qemployeeNumber.length > 0) whereData["qemployeeNumber"] = qemployeeNumber;
            if (qstartTime.length > 0) whereData["qstartTime"] = qstartTime;
            if (qendTime.length > 0) whereData["qendTime"] = qendTime;
            if (qprocessNumber.length > 0) whereData["qprocessNumber"] = qprocessNumber;
            table.reload("workOrder-table",{
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

        table.on('toolbar(workOrder-table)', function (obj) {
            // 回调函数
            layerCallback= function() {

                table.render({
                    elem: '#workOrder-table',
                    url:'/workOrders',
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
                        {field:'orderUuid', width:30, title: '唯一标识',hide:true},
                        {field:'orderNumber', width:100, title: '计件单号'},
                        {field:'departUuid', width:100, title: '部门',templet:'<div>{{sotitle(d.departUuid,departs)}}</div>'},
                        {field:'productUuid', width:100, title: '产品',templet:'<div>{{sotitle2(d.productUuid,products)}}</div>'},
                        {field:'color', width:100, title: '颜色'},
                        {field:'skuName', width:100, title: '尺码'},
                        {field:'number', width:100, title: '数量'},
                        {field:'processNumber', width:100, title: '工序数'},
                        {field:'employeeNumber', width:100, title: '员工'},
                        {field:'money', width:100, title: '金额'},
                        {field:'createAt', width:200, title: '创建时间', sort: true},
                        {fixed: 'right', width:150,title: '操作', align:'center', toolbar: '#barTpl'}
                    ]]
                    ,page: true
                });
            };
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            switch(obj.event){
                case 'addProcess':
                    layer.open({
                        title: '新增计件单',
                        content: 'static/html/layers/workOrder-insert.html',
                        type: 2,
                        offset: 't',
                        area: ["1200px", "600px"],
                        success: function (layero, index) {
                            var iframe = window['layui-layer-iframe' + index];
                            var departs = [];
                            var products = [];
                            var departUuid;
                            var productUuid;
                            <!-- 向子页面进行数据传递 (下拉框选项, 及主键 -> 不一定连续)-->

                            <#if Session["departUuid"]?exists>
                            departUuid='${Session["departUuid"]}';
                            </#if>

                            <#if Session["productUuid"]?exists>
                            productUuid='${Session["productUuid"]}';
                            </#if>

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
                                'products': products,
                                'departUuid':departUuid,
                                'productUuid':productUuid
                            };
                            iframe.child(dataDict);
                        }
                    });
            }
        });

        //监听工具条(右侧)
        table.on('tool(workOrder-table)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            if(layEvent === 'edit'){ //编辑
                console.log($("#depart-select").val());
                // 发送更新请求
                $.ajax({
                    url: '/workOrders',
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
                            layer.msg('更新计件单信息成功', {icon: 1});
                            obj.update({
                                id: data.id,
                                processName:data.processName,
                                price:data.price,
                                remark:data.remark,
                            });
                        } else {
                            layer.msg('更改计件单信息失败', {icon: 2});
                        }
                    }
                });
            } else if (layEvent == 'del') {
                layer.confirm('删除计件单?', {skin: 'layui-layer-molv',offset:'c', icon:'0'},function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
                        url: '/workOrders/' + data.id,
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