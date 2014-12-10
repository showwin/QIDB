var datasetCounter = 1;
var defDataCounter = [0,1];
function addDatasetForm(){
	// カウンタを回す
	datasetCounter++;

	var datasetForm = document.getElementById("dataset-form");
	var input = document.createElement("selmct");
	input.setAttribute('class', 'form-control btn-sm');
	input.id = "dataset"+datasetCounter;
	input.name = "dataset"+datasetCounter;;

	var elm = document.createElement("option");
	elm.value = "DPC様式1";
	var str = document.createTextNode("DPC様式1");
	elm.appendChild(str);
	input.appendChild(elm);

	var elm = document.createElement("option");
	elm.value = "E/Fファイル";
	var str = document.createTextNode("E/Fファイル");
	elm.appendChild(str);
	input.appendChild(elm);

	var elm = document.createElement("option");
	elm.value = "Fファイル";
	var str = document.createTextNode("Fファイル");
	elm.appendChild(str);
	input.appendChild(elm);

	var elm = document.createElement("option");
	elm.value = "EFファイル";
	var str = document.createTextNode("EFファイル");
	elm.appendChild(str);
	input.appendChild(elm);

	datasetForm.appendChild(input);
}

function addDenomDefDataForm(formNumber){
	defDataCounter[formNumber]++;

	var defForm = $('#denom-def'+formNumber)
	var id = defDataCounter[formNumber]
	$('<div class="row" id="denom-def'+formNumber+'-'+id+'">').appendTo(defForm)
	var div = $('#denom-def'+formNumber+'-'+id)
	var html = '<div class="col-md-3 form-group" >'
	html += '<h5>Key</h5>'
	html += '<input class="form-control" id="denom_data_key'+formNumber+'-'+id+'" name="denom_data_key'+formNumber+'-'+id+'" placeholder="(option) レセ電コード" type="text">'
	$(html).appendTo(div)

	var html = '<div class="col-md-9 form-group" >'
	html += '<h5>Value</h5>'
	html += '<input class="form-control" id="denom_data_value'+formNumber+'-'+id+'" name="denom_data_value'+formNumber+'-'+id+'" placeholder="(option) [&quot;180027610&quot;, &quot;180032410&quot;, … , &quot;180024710&quot;]" type="text">'
	$(html).appendTo(div)
}

function addDenomDefForm(){
	id = defDataCounter.length
	defDataCounter[id] = 1

	$('<div id="denom-def'+id+'">').appendTo($('#denom-def'))
	var defForm = $('#denom-def'+id)
	defForm.append("<h5>"+id+"</h5>");
	defForm.append('<h5>説明</h5>');
	defForm.append('<input class="form-control" id="denom_exp'+id+'" name="denom_exp'+id+'"placeholder="脳血管疾患等リハビリテーションまたはリハビリテーション総合計画評価を受けた症例　レセ電コードに以下のいずれかが含まれる症例" type="text">');

	$('<div class="row" id="denom-def'+id+'-1">').appendTo(defForm)
	var div = $('#denom-def'+id+'-1')
	var html = '<div class="col-md-3 form-group" >'
	html += '<h5>Key</h5>'
	html += '<input class="form-control" id="denom_data_key'+id+'-1" name="denom_data_key'+id+'-1" placeholder="(option) レセ電コード" type="text">'
	$(html).appendTo(div)

	var html = '<div class="col-md-9 form-group" >'
	html += '<h5>Value</h5>'
	html += '<input class="form-control" id="denom_data_value'+id+'-1" name="denom_data_value'+id+'-1" placeholder="(option) [&quot;180027610&quot;, &quot;180032410&quot;, … , &quot;180024710&quot;]" type="text">'
	$(html).appendTo(div)

	$('<button type="button" class="btn btn-sm btn-info btn-circle" onClick="addDenomDefDataForm('+id+')">＋</i></button><nobr> (Key, Valueの追加)</nobr><br><br>').appendTo($('#denom-def'))
}

function addNumerDefDataForm(formNumber){
	defDataCounter[formNumber]++;

	var defForm = $('#numer-def'+formNumber)
	var id = defDataCounter[formNumber]
	$('<div class="row" id="numer-def'+formNumber+'-'+id+'">').appendTo(defForm)
	var div = $('#numer-def'+formNumber+'-'+id)
	var html = '<div class="col-md-3 form-group" >'
	html += '<h5>Key</h5>'
	html += '<input class="form-control" id="numer_data_key'+formNumber+'-'+id+'" name="numer_data_key'+formNumber+'-'+id+'" placeholder="(option) レセ電コード" type="text">'
	$(html).appendTo(div)

	var html = '<div class="col-md-9 form-group" >'
	html += '<h5>Value</h5>'
	html += '<input class="form-control" id="numer_data_value'+formNumber+'-'+id+'" name="numer_data_value'+formNumber+'-'+id+'" placeholder="(option) [&quot;180027610&quot;, &quot;180032410&quot;, … , &quot;180024710&quot;]" type="text">'
	$(html).appendTo(div)
}

function addNumerDefForm(){
	id = defDataCounter.length
	defDataCounter[id] = 1

	$('<div id="numer-def'+id+'">').appendTo($('#numer-def'))
	var defForm = $('#numer-def'+id)
	defForm.append("<h5>"+id+"</h5>");
	defForm.append('<h5>説明</h5>');
	defForm.append('<input class="form-control" id="numer_exp'+id+'" name="numer_exp'+id+'"placeholder="脳血管疾患等リハビリテーションまたはリハビリテーション総合計画評価を受けた症例　レセ電コードに以下のいずれかが含まれる症例" type="text">');

	$('<div class="row" id="numer-def'+id+'-1">').appendTo(defForm)
	var div = $('#numer-def'+id+'-1')
	var html = '<div class="col-md-3 form-group" >'
	html += '<h5>Key</h5>'
	html += '<input class="form-control" id="numer_data_key'+id+'-1" name="numer_data_key'+id+'-1" placeholder="(option) レセ電コード" type="text">'
	$(html).appendTo(div)

	var html = '<div class="col-md-9 form-group" >'
	html += '<h5>Value</h5>'
	html += '<input class="form-control" id="numer_data_value'+id+'-1" name="numer_data_value'+id+'-1" placeholder="(option) [&quot;180027610&quot;, &quot;180032410&quot;, … , &quot;180024710&quot;]" type="text">'
	$(html).appendTo(div)

	$('<button type="button" class="btn btn-sm btn-info btn-circle" onClick="addnumerDefDataForm('+id+')">＋</i></button><nobr> (Key, Valueの追加)</nobr><br><br>').appendTo($('#numer-def'))
}
