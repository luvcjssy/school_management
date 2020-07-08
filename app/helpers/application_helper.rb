module ApplicationHelper
  def alert_for(flash_type)
    { success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def link_to_add_fields(name, f, association, class_name, href = '#', event = nil)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, href, class: "#{class_name} btn btn-success ml-auto", data: {id: id, fields: fields.gsub("\n", "")}, onclick: event)
  end

  def active_class(link_path_arr)
    link_path_arr.include?(request.path) ? "active" : ""
  end
end
