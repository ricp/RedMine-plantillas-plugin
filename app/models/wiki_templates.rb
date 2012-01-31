class WikiTemplates < ActiveRecord::Base
  unloadable
  belongs_to :project
end
