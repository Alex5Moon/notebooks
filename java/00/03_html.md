### HTML 
- 超文本标记语言（英语：HyperText Markup Language，简称：HTML）是一种用于创建网页的标准标记语言。 
>
- 可以使用HTML 来建立自己的WEB 站点，HTML 运行在浏览器上，由浏览器来解析。
### 简单页面
>
```
<!doctype html>
<html>
  <head>
    <meta charset = "utf-8">
    <title>insert title</title>
  </head>
  <body>

  </body>
</html>
```
>
### 文本元素
#### 标题 h1~h6
>
#### 段落
- `<p></p>`
>
#### 列表
- 有序列表
```
<ol>
  <li></li>
  <li></li>
  ...
</ol>
```
>
- 无序列表
```
<ul>
  <li></li>
  <li></li>
  ...
</ul>  
```
>
- 列表嵌套
>
#### 行内元素
>
```
  <p><i>金猴</i>奋起<b>千钧棒</b>，<u>玉宇</u>澄清<span style = "color:green">万里埃</span>。</p>
```
>
#### 空格折叠
- ` &nbsp`
>
#### 图片
- ` <img src = "url"> `
>
#### 超链接
- ` <a href = "https://lu666666.github.io/" target = "_blank">我的github</a> `
- 锚点使用 name
>
#### 表格 table
```
  	<table border = "1" cellspacing = "0" width = "40%">
			<tr>
				<td>1.1</td>
				<td>1.2</td>
				<td>1.3</td>
			</tr>
			<tr>
				<td>2.1</td>
				<td>2.2</td>
				<td>2.3</td>
			</tr>
		</table>
```
>
### 分区 div
```
	<div style = "color:red">
		<h3>满江红</h3>
		<p>多少事，从来急；</p>
		<p>天地转，光阴迫。</p>
		<p>一万年太久，只争朝夕。</p>
		<p>四海翻腾云水怒，五洲震荡风雷激。</p>
		<p>要扫除一切害人虫，全无敌。</p>
	</div>
```
>
### 表单 form
```
	<form action="https://lu666666.github.io/">
		<p>
			账号：<input type = "text" value = "123" maxlength = "10" readonly/>
		</p>
		<p>
			密码：<input type = "password"/>
		</p>
		<p>
			性别：<input type = "radio" name = "sex" checked/>男
			    <input type = "radio" name = "sex" />女
		</p>	
		<p>
			兴趣：<input type = "checkbox" checked/>乒乓球
			    <input type = "checkbox" checked/>足球
			    <input type = "checkbox" /> 篮球
		</p>
		<p>
			<input type = "hidden" value = "123"/>
		</p>	     
		<p>
			头像<input type = "file"/>
		</p>
		<p>
			<input type = "submit" value = "注册"/>
			<input type = "reset" value = "重置"/>
			<input type = "button" value = "try"/>
		</p>
		
		<p>
			<input type = "checkbox" id = "c1" checked/>
			<label for = "c1">我已阅读并遵守协议。</label>
		</p>
		
		<p>
			城市：
			<select>
				<option>请选择</option>
				<option>北京</option>
				<option selected>上海</option>
				<option>广州</option>
			</select>
		</p>
		
		<p>
			备注：
			<textarea rows = "3" cols = "20">备注</textarea>
		</p>
		
	</form>	
```
