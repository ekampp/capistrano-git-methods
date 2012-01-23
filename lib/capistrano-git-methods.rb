require "capistrano-git-methods/version"
Capistrano::Configuration.instance.load do
  namespace :git do
    desc "Setup your git-based deployment app"
    task :setup, :except => { :no_release => true } do
      dirs = [deploy_to, shared_path]
      dirs += shared_children.map { |d| File.join(shared_path, d) }
      run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
      run "git clone #{repository} #{current_path}"
    end

    desc "Update the deployed code."
    task :update_code, :except => { :no_release => true } do
      run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
      finalize_update
    end

    desc "Installs the bundle gems"
    task :bundle, :except => { :no_release => true } do
      run "cd #{current_path}; bundle --deployment --without test --without development"
    end

    desc "Moves the repo back to the previous version of HEAD"
    task :repo, :except => { :no_release => true } do
      set :branch, "HEAD@{1}"
      deploy.default
    end

    desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
    task :cleanup, :except => { :no_release => true } do
      run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
    end
  end
end
