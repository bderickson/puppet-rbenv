define rbenv::plugin::rbenvvars(
  $user    = $title,
  $source  = 'https://github.com/sstephenson/rbenv-vars.git',
  $group   = $user,
  $home    = '',
  $root    = '',
  $ensure  = latest,
  $version = 'master',
) {

  rbenv::plugin { "rbenv::plugin::rbenvvars::${user}":
    user        => $user,
    source      => $source,
    plugin_name => 'rbenv-vars',
    group       => $group,
    home        => $home,
    root        => $root
    ensure      => $ensure,
    version     => $version,
  }
}
