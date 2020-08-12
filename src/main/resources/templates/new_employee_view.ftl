<!-- 员工管理-->
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="static/js/jquery-3.4.1.min.js"></script>
    <script src="static/layui/layui.js"></script>
    <link rel="stylesheet" href="static/layui/css/layui.css">
</head>
<body>

<!-- 卡片搜索面板-->
<div style="padding: 10px; background-color: #F2F2F2;">
    <div class="layui-row layui-col-space15">
        <div class="">
            <div class="layui-card">
                <div class="layui-card-header"><span style="margin-right: 10px; margin-bottom: 2px" class="layui-badge-dot"></span>快速搜索</div>
                <div class="layui-card-body layui-form-item layui-form ">

                    <div style=""<#--class="layui-form-label" style="margin-bottom: 10px;"-->>
                        <label class="layui-form-label">部门</label>
                        <div class="layui-input-block layui-input-inline" style="width: 200px;margin-left: 0;">
                            <select lay-search lay-filter="depart-select"  id="depart-select" name="department"  style="width:200px;height:38px;border-color: #e6e6e6" >
                                <option style="" value="">请选择部门</option>
                            </select>
                        </div>
                    </div>

                    <div style="">
                        <label class="layui-form-label">姓名</label>
                        <div class="layui-input-block layui-input-inline" style="width: 200px;margin-left: 0;">
                            <input id="search-input-name" type="text" name="title" required  lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div style="">
                        <label class="layui-form-label">员工工号</label>
                        <div class="layui-input-block layui-input-inline" style="width: 200px;margin-left: 0;">
                            <input id="search-input-employeeNumber" type="text" name="title" required  lay-verify="required" placeholder="请输入员工工号" autocomplete="off" class="layui-input">
                        </div>
                    </div>




                </div>
            </div>
        </div>
    </div>
</div>


<table class="layui-hide" id="employee-table" lay-filter="employee-table"></table>

<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addEmployee">添加员工</button>
    </div>
</script>

<script type="text/html" id="barTpl">
    <a class="layui-btn layui-btn-xs" lay-event="edit">保存</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


<script>
    var departs = [];

    <#list departList as depart>
    departs.push({
        'id' : '${depart.departUuid}',
        'name' : '${depart.departName}'
    });
    </#list>

    for (var i = 0; i < departs.length; i++) {
        $("#depart-select").append('<option value=' + departs[i].id + '>' + departs[i].name + '</option>');
    }
</script>

