# Capistrano Git Methods [![Build Status](https://secure.travis-ci.org/ekampp/capistrano-git-methods.png)](http://travis-ci.org/ekampp/capistrano-git-methods)

This is a namespace containing methods for maintaining a remote server through git instead of the standard capistrano way.

## Usage

Including this gem with `require capistrano-git-methods` in your recipe gives access to the `git.<method>` methods.

## Methods

There is the following methods available:

* `setup` clones the repository onto the server, and should be done when doing a cold deploy.
* `update_code` updates the remote code to match the latest head in the given `branch`.
* `repo` sets the branch to the current head of the remote version of the code.
* `cleanup` cleans up after the git processes.

## Configuration

You can configure the library from your deploy recipe, as it lazy-loads all the settings variables, so you don't need to worry about where you require this library.

The following sonfiguration options are available:

* `repository` defines the specific repository that you want to clone.
* `brach` sets the branch within the repository to check out.
