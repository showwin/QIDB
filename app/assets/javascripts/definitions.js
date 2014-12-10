var datasetCounter = 1;
var denomDefCounter = 1;
var numerDefCounter = 1;
var referenceCounter = 1;

$('#test_ckb').change(function(){
	if ($(this).is(':checked')) {
		$('#result').append('<p>hey</p>');
	} else {
		$('#result').append('<p>jude</p>');
	}
});

function addDatasetForm(){
	datasetCounter++;
	var id = datasetCounter;

	var select = $('<select class="form-control btn-sm" id="dataset'+id+'" name="dataset'+id+'">');
	$('<option value="DPC様式1">DPC様式1</option>').appendTo(select);
	$('<option value="E/Fファイル">E/Fファイル</option>').appendTo(select);
	$('<option value="Fファイル">Fファイル</option>').appendTo(select);
	$('<option value="EFファイル">EFファイル</option></select>').appendTo(select);

	$(select).appendTo($("#dataset-form"));
}

function addDenomDefForm(){
	denomDefCounter++;
	id = denomDefCounter;

	$('<div id="denom-def'+id+'">').appendTo($('#denom-def'));
	var defForm = $('#denom-def'+id);
	defForm.append('<h5><b>定義'+id+'</b></h5>');
	defForm.append('<h5>説明</h5>');
	defForm.append('<input class="form-control" id="denom_exp'+id+'" name="denom_exp'+id+'"placeholder="脳血管疾患等リハビリテーションまたはリハビリテーション総合計画評価を受けた症例　レセ電コードに以下のいずれかが含まれる症例" type="text">');
	defForm.append('<h5>CSVデータ(option)</h5>');
	defForm.append('<input id="denom_file'+id+'" name="denom_file'+id+'" type="file">');
	defForm.append('<br>');
}

function addNumerDefForm(){
	numerDefCounter++;
	id = numerDefCounter;

	$('<div id="numer-def'+id+'">').appendTo($('#numer-def'));
	var defForm = $('#numer-def'+id);
	defForm.append('<h5><b>定義'+id+'</b></h5>');
	defForm.append('<h5>説明</h5>');
	defForm.append('<input class="form-control" id="numer_exp'+id+'" name="numer_exp'+id+'"placeholder="脳血管疾患等リハビリテーションまたはリハビリテーション総合計画評価を受けた症例　レセ電コードに以下のいずれかが含まれる症例" type="text">');
	defForm.append('<h5>CSVデータ(option)</h5>');
	defForm.append('<input id="numer_file'+id+'" name="numer_file'+id+'" type="file">');
	defForm.append('<br>');
}

function showDetail(){
	var html = '<h5><b>詳細</b></h5>';
	html += '<input class="form-control" id="definition_detail" name="definition_detail" placeholder="(e.g.) something" type="text">'
	$(html).appendTo('#factor_definition_detail');
}

function hideDetail(){
	$('#factor_definition_detail').empty();
}

function addReferenceForm(){
	referenceCounter++;
	id = referenceCounter;

	$('<input class="form-control" id="reference'+id+'" name="reference'+id+'" type="text" placeholder="American Heart Association. Heart disease and stroke statistics - 2008 update. Dallas (TX): American Heart Association; 2008. 43 p." /><br>').appendTo('#references')
}
