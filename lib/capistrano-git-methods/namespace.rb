Capistrano::Configuration.instance.load do
  namespace :git do
    set(:branch)  { "master" }
    set(:tag)     { nil }

    desc "Setup your git-based deployment app"
    task :setup, :except => { :no_release => true } do
      dirs = [deploy_to, shared_path]
      dirs += shared_children.map { |d| File.join(shared_path, d) }
      run "mkdir -p #{dirs.join(' ')} && chmod g+w #{dirs.join(' ')}"
      run "git clone #{repository} #{latest_release}" do |channel, stream, data|
        logger.debug "[#{channel[:hoost]}] #{data}"
      end
    end

    desc "Update the deployed code."
    task :update_code, :except => { :no_release => true } do
      logger.info "Resetting git to #{fetch(:branch)}"
      git_cmd = "cd #{latest_release}; git fetch origin; git reset --hard #{fetch(:branch)}"
      git_cmd << "; git checkout #{tag}" if tag.to_s.length > 0
      run git_cmd do |channel, stream, data|
        logger.debug "[#{channel[:host]}] #{data}"
      end
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
