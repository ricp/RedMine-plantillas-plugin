module ProjectsControllerPatch
    def self.included(base)
    	base.send(:include, InstanceMethods)
	    base.class_eval do
	      alias_method_chain :settings, :template
	      helper :templates
	      include TemplatesHelper
	    end
    end
module InstanceMethods
  def settings_with_template 
    @issue_custom_fields = IssueCustomField.find(:all, :order => "#{CustomField.table_name}.position")
    @issue_category ||= IssueCategory.new
    @member ||= @project.members.new
    @trackers = Tracker.all
    @repository ||= @project.repository
    @wiki ||= @project.wiki
    @template ||= @project.template
    @project_id = @project.id
    visible_conditions = Project.visible_condition(User.current) # return SQL fragment for current user's authorized projects
    @templates = WikiTemplates.find(:all, :joins => :project,
                                    :conditions => ["project_id = ? OR (shared = ? AND #{visible_conditions})" , @project_id, true ])
  end
end
end
