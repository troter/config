# -*- coding:utf-8; mode:ruby -*-
# Rakefile for my user configration.

begin; require 'rubygem'; rescue LoadError; end

require 'rake'
require 'rake/clean'
require 'find'
require 'pp'

DESTDIR = ENV['HOME']
TMPDIR = ".tmp"

CLEAN.include('*~')
  
task :default => [:update]

task :update => [:download_elisp]


desc "Download elisp."
task :download_elisp => [:download_elisp_installer]

task :download_elisp_installer

# for download elisps
EMACS_CONFIGS = FileList["dot.emacs.d/conf/*.el"]
ELISP_DIR = "dot.emacs.d/elisp"
EMACS = "emacs"
EMACS_BATCH_OPTION = "--batch -no-init-file -no-site-file"
EMACS_BATCH = "#{EMACS} #{EMACS_BATCH_OPTION}"

def install_elisp(install_function, file)
  sh <<EOS
 #{EMACS_BATCH} --directory #{ELISP_DIR} --directory #{TMPDIR}\
 --eval "(require 'install-elisp)" \
 --eval "(setq install-elisp-confirm-flag nil)" \
 --eval "(setq install-elisp-repository-directory (car load-path))" \
 --eval "(#{install_function} \\"#{file}\\")"
EOS
end

def auto_install(file)
  sh <<EOS
 #{EMACS_BATCH} --directory #{ELISP_DIR} --directory #{TMPDIR}\
 --eval "(require 'install-elisp)" \
 --eval "(require 'auto-install)" \
 --eval "(setq install-elisp-confirm-flag nil)" \
 --eval "(setq auto-install-directory (concat (car load-path) \\"/\\"))" \
 --eval "(setq auto-install-save-confirm nil)" \
 --eval "(setq auto-install-install-confirm nil)" \
 --eval "(auto-install-update-emacswiki-package-name nil)" \
 --eval "(auto-install-compatibility-setup)" \
 --eval "(print (auto-install-batch \\"#{file}\\"))" \
 --eval "(while auto-install-waiting-url-list (sleep-for 1))"
EOS
end

def generate_rule_elisp_download(dest, taskname = :download_elisp, &download_block)
  timestamp = "#{TMPDIR}/timestamp.#{dest.gsub(/\//, "_")}"

  file dest => [timestamp], &download_block
  file timestamp do
    touch timestamp
  end

  # add deps
  task taskname => [dest]
  CLOBBER.include [timestamp, dest]
end

# installer
ELISP_INSTALLER = [
  "http://www.emacswiki.org/cgi-bin/wiki/download/install-elisp.el",
  "http://www.emacswiki.org/cgi-bin/wiki/download/auto-install.el",
]

ELISP_INSTALLER.each do |elisp|
  dest = "#{ELISP_DIR}/#{File.basename(elisp)}"
  generate_rule_elisp_download(dest, :download_elisp_installer) do
    sh "wget #{elisp} --directory-prefix=#{ELISP_DIR}"
  end
end

# Generate download elisp tasks. its relateing to install-elisp.
INSTALL_ELISP_FROM_URL = EMACS_CONFIGS.map do |config|
  IO.readlines(config).grep(/\(install-elisp \"([^"]*?)\"/) { $1 }
end.flatten
INSTALL_ELISP_FROM_EMACSWIKI = EMACS_CONFIGS.map do |config|
  IO.readlines(config).grep(/\(install-elisp-from-emacswiki \"([^"]*?)\"/) { $1 }
end.flatten

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

# Generate download elisp tasks. its relateing to auto-install.
AUTO_INSTALL =  EMACS_CONFIGS.map do |config|
  IO.readlines(config).grep(/\(auto-install-batch \"([^"]*?)\"/) { $1 }
end.flatten

AUTO_INSTALL.each do |elisp_package|
  dest = "#{TMPDIR}/#{File.basename(elisp_package)}"
  generate_rule_elisp_download(dest) do |t|
    auto_install(elisp_package)
    touch t.name
  end
end

desc "Deploy user configurations."
task :deploy

DOT_FILES = FileList["dot.*"]
DOT_FILES.each do |dot_file|
  src = dot_file
  dest = dot_file.pathmap("#{DESTDIR}/%{dot,}p")

  file dest => [src] do
    copy_entry src, dest, true
  end

  # add deps
  task :deploy => [dest]
end

# End of Rakefile.
