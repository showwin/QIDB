json.set! :definitions do
  json.array!(@defs) do |definition|
    json.projects do |prjt|
      prjt.array!(definition.numbers) do |n|
        prjt.name n.to_a[0]
        prjt.number n.to_a[1]
      end
    end
    json.years definition.years
    json.group definition.group
    json.name definition.name
    json.meaning definition.meaning
    json.dataset definition.dataset
    json.def_summary do |s|
      s.demon definition.def_summary['denom']
      s.numer definition.def_summary['numer']
    end
    json.definitions do |d|
      d.denom definition.definitions['def_denom']
      d.numer definition.definitions['def_numer']
    end
    json.drug_output definition.drug_output
    json.def_risks definition.def_risks
    json.method do |m|
      m.explanation definition['method']['explanation']
      m.unit definition['method']['unit']
    end
    json.order definition.order
    json.notice definition.annotation
    json.standard_value definition.standard_value
    json.references definition.references
    json.review_span definition.review_span
    json.indicator definition.indicator
    json.created_at definition.created_at
    logs = ChangeLog.where(log_id: definition.log_id).to_a
    json.set! :change_log do |log|
      json.array!(logs) do |l|
        log.editor l.editor
        log.message l.message
      end
    end
  end
end
json.status 200
json.message 'OK'
