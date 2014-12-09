var datasetCounter = 1;
var defDataCounter = [0,1];
function addDatasetForm(){
	// カウンタを回す
	datasetCounter++;

	var datasetForm = document.getElementById("dataset-form");
	var input = document.createElement("select");
	input.setAttribute('class', 'form-control btn-sm');
	input.id = "dataset"+datasetCounter;
	input.name = "dataset"+datasetCounter;;

	var ele = document.createElement("option");
	ele.value = "DPC様式1";
	var str = document.createTextNode("DPC様式1");
	ele.appendChild(str);
	input.appendChild(ele);

	var ele = document.createElement("option");
	ele.value = "E/Fファイル";
	var str = document.createTextNode("E/Fファイル");
	ele.appendChild(str);
	input.appendChild(ele);

	var ele = document.createElement("option");
	ele.value = "Fファイル";
	var str = document.createTextNode("Fファイル");
	ele.appendChild(str);
	input.appendChild(ele);

	var ele = document.createElement("option");
	ele.value = "EFファイル";
	var str = document.createTextNode("EFファイル");
	ele.appendChild(str);
	input.appendChild(ele);

	datasetForm.appendChild(input);
}

function addDefDataForm(formNumber){
	defDataCounter[formNumber]++;

	var defForm = $('#denom-def1')
	var id = defDataCounter[formNumber]
	defForm.append("<h5>"+id+"</h5>");
	defForm.append('<h5>説明</h5>');
	defForm.append('<input class="form-control" id="denom_exp'+id+'" name="denom_exp'+id+'"placeholder="脳血管疾患等リハビリテーションまたはリハビリテーション総合計画評価を受けた症例　レセ電コードに以下のいずれかが含まれる症例" type="text">');
	defForm.append('<div class="row">');
	//子どもの関係がおかしい divに子どもをくっつけてからdivを本体に付けないと行けないはず
	defForm.append('<div class="col-md-3">');
	defForm.append('<h5>Key</h5>');
	defForm.append('<input class="form-control" id="denom_data_key'+id+'" name="denom_data_key'+id+'" placeholder="(option) レセ電コード" type="text">');
	defForm.append('</div>');
	defForm.append('<div class="col-md-9 form-group">');
	defForm.append('<h5>Value</h5>');
	defForm.append('<input class="form-control" id="denom_data_value'+id+'" name="denom_data_value'+id+'" placeholder="(option) [&quot;180027610&quot;, &quot;180032410&quot;, … , &quot;180024710&quot;]" type="text">');
	defForm.append('</div>');
	defForm.append('</div>');
	defForm.append('</div>');
}
