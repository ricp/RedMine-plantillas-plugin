class AddSharedColumnToWikiTemplates < ActiveRecord::Migration
  def self.up
    add_column :wiki_templates, :shared, :boolean, :default => false
    add_index :wiki_templates, :shared
  end

  def self.down
    remove_index :wiki_templates, :shared
    remove_column :wiki_templates, :shared
  end
end