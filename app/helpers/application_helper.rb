module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "IdleCampus"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

    def json_for(target, options = {})
      options[:scope] ||= self
      options[:url_options] ||= url_options
      target.active_model_serializer.new(target, options).to_json
    end
  
end