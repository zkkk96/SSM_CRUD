<%--
  Created by wei.bin.
  User: wei.bing
  Date: 2017/9/12
  Time: 16:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--
        不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
        以/开始的相对路径，找资源，以服务器的路径为标准,需要加上项目名
        （http://localhost:3306）
        http://localhost:3306/crud
    --%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>

<%--员工修改模态框--%>
<div class="modal fade" id="empUpdataModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">

                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">UserName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_updata_input" placeholder="Email">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_updata_input" value="M"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_updata_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select id="dept_updata_select" class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_updata_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAndModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">

                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">UserName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="UserName">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input" placeholder="Email">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select id="dept_add_select" class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>



<%--搭建显示页面，--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CURD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="check_all"></th>
                        <th>No</th>
                        <th>Name</th>
                        <th>Gender</th>
                        <th>Email</th>
                        <th>DeptName</th>
                        <th>操作</th>
                    </tr>
                <thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRecord, currentPage;

    //页面加载完成后，直接去发送一个Ajax请求，要到分页数据
    $(function () {
       to_page(1)
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn=" + pn,
            type:"GET",
            success:function (result) {
                //console.log(result);
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析显示分页条数据
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {

            var checkboxTd = $("<td><input type ='checkbox' class='check_item'/></td>");
            //alert(item.empName);
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            //为编辑按钮添加自定义属性，表示当前id
            editBtn.attr("edit-id", item.empId);
            var delBtn =$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            //为删除按钮添加自定义属性，表示当前id
            delBtn.attr("del-id", item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkboxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append(
            "当前"+ result.extend.pageInfo.pageNum +"页,总"+
            result.extend.pageInfo.pages +"页,总共"+
            result.extend.pageInfo.total+"条记录"
        );
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled")
        }else {
            firstPageLi.click(function () {
                to_page(1);
            });

            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });

            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        //添加首页和前一页
        ul.append(firstPageLi).append(prePageLi);

        //添加1、2、3遍历ul中添加页码
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
                numLi.addClass("active")
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });

        //添加末页和下一页
        ul.append(nextPageLi).append(lastPageLi);

        var navEl = $("<nav></nav>").append(ul);

        $("#page_nav_area").append(navEl);
        //navEl.appendTo("#page_nav_area");
    }

    //清空表单样式和内容
    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //弹出模态框
    $("#emp_add_modal_btn").click(function () {

        //重置表单内容
        //$("#empAndModal form")[0].reset();
        reset_form("#empAndModal form");
        //发送请求，查询部门信息 显示在下拉列表
        getDepts("#empAndModal select");

        $("#empAndModal").modal({
            backdrop:"static"
        });
    });

    //
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                //console.log(result);
                //$("#dept_add_select").append("")
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>")
                        .append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    function valodate_add_form() {
        //1.拿到要校验的数据
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|([\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            //alert("用户名应为6-16位英文和数字的组合或者2-5位中文");
            $("#empName_add_input").parent().removeClass("has-success");
            $("#empName_add_input").parent().addClass("has-error");
            $("#empName_add_input").next("span").text("用户名应为6-16位英文和数字的组合或者2-5位中文");
            return false;
        }else {
            $("#empName_add_input").parent().removeClass("has-error");
            $("#empName_add_input").parent().addClass("has-success");
            $("#empName_add_input").next("span").text("");
        }

        //2.校验邮箱
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            $("#email_add_input").parent().removeClass("has-error");
            $("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("邮箱格式不正确");
            return false;
        }else {
            $("#email_add_input").parent().removeClass("has-error");
            $("#email_add_input").parent().addClass("has-success");
            $("#email_add_input").next("span").text("");
        }
        return true;
    }

    //校验用户名
    $("#empName_add_input").on('input', function () {
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName=" + empName,
            type:"POST",
            success:function (result) {
                if (result.code == 100){
                    $("#empName_add_input").parent().removeClass("has-error");
                    $("#empName_add_input").parent().addClass("has-success");
                    $("#empName_add_input").next("span").text("用户名可用");

                    $("#emp_save_btn").attr("ajax_va", "success");
                }else {
                    $("#empName_add_input").parent().removeClass("has-success");
                    $("#empName_add_input").parent().addClass("has-error");
                    $("#empName_add_input").next("span").text(result.extend.va_msg);

                    $("#emp_save_btn").attr("ajax_va", "error");
                }
            }
        });
    });

    //保存事件
    $("#emp_save_btn").click(function () {

        //1.模态框中填写的表单数据提交给服务器进行保存
        //2.校验数据
        if (!valodate_add_form()){
            return false;
        }

        if($(this).attr("ajax_va")=="error"){
            return false;
        }

        //3.发送Ajax请求
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data: $("#empAndModal form").serialize(),
            success:function (result) {
                //alert(result.msg);
                if(result.code == 100){
                    //员工保存成功，关闭模态框，显示刚才保存的数据
                    $("#empAndModal").modal("hide");
                    to_page(totalRecord);
                }else {
                    console.log(result);
                    //显示失败信息
                    //有那个字段的错误信息就显示那个
                    if (undefined !== result.extend.errorFields.email){
                        //显示错误信息
                        $("#email_add_input").parent().removeClass("has-error");
                        $("#email_add_input").parent().addClass("has-error");
                        $("#email_add_input").next("span").text(result.extend.errorFields.email);
                    }
                    if (undefined !== result.extend.errorFields.empName){
                        //显示错误信息
                        $("#empName_add_input").parent().removeClass("has-success");
                        $("#empName_add_input").parent().addClass("has-error");
                        $("#empName_add_input").next("span").text(result.extend.errorFields.empName);
                    }
                }
            }
        });
    });

    $(document).on("click", ".edit_btn", function () {
        //alert("edit");
        //0.查出员工信息
        //1.查出部门信息，显示部门列表
        getDepts("#empUpdataModal select");
        getEmp($(this).attr("edit-id"));
        //吧员工的id传递给更新按钮
        $("#emp_updata_btn").attr("edit-id",$(this).attr("edit-id"));
        //弹出模态框
        $("#empUpdataModal").modal({
            backdrop:"static"
        });
    });

    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/" + id,
            type:"GET",
            success:function (result) {
                //console.log(result);
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_updata_input").val(empData.email);
                $("#empUpdataModal input[name=gender]").val([empData.gender]);
                $("#empUpdataModal select").val([empData.dId]);
            }
        });
    }

    //点击更新 更新员工
    $("#emp_updata_btn").click(function () {
        //1.校验邮箱
        var email = $("#email_updata_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            $("#email_updata_input").parent().removeClass("has-error");
            $("#email_updata_input").parent().addClass("has-error");
            $("#email_updata_input").next("span").text("邮箱格式不正确");
            return false;
        }else {
            $("#email_updata_input").parent().removeClass("has-error");
            $("#email_updata_input").parent().addClass("has-success");
            $("#email_updata_input").next("span").text("");
        }

        //发送Ajax请求
        $.ajax({
            url:"${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdataModal form").serialize(),
            //未配置HttpPutFormContentFilter使用如下方法。并用POST
            //data:$("#empUpdataModal form").serialize() + "&_method=PUT",
            success:function (result) {
                //alert(result.msg);
                //1.关闭模态框
                $("#empUpdataModal").modal("hide");
                //返回修改页面
                to_page(currentPage);
                //alert(currentPage);
            }
        });
    });

    //删除员工
    $(document).on("click", ".delete_btn", function () {
        //1.弹出确认对话框
        //得到姓名
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        //得到ID
        var empId = $(this).attr("del-id");
        //确认发送请求
        if(confirm("确认删除【" + empName + "】吗？")){
            $.ajax({
                url:"${APP_PATH}/emp/" + empId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    //全选、全不选
    $("#check_all").click(function () {
        //这些dom原生的属性用prop()获取或者修改
        //自定义的属性用attr()获取
        //若用attr()获取原生，但属性为标注出，得到的是undefined
        //$(this).prop("checked");
        $(".check_item").prop("checked", $(this).prop("checked"));
    });
    //check_item全选后 check_all选择
    $(document).on("click", ".check_item", function () {
        //判断当前选中的元素是否为5个
        var flag = $(".check_item:checked").length ==  $(".check_item").length;
            $("#check_all").prop("checked", flag);
    });

    //批量删除事件
    $("#emp_delete_all_btn").click(function () {
        //$(".check_item")
        var empNames = "";
        var del_list = "";
        $.each($(".check_item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            //组装id字符串
            del_list += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        //去除多余的逗号
        empNames = empNames.substring(0, empNames.length - 1);
        del_list = del_list.substring(0, del_list.length - 1);
        if(confirm("确认删除【" + empNames + "】吗？")){
            //alert(empNames);
            $.ajax({
                url:"${APP_PATH}/emp/" + del_list,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
