require "capistrano-git-methods/version"

#
# Extends the capistrano configuration, to allow the <tt>git</tt> namespace to
# be available within the capistrano recipe.
#
# == Requirements
#
# This requires the <tt>current_path</tt> variable to be present. This should
# already be available in the standard capistrano deploy scheme.
#
Capistrano::Configuration.instance.load do

  namespace :git do
    set(:branch) { "master" }

    desc "Setup your git-based deployment app"
    task :setup, :except => { :no_release => true } do
      puts "\n\nSetting up the remote git target...\n\n"
      dirs = [deploy_to, shared_path]
      dirs += shared_children.map { |d| File.join(shared_path, d) }
      run "mkdir -p #{dirs.join(' ')} && chmod g+w #{dirs.join(' ')}"
      run "git clone #{repository} #{latest_release}"
    end

    desc "Update the deployed code."
    task :update_code, :except => { :no_release => true } do
      run "cd #{latest_release}; git fetch origin; git reset --hard #{branch}"
    end

    desc "Moves the repo back to the previous version of HEAD"
    task :repo, :except => { :no_release => true } do
      set :branch, "HEAD@{1}"
    end

    desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
    task :cleanup, :except => { :no_release => true } do
      run "cd #{latest_release}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
    end
  end
end
