<!-- 产品管理-->
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="static/js/jquery-3.4.1.min.js"></script>
    <script src="static/layui/layui.js"></script>
    <link rel="stylesheet" href="static/layui/css/layui.css">
</head>
<body>

<script type="text/html" id="product-insert">
    <form class="layui-form" method="post" style="margin-top: 20px">
        <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">产品名称</label>
            <div class="layui-input-block">
                <input id="name" type="text" name="name" required  lay-verify="required" placeholder="请输入产品名称, 如: 阿福贝贝" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">产品型号</label>
            <div class="layui-input-block">
                <input id="product-number" type="text" name="name" required  lay-verify="required" placeholder="请输入产品型号, 如: A1234" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item"  style="padding-right: 50px">
            <label class="layui-form-label">季节</label>
            <div class="layui-input-block">
                <select id="season" lay-filter="season">
                    <option value="1" selected>春款</option>
                    <option value="2">夏款</option>
                    <option value="3">秋款</option>
                    <option value="4">冬款</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item layui-form-text" style="padding-right: 50px">
            <label class="layui-form-label">产品描述</label>
            <div class="layui-input-block">
                <textarea id="remark" name="remark" placeholder="请输入产品描述..." class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item" style="padding-right: 30px; width: 300px; margin: 0 auto; margin-top: 15px">
            <div class="layui-input-block">
                <button id="reset" type="reset" class="layui-btn layui-btn-primary" style="color: #FF5722">刷新</button>
            </div>
        </div>
    </form>
</script>

<!-- 卡片搜索面板-->
<div style="padding: 10px; background-color: #F2F2F2;">
    <div class="layui-row ">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header"><span style="margin-right: 10px; margin-bottom: 2px" class="layui-badge-dot"></span>快速搜索</div>
                <div class="layui-card-body layui-form-item">
                    <div  style="" >
                        <label class="layui-form-label">名称</label>
                        <div class="layui-input-block layui-input-inline"  style="margin-left:0px">
                            <input id="search-input-name" type="text" name="title" required  lay-verify="required" placeholder="请输入名称" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div style="">
                        <label class="layui-form-label">型号</label>
                        <div class="layui-input-block layui-input-inline" style="margin-left:0px" >
                            <input id="search-input-number" type="text" name="title" required  lay-verify="required" placeholder="请输入型号" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
</div>

<table class="layui-hide" id="product-table" lay-filter="product-table"></table>

<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addProduct">添加产品</button>
    </div>
</script>

