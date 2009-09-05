# -*- coding:utf-8; mode:ruby -*-
# Rakefile for my user configration.

begin; require 'rubygem'; rescue LoadError; end

require 'rake'
require 'rake/clean'
require 'find'
require 'pp'

# global settings
DEST_DIR = ENV['HOME']
TMP_DIR = ".tmp"
  
task :default => [:update]

task :update => [:download_elisp]

desc "Download elisp."
task :download_elisp => [:download_elisp_installer]

desc "Download elisp installer."
task :download_elisp_installer

# for download elisps
DOT_EMACS_D = "dot.emacs.d"
EMACS_CONFIGS = FileList["#{DOT_EMACS_D}/conf/*.el"]
ELISP_DIR = "#{DOT_EMACS_D}/elisp"
EMACS = "emacs"
EMACS_BATCH_OPTION = "--batch -no-init-file -no-site-file"
EMACS_BATCH = "#{EMACS} #{EMACS_BATCH_OPTION}"

def install_elisp(install_function, file)
  sh <<EOS
 #{EMACS_BATCH} --directory #{ELISP_DIR} --directory #{TMP_DIR}\
 --eval "(require 'install-elisp)" \
 --eval "(setq install-elisp-confirm-flag nil)" \
 --eval "(setq install-elisp-repository-directory (car load-path))" \
 --eval "(#{install_function} \\"#{file}\\")"
EOS
end

def auto_install(elisp_package)
  sh <<EOS
 #{EMACS_BATCH} --directory #{ELISP_DIR} --directory #{TMP_DIR}\
 --eval "(require 'install-elisp)" \
 --eval "(require 'auto-install)" \
 --eval "(setq install-elisp-confirm-flag nil)" \
 --eval "(setq auto-install-directory (concat (car load-path) \\"/\\"))" \
 --eval "(setq auto-install-save-confirm nil)" \
 --eval "(setq auto-install-install-confirm nil)" \
 --eval "(auto-install-update-emacswiki-package-name nil)" \
 --eval "(auto-install-compatibility-setup)" \
 --eval "(print (auto-install-batch \\"#{elisp_package}\\"))" \
 --eval "(while auto-install-waiting-url-list (sleep-for 1))"
EOS
end

def generate_rule_elisp_download(dest, taskname = :download_elisp, &download_block)
  timestamp = "#{TMP_DIR}/timestamp.#{dest.gsub(/\//, "_")}"

  file dest => [timestamp], &download_block
  file timestamp do; touch timestamp; end

  # add deps
  task taskname => [dest]
  CLOBBER.include [timestamp, dest]
end

# install files
ELISP_INSTALLER = [
  "http://www.emacswiki.org/cgi-bin/wiki/download/install-elisp.el",
  "http://www.emacswiki.org/cgi-bin/wiki/download/auto-install.el",
]
INSTALL_ELISP_FROM_URL = EMACS_CONFIGS.map do |config|
  IO.readlines(config).grep(/\(install-elisp \"([^"]*?)\"/) { $1 }
end.flatten
INSTALL_ELISP_FROM_EMACSWIKI = EMACS_CONFIGS.map do |config|
  IO.readlines(config).grep(/\(install-elisp-from-emacswiki \"([^"]*?)\"/) { $1 }
end.flatten
AUTO_INSTALL =  EMACS_CONFIGS.map do |config|
  IO.readlines(config).grep(/\(auto-install-batch \"([^"]*?)\"/) { $1 }
end.flatten

# install rules
ELISP_INSTALLER.each do |elisp|
  dest = "#{ELISP_DIR}/#{File.basename(elisp)}"
  generate_rule_elisp_download(dest, :download_elisp_installer) do
    sh "wget #{elisp} --directory-prefix=#{ELISP_DIR}"
  end
end
INSTALL_ELISP_FROM_URL.each do |elisp|
  dest = "#{ELISP_DIR}/#{File.basename(elisp)}"
  generate_rule_elisp_download(dest) do
    install_elisp('install-elisp', elisp)
  end
end
INSTALL_ELISP_FROM_EMACSWIKI.each do |elisp|
  dest = "#{ELISP_DIR}/#{File.basename(elisp)}"
  generate_rule_elisp_download(dest) do
    install_elisp('install-elisp-from-emacswiki', elisp)
  end
end
AUTO_INSTALL.each do |elisp_package|
  dest = "#{TMP_DIR}/#{File.basename(elisp_package)}"
  generate_rule_elisp_download(dest) do |t|
    auto_install(elisp_package)
    touch t.name
  end
end

desc "Deploy user configurations."
task :deploy = [:clean]

DOT_FILES = FileList["dot.*"]
DOT_FILES.each do |dot_file|
  src = dot_file
  dest = dot_file.pathmap("#{DEST_DIR}/%{dot,}p")

  file dest => [src] do
    copy_entry src, dest, true
  end

  # add deps
  task :deploy => [dest]
end


# clean.
CLEAN.include [
  '*~',
]

# End of Rakefile.
