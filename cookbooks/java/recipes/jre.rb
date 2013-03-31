installer_name = "jre-6u#{node.java.version}-linux-x64-rpm.bin"
installer_url = "http://192.168.1.110/files/java/#{installer_name}"
installer_bin  = "/tmp/#{installer_name}"
java_bin = "/usr/java/jre1.6.0_#{node.java.version}/bin/java"

remote_file installer_bin do
  source installer_url
  mode 00755
  not_if { File.exists? installer_bin }
end

bash "install_jre" do
  user "root"
  code <<-EOL
    #{installer_bin}
    alternatives --install /usr/bin/java java #{java_bin} 20000
  EOL
  creates java_bin
end
