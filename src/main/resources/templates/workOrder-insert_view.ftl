<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>新增计件单子页面</title>
        <script src="static/js/jquery-3.4.1.min.js"></script>
        <script src="static/layui/layui.js"></script>
        <link rel="stylesheet" href="static/layui/css/layui.css">
</head>
<body style="/*width: 1250px;*/background-color: #F0F0F0;">
<span style="display:block;width:150px;margin:0px auto;font-size:25px;font-weight:900;font-color:blue;"><font
        color="blue">计件单录入</font></span>
<form class="layui-form" style="margin-top: 20px">
    <div class="layui-form-item ">

            <label class="layui-form-label" style="font-weight: bolder">订单号</label>
            <div class="layui-input-inline" style="width: 150px;">
                <b><input style="font-size:18px;color:red;border:black 1px solid;"  id="order-number" type="text" name="orderNumber" required lay-verify="required"
                       placeholder="" autocomplete="off" class="layui-input"></b>
            </div>

            <b><label class="layui-form-label" style="font-weight: bolder">部门</label></b>
            <div class="layui-input-inline"  style="width: 150px;margin-left: 10px;">
                <b><select  id="department-select" name="department" lay-verify="required" lay-search>
                    <option style="border:black 1px solid; " value="">请选择部门</option>
                </select></b>
            </div>

            <b><label class="layui-form-label" style="font-weight: bolder">型号</label></b>
            <div class="layui-input-inline" style="width: 150px;margin-left: 10px;">
                <b><select   id="product-select" name="product" lay-verify="required" lay-search>
                    <option value="">请选择型号</option>
                </select></b>
            </div>

            <label class="layui-form-label" style="font-weight: bolder">数量</label>
            <div class="layui-input-inline" style="width: 150px;margin-left: 10px;" >
                <b><input  style="font-size:18px;color:red;border:black 1px solid;"  id="number" type="text" name="number" lay-verify="title" autocomplete="off"
                       placeholder="" class="layui-input"></b>
            </div>

    </div>


<!-- 这里的计件输入框是下面循环出来的-->


    <button type="button" class="layui-btn" id="new_add">新增输入框</button>
    <div class="layui-form-item" style="margin-top: 15px;">
        <div class="layui-input-block" style="width:500px;margin-left: 520px;">
            <div class="layui-input-inline" style="width: 60px;">
                <button class="layui-btn" lay-submit lay-filter="formDemo" id="submit-btn">提交
                </button>
            </div>
            <div class="layui-input-inline" style="width: 60px;">
                <button style="margin-left: 10px" class="layui-btn" id="reset" type="reset"
                        class="layui-btn layui-btn-primary layui-input-inline">重置
                </button>
            </div>
        </div>
    </div>
</form>

<script>
    var layerCallback;  // 子页面回调函数
    // 父页面传过来的信息
    var productsIdAndProductNumber = [];
    var departsIdAndName = [];
    var departUuid;
    var productUuid;


    // 全局函数, 父页面向子页面传值
    function child(data) {
        productsIdAndProductNumber = data.products;
        departsIdAndName = data.departs;

        <#if Session["departUuid"]?exists>
        departUuid='${Session["departUuid"]}';
        </#if>

        <#if Session["productUuid"]?exists>
        productUuid='${Session["productUuid"]}';
        </#if>

        // 完成后, 回调, 进行渲染
        selectorAppend();
        /*for (var i = 0; i < data.products.length; i++) {
            console.log(data.products[i]);
        }
        for (var i = 0; i < data.departments.length; i++) {
            console.log(data.departments[i]);
        }*/
    }

    function selectorAppend() {
        /*进行下拉框动态拼接*/
        console.log(productsIdAndProductNumber);
        for (var i = 0; i < productsIdAndProductNumber.length; i++) {
            if (productsIdAndProductNumber[i].id === productUuid){
                $("#product-select").append('<option selected value=' + productsIdAndProductNumber[i].id + '>' + productsIdAndProductNumber[i].productNumber + '</option>');
            }else {
                $("#product-select").append('<option value=' + productsIdAndProductNumber[i].id + '>' + productsIdAndProductNumber[i].productNumber + '</option>');
            }

        }
        for (var i = 0; i < departsIdAndName.length; i++) {
            if (departsIdAndName[i].id === departUuid){
                $("#department-select").append('<option selected value=' + departsIdAndName[i].id + '>' + departsIdAndName[i].name + '</option>');
            }else {
                $("#department-select").append('<option value=' + departsIdAndName[i].id + '>' + departsIdAndName[i].name + '</option>');
            }

        }


        layui.use('form', function () {
            var form = layui.form

            //监听提交
            $("#submit-btn").click(function () {

                let fromData = [];
                var length = $("div[name='jijiandan']").length;
                for (var i=1;i<=length;i++){
                    let obj = {};
                    var processNumber = $("#processNumber"+i+"").text();
                    var employeeNumber = $("#employeeNumber"+i+"").val();
                    if (processNumber != null && processNumber !== "") {
                        obj.processNumber = processNumber;
                    }
                    if (employeeNumber != null && employeeNumber !== "") {
                        obj.employeeNumber = employeeNumber;
                        fromData.push(obj);
                    }
                }

                if (fromData == null || fromData == "") {
                    layer.alert('未添加订单，无法提交');
                    return false;
                }

                /*if ($("#department-select").val() == "" || $("#product-select").val() == "") {
                    layer.alert('产品或部门不能为空');
                    return false;
                }*/
                var ajaxData = {
                    orderList: fromData,
                    departUuid: $("#department-select").val(),
                    productUuid: $("#product-select").val(),
                    orderNumber: $("#order-number").val(),
                    color: $("#color").val(),
                    skuName: $("#sku-name").val(),
                    number: $("#number").val()
                };

                $.ajax({
                    url: '/workOrders',
                    async: false,
                    method: 'post',
                    data: JSON.stringify(ajaxData),   //ajaxData,
                    contentType: "application/json",
                    success: function (res) {
                        var msg= (res.msg==null||res.msg=="")?"添加计件单失败":res.msg;
                        if (res.code == 200) {
                            // 回调主界面
                            parent.layerCallback();
                            parent.layer.msg('添加计件单成功', {icon: 1});
                            var index = parent.layer.getFrameIndex(window.name);
                           /* parent.layer.close(index);*/
                        } else {
                            parent.layer.msg(msg, {icon: 2});
                        }
                        return false;

                    }
                });
                window.location.reload();
            });
        });
    }


