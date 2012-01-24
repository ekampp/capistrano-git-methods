# Capistrano Git Methods [![Build Status](https://secure.travis-ci.org/ekampp/capistrano-git-methods.png)](http://travis-ci.org/ekampp/capistrano-git-methods)

This is a namespace containing methods for maintaining a remote server through git instead of the standard capistrano way.

## Usage

Including this gem with `require `capistrano-git-methods` in your recipe gives access to the `git.<method>` methods.

## Methods

There is the following methods available:

* `setup` clones the repository onto the server, and should be done when doing a cold deploy.
* `update_code` updates the remote code to match the latest head in the given `branch`.
* `repo` sets the branch to the current head of the remote version of the code.
* `cleanup` cleans up after the git processes.