<#--<script type="text/html" id="positionTpl">
    <select id="position-select" name="position" lay-verify="required" lay-search>
        <#if positionList?? && positionList?size gt 0>
            <#list positionList as position>
                <option value=${position.id}
                        {{#if (d.positionId == ${position.id}) { }}
                        selected
                        {{# }}}
                >
                    ${position.name}</option>
            </#list>
        </#if>
    </select>
</script>-->



<script type="text/html" id="departTpl">
    <select id="department-select" name="department" lay-verify="required">
        <#if departList?? && departList?size gt 0>
            <#list departList as depart>
                <option value=${depart.id}
                        {{#if (d.departId == ${depart.id}) { }}
                        selected
                        {{# }}}
                >
                    ${depart.departName}</option>
            </#list>
        </#if>
    </select>
</script>

<#--<script type="text/html" id="departTpl2">
    <select id="department-select2" name="department2" lay-verify="required" lay-search>
        <#if departList?? && departList?size gt 0>
            <#list departList as depart>
                <option value=${depart.departUuid}
                        {{#if (d.departUuid == ${depart.departUuid}) { }}
                        selected
                        {{# }}}
                >
                    ${depart.departName}</option>
            </#list>
        </#if>
    </select>
</script>-->

<script>
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
</script>
<#--<script type="text/html" id="departTpl2">
    <select id="department-select" name="department" lay-verify="required">
        <#if departList?? && departList?size gt 0>
            <#list departList as depart>
                <option value=${depart.departUuid}
                        {{#if (d.departUuid == ${depart.departUuid?string}) { }}
                        selected
                        {{# }}}
                >
                    ${depart.departName}</option>
            </#list>
        </#if>
    </select>

</script>-->

<style type="text/css">
    .layui-table-cell{
        height:36px;
        line-height: 36px;
    }
</style>



<script>

    var tableContent = [];
    layui.use(['table', 'form'], function(){
        var form = layui.form;
        var table = layui.table;
        table.render({
            elem: '#employee-table',
            url:'/newEmployees',
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
                {field:'employeeUuid', width:30, title: '唯一标识',hide:true},
                {field:'employeeName', width:120, title: '姓名', edit: true},
                {field:'employeeNumber', width:120, title: '员工码',edit: true},
                {field:'sex', width:50, title: '性别', templet:function (row) {
                        return [
                            '<div>',
                            row.sex == 0 ? '男' : '女',
                            '</div>'
                        ].join('');
                    }},
                {field:'phone', width: 120, title:'电话', edit: true},

                {field:'idCard', width:200, title:'身份证', edit: true},
                <!--{field:'address', width: 140, title:'地址', edit: true},-->
                /*{field:'positionId', width: 150, title:'职位', templet: '#positionTpl'},*/
                /*{field:'position.name', width: 110, title:'职位', templet: function (d) {
                    if (d.position == null) return "未分配";
                    return d.position.name
                }},*/
                {field:'departId', width: 150, title:'部门', templet: '#departTpl'},
                /*{field:'departUuid', width: 120, title:'部门', templet: '#departTpl2'},
                {field:'departUuid', width: 120, title:'部门', templet: '<div>{{sotitle(d.departUuid,departs)}}</div>'},*/
                {field:'status',width:120, title: '状态', templet:function (row) {
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
            ,page: true
            ,done: function (res, curr, count) {
                // 支持表格内嵌下拉框
                $(".layui-table-body, .layui-table-box, .layui-table-cell").css('overflow', 'visible')
                // 下拉框CSS重写 (覆盖父容器的CSS - padding)
                $(".laytable-cell-1-0-5").css("padding", "0px")
                $(".laytable-cell-1-0-7").css("padding", "0px")
                $(".laytable-cell-1-0-8").css("padding", "0px")
                $(".laytable-cell-1-0-5 span").css("padding", "0 10px")
                $(".laytable-cell-1-0-7 span").css("padding", "0 10px")
                $(".laytable-cell-1-0-8 span").css("padding", "0 10px")

                $("td").css("padding", "0px")
            }
        });

        /* 搜索实现, 使用reload, 进行重新请求 */
        $("#search-input-name").on('input',function () {
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qname = $("#search-input-name").val();
            var qphone = $("#search-input-phone").val();
            var qidcard = $("#search-input-idcard").val();
            var qemployeeNumber = $("#search-input-employeeNumber").val();
            var qdepartUuid = $("#depart-select").val();
            if (qname.length > 0) whereData["qname"] = qname;
            if (qphone.length > 0) whereData["qphone"] = qphone;
            if (qidcard.length > 0) whereData["qidcard"] = qidcard;
            if (qdepartUuid.length > 0) whereData["qdepartUuid"] = qdepartUuid;
            if (qemployeeNumber.length > 0) whereData["qemployeeNumber"] = qemployeeNumber;
            table.reload("employee-table",{
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
            var qname = $("#search-input-name").val();
            var qphone = $("#search-input-phone").val();
            var qidcard = $("#search-input-idcard").val();
            var qemployeeNumber = $("#search-input-employeeNumber").val();
            var qdepartUuid = $("#depart-select").val();
            if (qname.length > 0) whereData["qname"] = qname;
            if (qphone.length > 0) whereData["qphone"] = qphone;
            if (qidcard.length > 0) whereData["qidcard"] = qidcard;
            if (qdepartUuid.length > 0) whereData["qdepartUuid"] = qdepartUuid;
            if (qemployeeNumber.length > 0) whereData["qemployeeNumber"] = qemployeeNumber;
            table.reload("employee-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 1
                }
            });
        });

        $("#search-input-phone").on('input',function () {
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qname = $("#search-input-name").val();
            var qphone = $("#search-input-phone").val();
            var qidcard = $("#search-input-idcard").val();
            var qemployeeNumber = $("#search-input-employeeNumber").val();
            var qdepartUuid = $("#depart-select").val();
            if (qname.length > 0) whereData["qname"] = qname;
            if (qphone.length > 0) whereData["qphone"] = qphone;
            if (qidcard.length > 0) whereData["qidcard"] = qidcard;
            if (qdepartUuid.length > 0) whereData["qdepartUuid"] = qdepartUuid;
            if (qemployeeNumber.length > 0) whereData["qemployeeNumber"] = qemployeeNumber;
            table.reload("employee-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 1
                }
            });
        });
        $("#search-input-idcard").on('input',function () {
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qname = $("#search-input-name").val();
            var qphone = $("#search-input-phone").val();
            var qidcard = $("#search-input-idcard").val();
            var qemployeeNumber = $("#search-input-employeeNumber").val();
            var qdepartUuid = $("#depart-select").val();
            if (qname.length > 0) whereData["qname"] = qname;
            if (qphone.length > 0) whereData["qphone"] = qphone;
            if (qidcard.length > 0) whereData["qidcard"] = qidcard;
            if (qdepartUuid.length > 0) whereData["qdepartUuid"] = qdepartUuid;
            if (qemployeeNumber.length > 0) whereData["qemployeeNumber"] = qemployeeNumber;
            table.reload("employee-table",{
                where: {
                    query: JSON.stringify(whereData)
                }
                ,page: {
                    curr: 1
                }
            });
        });

        // 下拉框搜索
        // 部门搜索下拉框
        form.on('select(depart-select)', function(data){
            // 用来传递到后台的查询参数MAP
            var whereData = {};
            var qname = $("#search-input-name").val();
            var qphone = $("#search-input-phone").val();
            var qidcard = $("#search-input-idcard").val();
            var qemployeeNumber = $("#search-input-employeeNumber").val();
            var qdepartUuid = $("#depart-select").val();
            if (qname.length > 0) whereData["qname"] = qname;
            if (qphone.length > 0) whereData["qphone"] = qphone;
            if (qidcard.length > 0) whereData["qidcard"] = qidcard;
            if (qdepartUuid.length > 0) whereData["qdepartUuid"] = qdepartUuid;
            if (qemployeeNumber.length > 0) whereData["qemployeeNumber"] = qemployeeNumber;
            table.reload("employee-table",{
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

        var temp;
        form.on('switch(admin_switch)', function (obj) {
            temp = obj.elem.checked;
        });

        table.on('toolbar(employee-table)', function (obj) {
            // 回调函数
            layerCallback= function(callbackData) {
                // 执行局部刷新, 获取之前的TABLE内容, 再进行填充
                var dataBak = [];
                var tableBak = table.cache.employee-table;
                for (var i = 0; i < tableBak.length; i++) {
                    dataBak.push(tableBak[i]);      //将之前的数组备份
                }
                // 添加到表格缓存
                dataBak.push(callbackData);
                //console.log(dataBak);
                table.reload("employee-table",{
                    data:dataBak   // 将新数据重新载入表格
                });
            };
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            switch(obj.event){
                case 'addEmployee':
                    layer.open({
                        title: '新建员工',
                        content: 'static/html/layers/new_employee-insert.html',
                        type: 2,
                        offset: 't',
                        area: ["500px", "600px"],
                        success: function (layero, index) {
                            var iframe = window['layui-layer-iframe' + index];
                            var departs = [];
                            <!-- 向子页面进行数据传递 (下拉框选项, 及主键 -> 不一定连续)-->
                            <#list departList as depart>
                            departs.push({
                                'id' : '${depart.id}',
                                'name' : '${depart.departName}'
                            });
                            </#list>
                            var dataDict = {
                                /*'positions': positions,*/
                                'departs': departs
                            };
                            iframe.child(dataDict);
                        }
                    });
            }
        });

        //监听工具条(右侧)
        table.on('tool(employee-table)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            if(layEvent === 'edit'){ //编辑
                console.log($("#department-select").val());
                layer.alert($('select[name="department"] option:selected').val());
                console.log($('select[name="department"] option:selected').val());
                // 发送更新请求
                $.ajax({
                    url: '/newEmployees',
                    method: 'put',
                    data: JSON.stringify({
                        id: data.id,
                        employeeName: data.employeeName,
                        employeeNumber:data.employeeNumber,
                        phone: data.phone,
                        idCard: data.idCard,
                        departId: $('select[name="department"] option:selected').val(),
                        status: temp == null ? data.status : temp
                    }),
                    contentType: "application/json",

                    success: function (res) {
                        var msg= (res.msg==null||res.msg=="")?"更改员工信息失败":res.msg;
                        console.log(res);
                        if (res.code == 200) {
                            layer.msg('更改员工信息成功', {icon: 1});
                            obj.update({
                                id: data.id,
                                employeeName: data.employeeName,
                                employeeNumber:data.employeeNumber,
                                phone: data.phone,
                                idCard: data.idCard
                            });
                        } else {
                            layer.msg(msg, {icon: 2});
                        }
                    }
                });
            } else if (layEvent == 'del') {
                layer.confirm('删除员工' + data.employeeName + '?', {skin: 'layui-layer-molv',offset:'c', icon:'0'},function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
                        url: '/newEmployees/' + data.id,
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