</script>

<script>

    // 循环
    var sum='<div class="layui-form-item" name="number" style="margin-bottom: 0px;padding-left: 50px;">';
    for (var i = 0; i <6; i++) {

        var sum=sum+'<div style="width: 170px;float:left;">';


        for (var j = 1; j <=10; j++) {
            var html = ' <b><label id="processNumber'+(j+10*i)+'" class="layui-form-label" style="width: 30px;" >'+(j+10*i)+'</label></b>\n' +
                '            <div name="jijiandan" class="layui-input-inline" style="width: 100px;margin-bottom: 15px;">\n' +
                '                <b><input  style="font-size:18px;color:#0000FF;border:black 1px solid;" id="employeeNumber'+(j+10*i)+'"   type="text" name="employeeNumber'+(j+10*i)+'" lay-verify="title" autocomplete="off" placeholder=""\n' +
                '                       class="layui-input"></b>\n' +
                '            </div>\n';
            sum=sum+html;
        }
        sum=sum+'</div>';
    }
    sum=sum+'</div>';
    $('#new_add').before(sum);


    // 新增一行计件单
    $('#new_add').click(function () {
        var length = $("div[name='jijiandan']").length;
        var html ='    <div style="padding-left: 50px;" class="layui-form-item" name="number">\n' +
            '\n' +
            '            <label  id="processNumber'+(length+1)+'" class="layui-form-label" style="width: 30px;">'+(length+1)+'</label>\n' +
            '            <div name="jijiandan" class="layui-input-inline" style="width: 100px;">\n' +
            '                <b><input style="font-size:18px;color:red;border:black 1px solid; id="employeeNumber'+(length+1)+'"   type="text" name="employeeNumber'+(length+1)+'" lay-verify="title" autocomplete="off" placeholder=""\n' +
            '                       class="layui-input"></b>\n' +
            '            </div>\n' +
            '\n' +
            '\n' +
            '            <label style="width: 30px;" id="processNumber'+(length+2)+'" class="layui-form-label">'+(length+2)+'</label>\n' +
            '            <div name="jijiandan" class="layui-input-inline" style="width: 100px;">\n' +
            '                <b><input style="font-size:18px;color:red;border:black 1px solid; id="employeeNumber'+(length+2)+'"  type="text" name="employeeNumber'+(length+2)+'" lay-verify="title" autocomplete="off" placeholder=""\n' +
            '                       class="layui-input"></b>\n' +
            '            </div>\n' +
            '\n' +
            '\n' +
            '            <label style="width: 30px;" id="processNumber'+(length+3)+'" class="layui-form-label">'+(length+3)+'</label>\n' +
            '            <div name="jijiandan" class="layui-input-inline" style="width: 100px;">\n' +
            '                <b><input style="font-size:18px;color:red;border:black 1px solid; id="employeeNumber'+(length+3)+'"  type="text" name="employeeNumber'+(length+3)+'" lay-verify="title" autocomplete="off" placeholder=""\n' +
            '                       class="layui-input"></b>\n' +
            '            </div>\n' +
            '\n' +
            '\n' +
            '            <label style="width: 30px;" id="processNumber'+(length+4)+'" class="layui-form-label">'+(length+4)+'</label>\n' +
            '            <div name="jijiandan" class="layui-input-inline" style="width: 100px;">\n' +
            '                <b><input style="font-size:18px;color:red;border:black 1px solid; id="employeeNumber'+(length+4)+'"  type="text" name="employeeNumber'+(length+4)+'" lay-verify="title" autocomplete="off" placeholder=""\n' +
            '                       class="layui-input"></b>\n' +
            '            </div>\n' +
            '\n' +
            '\n' +
            '            <label style="width: 30px;" id="processNumber'+(length+5)+'" class="layui-form-label">'+(length+5)+'</label>\n' +
            '            <div name="jijiandan" class="layui-input-inline" style="width: 100px;">\n' +
            '                <b><input style="font-size:18px;color:red;border:black 1px solid; id="employeeNumber'+(length+5)+'"  type="text" name="employeeNumber'+(length+5)+'" lay-verify="title" autocomplete="off" placeholder=""\n' +
            '                       class="layui-input"></b>\n' +
            '            </div>\n' +
            '\n' +
            '\n' +
            '            <label style="width: 30px;" id="processNumber'+(length+6)+'" class="layui-form-label">'+(length+6)+'</label>\n' +
            '            <div name="jijiandan" class="layui-input-inline" style="width: 100px;">\n' +
            '                <b><input style="font-size:18px;color:red;border:black 1px solid; id="employeeNumber'+(length+6)+'"  type="text" name="employeeNumber'+(length+6)+'" lay-verify="title" autocomplete="off" placeholder=""\n' +
            '                       class="layui-input"></b>\n' +
            '            </div>\n' +
            '\n' +
            '    </div>';
        $('#new_add').before(html);
    });
</script>
</body>
</html>
