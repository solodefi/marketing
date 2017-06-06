module ApplicationHelper
  def remote_request(type, path, params={}, target_tag_id)
    "$.#{type}('#{path}',
               {#{params.collect { |p| "#{p[0]}: #{p[1]}" }.join(", ")}},
               function(data) {$('##{target_tag_id}').html(data);}
     );"
  end

end
