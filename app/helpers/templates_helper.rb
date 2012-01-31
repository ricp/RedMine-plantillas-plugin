module TemplatesHelper

  def current_user_is_allowed_on_project?(project, options)
    User.current.allowed_to?(options, project)
  end

  def link_to_if_allowed_on_project(project, name, options = {}, html_options = nil, *parameters_for_method_reference)
    if current_user_is_allowed_on_project?(project, options)
      link_to(name, options, html_options, *parameters_for_method_reference)
    end
  end

  def shared_template_label(template, project_id)
    html = l(:label_template_shared)
    if project_id != template.project_id
      html << link_to_if_allowed_on_project(template.project, 
                " #{l(:label_template_shared_from_project)} #{h template.project.name}", 
                { :controller => 'projects', :action => 'settings', :id => template.project_id })
    end
    html
  end

end