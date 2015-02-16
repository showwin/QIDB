var datasetCounter = 0;
var denomDefCounter = 0;
var numerDefCounter = 0;
var riskDefCounter = 0;
var referenceCounter = 1;

function showNumberForm(project){
	if ($('#'+project).is(':checked')) {
		$('#'+project+'_number').append('<input class="form-control input-sm" id="number" name="'+project+'_number" placeholder="指標番号　(e.g.) 0548" type="text">');
	} else {
		$('#'+project+'_number').html('');
	}
}

function addDatasetForm(init){
	if (init > datasetCounter) {
		datasetCounter = init;
	}
	var id = datasetCounter;
	if (id >= 5) {
		return
	}
	var select = $('<input class="form-control" id="dataset_others_'+id+'" name="dataset_others_'+id+'" placeholder="その他のデータセット名" type="text">');
	$(select).appendTo($("#dataset-form"));
	datasetCounter++;
}

function addDenomDefForm(init){
	if (init > denomDefCounter) {
		denomDefCounter = init;
	}
	denomDefCounter++;
	id = denomDefCounter;

	$('<div id="denom-def'+id+'">').appendTo($('#denom-def'));
	var defForm = $('#denom-def'+id);
	defForm.append('<h5><b>定義'+id+'</b></h5>');
	defForm.append('<h5>説明</h5>');
	defForm.append('<textarea class="form-control" id="denom_exp'+id+'" name="denom_exp'+id+'"placeholder="脳血管疾患等リハビリテーションまたはリハビリテーション総合計画評価を受けた症例　レセ電コードに以下のいずれかが含まれる症例" type="text"></textarea>');
	defForm.append('<h5>CSVデータ(option)</h5>');
	defForm.append('<input id="denom_file'+id+'" name="denom_file'+id+'" type="file">');
	defForm.append('<br>');
}

function hideDenomCSVForm(id){
	$('#denom_file'+id).hide();
	$('#denom_file'+id+'_exp').hide();
}

function showDenomCSVForm(id){
	$('#denom_file'+id).show();
	$('#denom_file'+id+'_exp').show();
}

function addNumerDefForm(init){
	if (init > numerDefCounter) {
		numerDefCounter = init;
	}
	numerDefCounter++;
	id = numerDefCounter;

	$('<div id="numer-def'+id+'">').appendTo($('#numer-def'));
	var defForm = $('#numer-def'+id);
	defForm.append('<h5><b>定義'+id+'</b></h5>');
	defForm.append('<h5>説明</h5>');
	defForm.append('<textarea class="form-control" id="numer_exp'+id+'" name="numer_exp'+id+'"placeholder="脳血管疾患等リハビリテーションまたはリハビリテーション総合計画評価を受けた症例　レセ電コードに以下のいずれかが含まれる症例" type="text"></textarea>');
	defForm.append('<h5>CSVデータ(option)</h5>');
	defForm.append('<input id="numer_file'+id+'" name="numer_file'+id+'" type="file">');
	defForm.append('<br>');
}

function hideNumerCSVForm(id){
	$('#numer_file'+id).hide();
	$('#numer_file'+id+'_exp').hide();
}

function showNumerCSVForm(id){
	$('#numer_file'+id).show();
	$('#numer_file'+id+'_exp').show();
}

function addRiskDefForm(init){
	if (init > riskDefCounter) {
		riskDefCounter = init;
	}
	riskDefCounter++;
	id = riskDefCounter;

	$('<div id="risk-def'+id+'">').appendTo($('#risk-def'));
	var defForm = $('#risk-def'+id);
	defForm.append('<h5><b>定義'+id+'</b></h5>');
	defForm.append('<h5>説明</h5>');
	defForm.append('<textarea class="form-control" id="risk_exp'+id+'" name="risk_exp'+id+'" type="text"></textarea>');
	defForm.append('<h5>CSVデータ(option)</h5>');
	defForm.append('<input id="risk_file'+id+'" name="risk_file'+id+'" type="file">');
	defForm.append('<br>');
}

function hideRiskCSVForm(id){
	$('#risk_file'+id).hide();
	$('#risk_file'+id+'_exp').hide();
}

function showRiskCSVForm(id){
	$('#risk_file'+id).show();
	$('#risk_file'+id+'_exp').show();
}

function addReferenceForm(init){
	if (init > referenceCounter) {
		referenceCounter = init;
	}
	id = referenceCounter;

	$('<textarea class="form-control" id="reference'+id+'" name="reference'+id+'" type="text" placeholder="American Heart Association. Heart disease and stroke statistics - 2008 update. Dallas (TX): American Heart Association; 2008. 43 p." /></textarea><br>').appendTo('#references')
	referenceCounter++;
}
