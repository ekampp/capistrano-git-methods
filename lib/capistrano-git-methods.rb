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

  #
  # Sets some default values, if they have not been set
  #
  _cset :branch, "master"

  namespace :git do

    #
    # Clones the repository onto the remote server.
    #
    # This is required before you can run the <tt>update_code</tt> method
    # successfully.
    #
    desc "Setup your git-based deployment app"
    task :setup, :except => { :no_release => true } do
      dirs = [deploy_to, shared_path]
      dirs += shared_children.map { |d| File.join(shared_path, d) }
      run "mkdir -p #{dirs.join(' ')} && chmod g+w #{dirs.join(' ')}"
      run "git clone #{repository} #{current_path}"
    end

    #
    # Updates the remote code to the latest head of the selected
    # git branch.
    #
    desc "Update the deployed code."
    task :update_code, :except => { :no_release => true } do
      run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
    end

    desc "Moves the repo back to the previous version of HEAD"
    task :repo, :except => { :no_release => true } do
      set :branch, "HEAD@{1}"
    end

    desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
    task :cleanup, :except => { :no_release => true } do
      run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
    end
  end
end
