exec_user = node.growthforecast.exec_user
home_dir = "/home/#{exec_user}"
perl_version = node.growthforecast.perl_version

perlbrew_root      = "#{home_dir}/perl5/perlbrew"
perlbrew_bin       = "#{perlbrew_root}/bin/perlbrew"
cpanm_bin          = "#{perlbrew_root}/bin/cpanm"
perl_bin           = "#{perlbrew_root}/perls/perl-#{perl_version}/bin/perl"
growthforecast_bin = "#{perlbrew_root}/perls/perl-#{perl_version}/bin/growthforecast.pl"

perlbrew_environments = {
  'HOME' => home_dir,
  'PERLBREW_ROOT' => perlbrew_root,
  'PERLBREW_HOME' => perlbrew_root,
}

%w(pkgconfig glib2-devel gettext libxml2-devel pango-devel cairo-devel).each do |pkg|
  package pkg
end

user exec_user do
  home home_dir
  shell "/bin/bash"
end

bash 'install_perlbrew' do
  user exec_user
  cwd  home_dir
  environment perlbrew_environments
  code <<-EOF
  curl -kL http://install.perlbrew.pl | bash
  echo '[[ -s "$HOME/perl5/perlbrew/etc/bashrc" ]] && source "$HOME/perl5/perlbrew/etc/bashrc"' >> .bash_profile
  #{perlbrew_bin} -f install-cpanm
  EOF
  creates perlbrew_bin
end

bash 'install_perl' do
  user exec_user
  cwd  home_dir
  environment perlbrew_environments
  code <<-EOF
  source "$HOME/perl5/perlbrew/etc/bashrc"
  #{perlbrew_bin} --notest install perl-#{perl_version}
  #{perlbrew_bin} switch perl-#{perl_version}
  EOF
  creates perl_bin
end

bash 'install_GrowthForecast' do
  user exec_user
  cwd  home_dir
  environment perlbrew_environments
  code <<-EOF
  source "$HOME/perl5/perlbrew/etc/bashrc"
  #{cpanm_bin} e -n http://search.cpan.org/CPAN/authors/id/K/KA/KAZEBURO/GrowthForecast-#{node.growthforecast.version}.tar.gz
  EOF
  creates growthforecast_bin
end

include_recipe "supervisor::default"

template '/etc/supervisord.d/growthforecast.ini' do
  source 'growthforecast.supervisord.ini.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables({
    perl_bin: perl_bin,
    growthforecast_bin: growthforecast_bin,
    data_dir: node.growthforecast.data_dir
  })
  notifies :run, resources(:execute => "supervisorctl update")
end
