class profiles::common {
  lookup("extra_packages", Array[String], "unique").each |$package| {
    package{$package:
      ensure => present
    }
  }

  include mcollective
}
