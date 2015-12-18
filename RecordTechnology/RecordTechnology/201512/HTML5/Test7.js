<!DOCTYPE HTML>

<html>

<body>

<br />
<br />

<form>

<select name="cars">

<option value="volvo">Volvo</option>
<option value="saab">Saab</option>
<option value="fiat" selected="selected">Fiat</option>
<option value="audi">Audi</option>

</select>

</form>


<p>

This example cannot be edited <br />
beause our editor uses a textarea
for input,
and your browser does not allow
a textarea inside a textarea.

</p>

<textarea rows="10" cols="30">  The cat was playing in the garden.

</textarea>

<form>
<input type="button" value="hello world!">
</form>


<form>

<fieldset>
<legend>传奇信息</legend>

身高： <input type="text" />
<br />
体重： <input type="text" />

</fieldset>

</form>


<p> 如果表单周围没有边框，说明您的浏览器太老了。 </p>



<!-- 带有输入框和确认框的表单 -->

<form action="/example/html/form_action.asp" method="get">

<p>First name: <input type="text" name="fname" /> </p>
<p> Last name: <input type="text" name="lname" /> </p>
<input type="submit" value="提交">

</from>

 <!-- 电子邮件 -->

<form action="MAILTO:someone@w3school.com.cn" method="post" enctype="text/plain">

<h3>  这个表单会把电子邮件发送到 W3School. </h3>

姓名： <br />
<input type="text" name="name" value="your name" size="20"> <!-- size 是指输入框的宽度 -->
<br />
电邮：<br />
<input type="text" name="mail" value="your email" size="20">
<br />
内容： <br />
<input type="text" name="comment" value="your comment" size="40">
<br />
<br />

<input type="submit" value="发送" />
<input type="reset" value="重置" />


</form>


</body>


</html>










