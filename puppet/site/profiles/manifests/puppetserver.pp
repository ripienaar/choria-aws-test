class profiles::puppetserver {
  include puppetserver

  puppet_authorization::rule { "puppetlabs tasks file contents":
    match_request_path   => "/puppet/v3/file_content/tasks",
    match_request_type   => "path",
    match_request_method => "get",
    allow                => ["*"],
    sort_order           => 510,
    path                 => "/etc/puppetlabs/puppetserver/conf.d/auth.conf",
    notify               => Class["puppetserver::config"]
  }

  puppet_authorization::rule { "puppetlabs tasks":
    match_request_path   => "/puppet/v3/tasks",
    match_request_type   => "path",
    match_request_method => "get",
    allow                => ["*"],
    sort_order           => 510,
    path                 => "/etc/puppetlabs/puppetserver/conf.d/auth.conf",
    notify               => Class["puppetserver::config"]
  }

  puppet_authorization::rule { "puppetlabs environment":
    match_request_path   => "/puppet/v3/environment",
    match_request_type   => "path",
    match_request_method => "get",
    allow                => ["*.mcollective", "dev3.devco.net"],
    sort_order           => 510,
    path                 => "/etc/puppetlabs/puppetserver/conf.d/auth.conf",
    notify               => Class["puppetserver::config"]
  }

  include puppetdb
  include puppetdb::master::config
}