<script type="text/html" id="barTpl">
    <a class="layui-btn layui-btn-xs" lay-event="edit">保存</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script>
    layui.use(['table', 'form'], function(){
        var table = layui.table;
        var form = layui.form;
        table.render({
            elem: '#product-table',
            url:'/products',
            toolbar: '#toolbar',
            title:'产品信息表',
            totalRow: true,
            parseData: function (res) {
                console.log(res);
                return {
                    "code": 0,
                    "msg": "",
                    "count": res.size,
                    data: res.data
                }
            }
            ,cols: [[
                {field:'id', width:80, title: 'ID',hide : true},
                {field:'productUuid', width:80, title: '唯一标识',hide : true},
                {field:'name', width:150, title: '产品名称',edit : true},
                {field:'productNumber', width:100, title: '产品型号', edit: true},
                {field:'season', width:100, title: '季节', templet: function(d){
                    switch (d.season) {
                    case 1: return '春款';break;
                    case 2: return '夏款';break;
                    case 3: return '秋款';break;
                    case 4: return '冬款';break;
                    }
                    }},
                {field:'remark', width:150, title:'产品描述', edit: true},
                {field:'status', width:130, title: '状态', templet:function (row) {
                        return [
                            '<input type="checkbox" lay-filter="admin_switch" lay-skin="switch" lay-text="有效|无效" ',
                            row.status == true ? "checked />" : " />"
                        ].join('');
                    }},
                {field:'createAt', width:180, title: '创建时间', sort: true},
                {fixed: 'right', width:150, align:'center', toolbar: '#barTpl'}
            ]]
            ,page: true
        });

        /* 搜索实现, 使用reload, 进行重新请求 */
        $("#search-input-name").on('input',function () {
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qname = $("#search-input-name").val();
            var qproductNumber = $("#search-input-number").val();
            if (qname.length > 0) whereData["qname"] = qname;
            if (qproductNumber.length > 0) whereData["qproductNumber"] = qproductNumber;
            table.reload("product-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 2
                }
            });
        });
        $("#search-input-number").on('input',function () {
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qname = $("#search-input-name").val();
            var qproductNumber = $("#search-input-number").val();
            if (qname.length > 0) whereData["qname"] = qname;
            if (qproductNumber.length > 0) whereData["qproductNumber"] = qproductNumber;
            table.reload("product-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 2
                }
            });
        });

        var temp;
        form.on('switch(admin_switch)', function (obj) {
            temp = obj.elem.checked;
        });

        //监听工具条(上方)
        table.on('toolbar(product-table)', function (obj) {
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            switch(obj.event){
                case 'addProduct':
                    layer.open({
                        btn: '新建',
                        title: '添加新产品',
                        content: $("#product-insert").text(),
                        offset: 'c',
                        area: ["500px", "600px"],
                        yes: function () {
                            /*form.render();*/
                            var name = $("#name").val();
                            var productNumber = $("#product-number").val();
                            var season = $("#season").find("option:selected").val();
                            var remark = $("#remark").val();
                            if (name.length <= 0) {
                                    layer.tips('产品名称不能为空', '#name',  {
                                        tipsMore: true
                                    });
                            } else {
                                // 调用新建API
                                var nowDate = new Date();
                                $.ajax({
                                    url: '/products',
                                    method: 'post',
                                    data: {
                                        name: name,
                                        productNumber: productNumber,
                                        season:season,
                                        remark: remark,
                                        status: 1
                                    },
                                    success: function (res) {
                                        console.log(res);
                                        if (res.code == 200) {
                                            // 执行局部刷新, 获取之前的TABLE内容, 再进行填充
                                            var dataBak = [];
                                            var tableBak = table.cache.product-table;
                                            for (var i = 0; i < tableBak.length; i++) {
                                                dataBak.push(tableBak[i]);      //将之前的数组备份
                                            }
                                            dataBak.push({
                                                name: $("#name"),
                                                productNumber: $("#product-number"),
                                                season:season,
                                                remark: $("#remark"),
                                                createAt: nowDate,
                                                status: 1
                                            });
                                            //console.log(dataBak);
                                            table.reload("product-table",{
                                                data:dataBak   // 将新数据重新载入表格
                                            });
                                            layer.msg('新建产品成功', {icon: 1});
                                        } else {
                                            layer.msg('新建产品失败', {icon: 2});
                                        }
                                    }
                                });
                            }
                        },
                    });
            }
            form.render();
        });



        //监听工具条(右侧)
        table.on('tool(product-table)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            if(layEvent === 'edit'){ //编辑
                // 发送更新请求
                $.ajax({
                    url: '/products',
                    method: 'put',
                    data: JSON.stringify({
                        id: data.id,
                        productNumber:data.productNumber,
                        name: data.name,
                        remark:data.remark,
                        status: temp == null ? data.status : temp
                    }),
                    contentType: "application/json",

                    success: function (res) {
                        console.log(res);
                        if (res.code == 200) {
                            layer.msg('更改产品信息成功', {icon: 1});
                            obj.update({
                                name: data.name,
                                productNumber: data.productNumber,
                                remark:data.remark,
                            });
                        } else {
                            layer.msg('更改产品信息失败', {icon: 2});
                        }
                    }
                });
            } else if (layEvent == 'del') {
                layer.confirm('删除产品' + data.name + '?', {skin: 'layui-layer-molv',offset:'c', icon:'0'},function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
                        url: '/products/' + data.id,
                        type: 'delete',
                        success: function (res) {
                            console.log(res);
                            if (res.code == 200) {
                                layer.msg('删除产品成功', {icon: 1, skin: 'layui-layer-molv', offset:'c'});
                            } else {
                                layer.msg('删除产品失败', {icon: 2, skin: 'layui-layer-molv', offset:'c'});
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