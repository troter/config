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


def auto_install()
#  print ["#{EMACS_BATCH} --directory #{ELISP_DIR}",
#         "--load #{ELISP_DIR}/auto-install.el"
#         "--load #{INSTALL_ELISP_EL}",
#　　         "--eval '(add-to-list \'load-path \"$(ELISP_DIR)\")'" \
#	--eval "(setq install-elisp-confirm-flag nil)" \
#	--eval "(setq install-elisp-repository-directory \"$(ELISP_DIR)\")" \
#	--eval "(setq auto-install-save-confirm nil)" \
#	--eval "(setq auto-install-install-confirm nil)" \
#	--eval "(auto-install-update-emacswiki-package-name nil)" \
#	--eval "(auto-install-compatibility-setup)" \
#	--eval "(auto-install-batch $(strip $1))"
#
end
  
task :default => [:update]

task :update => [:download_elisp]


desc "Download elisp."
task :download_elisp

# for download elisps
EMACS_CONFIGS = FileList["dot.emacs.d/conf/*.el"]
ELISP_DIR = "dot.emacs.d/elisp"
EMACS = "emacs"
EMACS_BATCH_OPTION = "--batch -no-init-file -no-site-file"
EMACS_BATCH = "#{EMACS} #{EMACS_BATCH_OPTION}"

# installer
lambda do
  elisp = "http://www.emacswiki.org/cgi-bin/wiki/download/install-elisp.el"
  dest = elisp.pathmap("#{TMPDIR}/%f")
  timestamp = elisp.pathmap("#{TMPDIR}/timestamp.%f")
  INSTALL_ELISP_EL = dest
  
  file dest                do; sh "wget #{elisp} --directory-prefix=#{TMPDIR}"; end
  file timestamp => [dest] do; touch timestamp; end

  # add deps
  task :install_elisp => [timestamp]
  task :download_elisp => [timestamp]
  CLOBBER.include [dest, timestamp]
end.call

def install_elisp(install_function, file)
  sh <<EOS
 #{EMACS_BATCH} --directory #{ELISP_DIR} --load #{INSTALL_ELISP_EL} \
 --eval "(add-to-list 'load-path \\\"#{ELISP_DIR}\\\")" \
 --eval "(setq install-elisp-confirm-flag nil)" \
 --eval "(setq install-elisp-repository-directory \\\"#{ELISP_DIR}\\\")" \
 --eval "(#{install_function} \\\"#{file}\\\")"
EOS
end


# Generate download elisp tasks. its relateing to install-elisp.
INSTALL_ELISP_FROM_URL = EMACS_CONFIGS.map do |config|
  IO.readlines(config).grep(/\(install-elisp \"([^"]*?)\"/) { $1 }
end.flatten
INSTALL_ELISP_FROM_EMACSWIKI = EMACS_CONFIGS.map do |config|
  IO.readlines(config).grep(/\(install-elisp-from-emacswiki \"([^"]*?)\"/) { $1 }
end.flatten

def generate_rule_elisp_download(func, elisp)
  dest = elisp.pathmap("#{ELISP_DIR}/%f")
  timestamp = elisp.pathmap("#{TMPDIR}/timestamp.%f")

  file dest                do; install_elisp(func, elisp); end
  file timestamp => [dest] do; touch timestamp; end

  # add deps
  task :download_elisp => [timestamp]
  CLOBBER.include [timestamp, dest]
end  

INSTALL_ELISP_FROM_URL.each do |elisp|
  generate_rule_elisp_download('install-elisp', elisp)
end
INSTALL_ELISP_FROM_EMACSWIKI.each do |elisp|
  generate_rule_elisp_download('install-elisp-from-emacswiki', elisp)
end

# Generate download elisp tasks. its relateing to auto-install.
AUTO_INSTALL =  EMACS_CONFIGS.map do |config|
  IO.readlines(config).grep(/\(auto-install-batch \"([^"]*?)\"/) { $1 }
end.flatten

# TODO: 


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
