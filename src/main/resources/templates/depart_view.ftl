<!-- 部门管理-->
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="static/js/jquery-3.4.1.min.js"></script>
    <script src="static/layui/layui.js"></script>
    <link rel="stylesheet" href="static/layui/css/layui.css">
</head>
<body>

<script type="text/html" id="dept-insert" style="margin-top: 50px">
    <form class="layui-form" method="post">
        <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">部门名称</label>
            <div class="layui-input-block">
                <input id="dept-name" type="text" name="name" required  lay-verify="required" placeholder="请输入部门名称, 如: 人事部" autocomplete="off" class="layui-input">
            </div>
        </div>
  <#--      <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">部门经理</label>
            <div class="layui-input-block">
                <input id="dept-manager" type="text" name="name" required  lay-verify="required" placeholder="请输入部门经理, 如: 张三" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">电话</label>
            <div class="layui-input-block">
                <input id="phone" type="text" name="name" required  lay-verify="required|phone|number" placeholder="请输入11位电话号" autocomplete="off" class="layui-input">
            </div>
        </div>-->
        <div class="layui-form-item layui-form-text" style="padding-right: 50px">
            <label class="layui-form-label">部门描述</label>
            <div class="layui-input-block">
                <textarea id="dept-description" name="description"  placeholder="请输入部门描述..." class="layui-textarea"></textarea>
            </div>
        </div>
    </form>
</script>

<table class="layui-hide" id="dept-table" lay-filter="dept-table"></table>

<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addDept">添加部门</button>
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
            elem: '#dept-table',
            url:'/departs',
            toolbar: '#toolbar',
            title:'部门信息表',
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
                /*{type: 'checkbox', fixed: 'left'},*/
                {field:'id', width:80, title: 'ID',hide : true},
                {field:'departUuid', width:80, title: '唯一标识',hide : true},
                {field:'departName', width:150, title: '部门名称', edit: true},
              /*  {field:'departManager', width:150, title: '部门经理', edit: true},
                {field:'phone', width:150, title: '电话', edit: true},*/
                {field:'remark', width:120, title:'部门描述', edit: true},
                {field:'status', width:130, title: '状态', templet:function (row) {
                        return [
                            '<input type="checkbox" lay-filter="admin_switch" lay-skin="switch" lay-text="有效|无效" ',
                            row.status == true ? "checked />" : " />"
                        ].join('');
                        /*return [
                            '<input type="checkbox" name="admin_switch" id="admin_switch" lay-skin="switch" lay-text="是|否"/>'
                        ].join('');*/
                    }},
                {field:'createAt', width:180, title: '创建时间', sort: true},
                {fixed: 'right', width:150, align:'center', toolbar: '#barTpl'}
            ]]
            ,page: {
                limits:[10,20,30,40,100000]
            }
        });

        var temp;
        form.on('switch(admin_switch)', function (obj) {
            temp = obj.elem.checked;
        });

        //监听工具条(上方)
        table.on('toolbar(dept-table)', function (obj) {
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            switch(obj.event){
                case 'addDept':
                    layer.open({
                        btn: '新建',
                        title: '添加新部门',
                        content: $("#dept-insert").text(),
                        offset: 'c',
                        area: ["500px", "500px"],
                        yes: function () {
                            var name = $("#dept-name").val();
                            var description = $("#dept-description").val();
                            var departManager= $("#dept-manager").val();
                            var phone = $("#phone").val();
                            if (name.length <= 0 ) {
                                if (name.length <= 0) {
                                    layer.tips('部门名称不能为空', '#dept-name',  {
                                        tipsMore: true
                                    });
                                }
                              /*  if (description.length <= 0) {
                                    layer.tips('部门描述不能为空', '#dept-description', {
                                        tipsMore: true
                                    });
                                }*/
                            } else {
                                // 调用新建API
                                var nowDate = new Date();
                                $.ajax({
                                    url: '/departs',
                                    method: 'post',
                                    data: {
                                        departName: name,
                                        departManager: departManager,
                                        phone : phone,
                                        remark: description,
                                        status: 1
                                    },
                                    success: function (res) {
                                        console.log(res);
                                        if (res.code == 200) {
                                            // 执行局部刷新, 获取之前的TABLE内容, 再进行填充
                                            var dataBak = [];
                                            var tableBak = table.cache.dept-table;
                                            for (var i = 0; i < tableBak.length; i++) {
                                                dataBak.push(tableBak[i]);      //将之前的数组备份
                                            }
                                            dataBak.push({
                                                departName: $("#dept-name"),
                                                departManager: $("#dept-manager"),
                                                phone : $("#phone"),
                                                remark: $("#depart-description"),
                                                createdAt: nowDate,
                                                status: 1
                                            });
                                            //console.log(dataBak);
                                            table.reload("dept-table",{
                                                data:dataBak   // 将新数据重新载入表格
                                            });
                                            layer.msg('新建部门成功', {icon: 1});
                                        } else {
                                            layer.msg('新建部门失败', {icon: 2});
                                        }
                                    }
                                });
                            }
                        },
                    });
            }
        });



        //监听工具条(右侧)
        table.on('tool(dept-table)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            if(layEvent === 'edit'){ //编辑
                // 发送更新请求
                $.ajax({
                    url: '/departs',
                    method: 'put',
                    data: JSON.stringify({
                        id: data.id,
                        departName: data.departName,
                        departManager: data.departManager,
                        phone:data.phone,
                        remark:data.remark,
                        status: temp == null ? data.status : temp
                    }),
                    contentType: "application/json",

                    success: function (res) {
                        console.log(res);
                        if (res.code == 200) {
                            layer.msg('更改部门信息成功', {icon: 1});
                            obj.update({
                                id: data.id,
                                departName: data.departName,
                                departManager: data.departManager,
                                phone:data.phone,
                                remark:data.remark,
                            });
                        } else {
                            layer.msg('更改部门信息失败', {icon: 2});
                        }
                    }
                });
            } else if (layEvent == 'del') {
                layer.confirm('删除部门' + data.departName + '?', {skin: 'layui-layer-molv',offset:'c', icon:'0'},function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
                        url: '/departs/' + data.id,
                        type: 'delete',
                        success: function (res) {
                            console.log(res);
                            if (res.code == 200) {
                                layer.msg('删除部门成功', {icon: 1, skin: 'layui-layer-molv', offset:'c'});
                            } else {
                                layer.msg('删除部门失败', {icon: 2, skin: 'layui-layer-molv', offset:'c'});
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