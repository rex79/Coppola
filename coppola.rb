#!/Volumes/Users/rex/.rbenv/shims/ruby
require 'rubygems'
require 'thor'

class Coppola < Thor 
	include Thor::Actions

  desc "create_project", "Create a simple padrino project with jquery, erb"
  method_options  :project_name   => :string, 
                  :adapter        => :string,
                  :db_user        => :string,
                  :dbpassword     => :string
  def create_project
    project_name  = options[:project_name]
    adapter       = options[:adapter]
    db_user       = options[:db_user]
    db_password   = options[:db_password]

    # creating default project with erb rendering, activerecord orm and jquery scripting
    say "Creating project"
    # :test => :none, :render => :erb, :script => :jquery, :orm => :activerecord, :adapter => adapter, :bundle => false
    run 'padrino g project %s -e erb -s jquery -d activerecord -a %s ' % [project_name,adapter]
    gsub_file "#{project_name}/config/database.rb", "'root'", "'#{db_user}'"
    gsub_file "#{project_name}/config/database.rb", "''", "'#{db_password}'"
  end

end


Coppola.start