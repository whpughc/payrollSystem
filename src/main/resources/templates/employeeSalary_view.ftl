
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="static/js/jquery-3.4.1.min.js"></script>
    <script src="static/layui/layui.js"></script>
    <link rel="stylesheet" href="static/layui/css/layui.css">
</head>
<body>

<#--<script type="text/html" id="dept-insert">
    <form class="layui-form" method="post">
        <div class="layui-form-item" style="padding-right: 50px">
            <label class="layui-form-label">部门名称</label>
            <div class="layui-input-block">
                <input id="dept-name" type="text" name="name" required  lay-verify="required" placeholder="请输入部门名称, 如: 人事部" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item layui-form-text" style="padding-right: 50px">
            <label class="layui-form-label">部门描述</label>
            <div class="layui-input-block">
                <textarea id="dept-description" name="description" placeholder="请输入部门描述..." class="layui-textarea"></textarea>
            </div>
        </div>

    </form>

</script>-->

<!-- 卡片搜索面板-->

<div style="padding: 10px; background-color: #F2F2F2;/*height: 180px;*/">
    <div class="layui-row layui-col-space15">
        <div >
            <div class="layui-card ">
                <div class="layui-card-header"><span style="margin-right: 10px; margin-bottom: 2px" class="layui-badge-dot"></span>快速搜索</div>
                <div class="layui-card-body layui-form-item layui-form">

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


<table class="layui-hide" id="employeeSalary-table" lay-filter="employeeSalary-table"></table>

<#--
<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addDept">添加部门</button>
    </div>
</script>
-->

<#--<script type="text/html" id="barTpl">
    <a class="layui-btn layui-btn-xs" lay-event="edit">保存</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>-->
<script>
    layui.use(['table', 'form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;
        var table = layui.table;


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


        function startTime(value)
        {
            // 用来传递到后台的查询参数MAP
            var whereData = {};

            var qstartTime = value;
            var qendTime = $("#search-input-endTime").val();

            if (qstartTime.length > 0) whereData["qstartTime"] = qstartTime;
            if (qendTime.length > 0) whereData["qendTime"] = qendTime;

            table.reload("employeeSalary-table",{
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

            var qstartTime = $("#search-input-startTime").val();
            var qendTime = value;

            if (qstartTime.length > 0) whereData["qstartTime"] = qstartTime;
            if (qendTime.length > 0) whereData["qendTime"] = qendTime;

            table.reload("employeeSalary-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 1
                }
            });
        }

        table.render({
            elem: '#employeeSalary-table',
            url:'/employeeSalarys',
            toolbar: '#toolbar',
            parseData: function (res) {
                console.log(res);
                return {
                    "code": 0,
                    "msg": "",
                    "count": res.size,
                    data: res.data
                }
            }
            ,totalRow: true
            ,cols: [[
                {field:'employeeNumber', width:120, title: '员工工号', totalRowText: '合计'},
                {field:'employeeName', width:150, title: '员工姓名'},
                {field:'departName', width:120, title:'部门'},
                {field:'wage', width:180, title: '总工资',sort: true, totalRow: true},
                /*{fixed: 'right', width:150, align:'center', toolbar: '#barTpl'}*/
            ]]
            ,page: {
                limits:[10,20,30,40,100000],
                limit:100000
            }
        });

        /*table.on('toolbar(employeeSalary-table)', function (obj) {
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
                        area: ["500px", "300px"],
                        yes: function () {
                            var name = $("#dept-name").val();
                            var description = $("#dept-description").val();
                            if (name.length <= 0  || description.length <= 0) {
                                if (name.length <= 0) {
                                    layer.tips('部门名称不能为空', '#dept-name',  {
                                        tipsMore: true
                                    });
                                }
                                if (description.length <= 0) {
                                    layer.tips('部门描述不能为空', '#dept-description', {
                                        tipsMore: true
                                    });
                                }
                            } else {
                                // 调用新建API
                                var nowDate = new Date();
                                $.ajax({
                                    url: '/depts',
                                    method: 'post',
                                    data: {
                                        name: name,
                                        description: description,
                                        createdTime: nowDate
                                    },
                                    success: function (res) {
                                        console.log(res);
                                        if (res.code == 200) {
                                            // 执行局部刷新, 获取之前的TABLE内容, 再进行填充
                                            var dataBak = [];
                                            var tableBak = table.cache.employeeSalary-table;
                                            for (var i = 0; i < tableBak.length; i++) {
                                                dataBak.push(tableBak[i]);      //将之前的数组备份
                                            }
                                            dataBak.push({
                                                name: $("#dept-name"),
                                                description: $("#dept-description"),
                                                createdTime: nowDate
                                            });
                                            //console.log(dataBak);
                                            table.reload("employeeSalary-table",{
                                                data:dataBak   // 将新数据重新载入表格
                                            });
                                            layer.msg('新建部门成功', {icon: 1});
                                        } else {
                                            layer.msg('新建部门失败', {icon: 2});
                                        }
                                    }
                                });
                            }
                        }
                    });
            }
        });
*/


        /*//监听工具条(右侧)
        table.on('tool(employeeSalary-table)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            if(layEvent === 'edit'){ //编辑
                // 发送更新请求
                $.ajax({
                    url: '/depts',
                    method: 'put',
                    data: JSON.stringify({
                        id: data.id,
                        name: data.name,
                        description: data.description
                    }),
                    contentType: "application/json",

                    success: function (res) {
                        console.log(res);
                        if (res.code == 200) {
                            layer.msg('更改部门信息成功', {icon: 1});
                            obj.update({
                                name: data.name,
                                description: data.description
                            });
                        } else {
                            layer.msg('更改部门信息失败', {icon: 2});
                        }
                    }
                });
            } else if (layEvent == 'del') {
                layer.confirm('删除部门' + data.name + '?', {skin: 'layui-layer-molv',offset:'c', icon:'0'},function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
                        url: '/depts/' + data.id,
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
*/
    });
</script>
</body>
</html>