## v 0.0.4: Capistrano config extention

Upadted the way that we extend capistrano configuration. You should now include the gem and then use `::CapistranoGitMethods.load` to actually load the methods into capistrano.

This is done to ensure that bundler doesn't extend the rake tasks with the ones defined in the gem.

## v 0.0.3: Lazy loading

Added lazyloading of the settings to avoid conflicts when using multistage.

## v 0.0.2: Better abstractions

The namespace has been updated to *not* contain the `bundle` method.
Also the `rollback.repo` method doesn't callback to the default namespace.

## v 0.0.1: Initial release

This is the initial release, and contains very basic usage.
