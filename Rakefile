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

desc "Update files."
task :update => [TMP_DIR, :download_elisp, :download_yasnippet]

task :download_elisp
task :download_yasnippet

file TMP_DIR do
  mkdirp TMP_DIR
end

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
  generate_rule_elisp_download(dest) do
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

#["http://svn.coderepos.org/share/config/yasnippet/common"].each do |repos|
#  dest = "#{ELISP_DIR}/yasnippet/snippets"
#  generate_rule_elisp_download(dest, :download_yasnippet) do |t|
#    sh "svn export -q --force #{repos} #{dest}"
#  end
#end

["http://yasnippet.googlecode.com/files/yasnippet-bundle-0.6.1b.el.tgz"].each do |elisp|
  dest = "#{ELISP_DIR}/yasnippet-bundle.el"
  tmp = "#{TMP_DIR}/#{File.basename(elisp)}"
  generate_rule_elisp_download(dest, :download_yasnippet) do
    sh "wget #{elisp} --directory-prefix=#{TMP_DIR}"
    sh "tar xzf #{tmp}"
    cp dest.pathmap("%f"), dest; rm dest.pathmap("%f")
  end
  CLOBBER.include tmp
end


desc "Deploy user configurations."
task :deploy => [:clean]

DOT_FILES = FileList["dot.*"]
DOT_FILES.each do |dot_file|
  src = dot_file
  dest = dot_file.pathmap("#{DEST_DIR}/%{dot,}p")

  task dest => [src] do
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
