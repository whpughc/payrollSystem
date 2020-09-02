<!-- 产品管理-->
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="static/js/jquery-3.4.1.min.js"></script>
    <script src="static/layui/layui.js"></script>
    <link rel="stylesheet" href="static/layui/css/layui.css">
</head>

<script type="text/html" id="product-insert" >
    <form class="layui-form" method="post" <#--style="width:100%;height:100%;margin-top:20px;background-color: #f0f0f0" -->>
        <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">产品名称</label>
            <div class="layui-input-block">
                <input style="font-size:18px;color:black;border:black 1px solid;font-weight: bolder;"  id="name" type="text" name="name" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">产品型号</label>
            <div class="layui-input-block">
                <input style="font-size:18px;color:black;border:black 1px solid;font-weight: bolder;"  id="product-number" type="text" name="name" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item"  style="padding-right: 50px" >
            <label class="layui-form-label">季节</label>
            <div class="layui-input-block">
                <select id="season" lay-filter="season">
                    <option value="0" selected>春款</option>
                    <option value="1">夏款</option>
                    <option value="2">秋款</option>
                    <option value="3">冬款</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item layui-form-text" style="padding-right: 50px">
            <label class="layui-form-label">产品描述</label>
            <div class="layui-input-block">
                <textarea  style="font-size:18px;color:black;border:black 1px solid;font-weight: bolder;"  id="remark" name="remark" placeholder="" class="layui-textarea"></textarea>
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
                            <input id="search-input-name" type="text" name="title" required   placeholder="请输入名称" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div style="">
                        <label class="layui-form-label">型号</label>
                        <div class="layui-input-block layui-input-inline" style="margin-left:0px" >
                            <input id="search-input-number" type="text" name="title" required   placeholder="请输入型号" autocomplete="off" class="layui-input">
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
        <button class="layui-btn layui-btn-sm" lay-event="getCheckData">删除选中行数据</button>
        <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
        <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
    </div>
</script>

<script type="text/html" id="barTpl">
    <a class="layui-btn layui-btn-xs" lay-event="edit">保存</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


<script type="text/html" id="seasonTpl">
    <select id="{{d.id}}" name="season" lay-verify="required">
        <#list ["春款", "夏款", "秋款","冬款"] as season>
            <option value=${season_index}
                            {{#if (d.season == ${season_index?c}) { }}    <#-- 这里需要类型转换?c-->
                    selected
                    {{# }}}
            >
                ${season}</option>
        </#list>
    </select>
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
                {type: 'checkbox', fixed: 'left'},
                {field:'id', width:80,align:"center", title: 'ID',hide : true},
                {field:'productUuid',align:"center", width:80, title: '唯一标识',hide : true},
                {field:'name', width:150,align:"center", title: '产品名称',edit : true},
                {field:'productNumber', align:"center",width:100, title: '产品型号', edit: true},
                {field:'season', width:120,align:"center", title: '季节', templet: '#seasonTpl'},
                {field:'remark', width:150,align:"center",title:'产品描述', edit: true},
                {field:'status', width:130, align:"center",title: '状态', templet:function (row) {
                        return [
                            '<input type="checkbox" lay-filter="admin_switch" lay-skin="switch" lay-text="有效|无效" ',
                            row.status == true ? "checked />" : " />"
                        ].join('');
                    }},
                {field:'createAt', width:180, align:'center', title: '创建时间', sort: true},
                {fixed: 'right', width:150, align:'center', toolbar: '#barTpl'}
            ]]
            ,page: {
                limits:[10,20,30,40,100000]
            }
            ,done: function (res, curr, count) {
                // 支持表格内嵌下拉框
                $(".layui-table-body, .layui-table-box, .layui-table-cell").css('overflow', 'visible')
                // 下拉框CSS重写 (覆盖父容器的CSS - padding)
                $(".laytable-cell-1-0-2").css("padding", "0px")
                $(".laytable-cell-1-0-5").css("padding", "0px")
                $(".laytable-cell-1-0-6").css("padding", "0px")
                $(".laytable-cell-1-0-2 span").css("padding", "0 10px")
                $(".laytable-cell-1-0-5 span").css("padding", "0 10px")
                $(".laytable-cell-1-0-6 span").css("padding", "0 10px")
                $("td").css("padding-bottom", "8px")
            }
        });

        form.render('select');
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
                    curr: 1
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
                    curr: 1
                }
            });
        });

        var temp;
        form.on('switch(admin_switch)', function (obj) {
            temp = obj.elem.checked;
        });

        //监听工具条(上方)
        table.on('toolbar(product-table)', function (obj) {

            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getCheckData':

                    //获取选中数量
                    var selectCount = checkStatus.data.length;
                    if(selectCount == 0){
                        layer.msg('批量删除至少选中一项数据',function(){});
                        return false;
                    }

                    var ids=[];
                    var data = checkStatus.data;
                    $.each(data, function (index, item) {
                        ids.push(item.id);
                    });
                    layer.confirm('确定删除选中的用户？', {skin: 'layui-layer-molv',offset:'c', icon:'0'},function(index){
                        //向服务端发送删除指令
                        $.ajax({
                            url: '/products',
                            method: 'delete',
                            data: JSON.stringify({
                                ids:ids
                            }),
                            contentType: "application/json",
                            success: function (res) {
                                console.log(res);
                                if (res.code == 200) {
                                    layer.msg('删除产品成功', {icon: 1, skin: 'layui-layer-molv', offset:'c'});
                                } else {
                                    layer.msg('删除产品失败', {icon: 2, skin: 'layui-layer-molv', offset:'c'});
                                }
                                setTimeout(function(){
                                    location.reload();//重新加载页面表格
                                });
                            }
                        })
                    });
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.alert('选中了：'+ data.length + ' 个');
                    break;
                case 'isAll':
                    layer.alert(checkStatus.isAll ? '全选': '未全选');
                    break;
            }

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
                        area: ["500px", "500px"],
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
                                        var msg= (res.msg==null||res.msg=="")?"添加产品失败":res.msg;
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
                                            layer.msg(msg, {icon: 2});
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
                        season: $("#"+data.id+"").val(),
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