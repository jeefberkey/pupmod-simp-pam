# Enable wheel restrictions for su access.
#
# @param wheel_group [String]
#     What group should be the 'wheel' equivalent. Set to the traditional
#     'wheel' by default.
#
# @param root_only [Boolean]
#     Set this if you only want to make this effective when su'ing to root.
#
# @param use_openshift [Boolean]
#    Whether or not to configure things in such a way that the
#    openshift_origin puppet code is compatible.
#
class pam::wheel (
  String $wheel_group    = 'wheel',
  Boolean $root_only     = false,
  Boolean $use_openshift = pick($::pam::use_openshift, false),
  Boolean $use_templates = $::pam::use_templates,
  String $su_content     = $::pam::su_content
) inherits ::pam {

  if $use_templates {
    $_su_content = template('pam/etc/pam.d/su.erb')
  }
  else {
    $_su_content = $su_content
  }
  file { '/etc/pam.d/su':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $_su_content
  }
}
