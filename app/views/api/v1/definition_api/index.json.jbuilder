json.set! :definitions do
  json.array!(@defs) do |definition|
    json.project definition['プロジェクト名']
    json.years definition['年度']
    json.number definition['指標番号']
    json.group definition['指標群']
    json.name definition['名称']
    json.meaning definition['意義']
    json.dataset definition['必要なデータセット']
    json.def_summary do |s|
      s.demon definition['定義の要約']['分母']
      s.numer definition['定義の要約']['分子']
    end
    json.definitions do |d|
      d.denom definition['指標の定義/算出方法']['分母の定義']
      d.numer definition['指標の定義/算出方法']['分子の定義']
    end
    json.drag_output definition['薬剤一覧の出力']
    json.factor_definition definition['リスクの調整因子の定義']
    json.factor_definition_detail definition['定義の詳細'].present? ? definition['定義の詳細'] : ''
    json.method do |m|
      m.explanation definition['指標の算出方法']['説明']
      m.unit definition['指標の算出方法']['単位']
    end
    json.order definition['結果提示時の並び順']
    json.notice definition['測定上の限界/解釈上の注意']
    json.standard_value definition['参考値']
    json.references definition['参考資料']
    json.review_span definition['定義見直しのタイミング']
    json.indicator definition['指標タイプ']
    json.created_at definition['created_at']
    logs = ChangeLog.make_json(definition['指標番号'])
    json.set! :change_log do |log|
      json.array!(logs) do |l|
        log.editor l['変更者']
        log.message l['変更メッセージ']
      end
    end
  end
end
json.status 200
json.message 'OK'
