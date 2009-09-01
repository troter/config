# -*- coding:utf-8; mode:ruby -*-
# Rakefile for user configration.

begin; require 'rubygem'; rescue LoadError; end

require 'rake'
require 'rake/clean'
require 'find'
require 'pp'

DOT_FILES = FileList["dot.*"]

EMACS_CONFIGS = FileList["dot.emacs.d/conf/*.el"]


ELISP_DIR = "dot.emacs.d/elisp"

TMP_DIR = ".tmp"

EMACS = "emacs"
EMACS_BATCH_OPTION = "--batch -no-init-file -no-site-file"
EMACS_BATCH = "#{EMACS} #{EMACS_BATCH_OPTION}"

INSTALL_ELISP_EL = "#{TMP_DIR}/install-elisp.el"
INSTALL_ELISP_EL_URL="http://www.emacswiki.org/cgi-bin/wiki/download/insall-elisp.el"

def emacs_backup_file?(file)
  /~\z/ === file
end

def install(install_function, file)
  puts ["#{EMACS_BATCH}",
         "--directory #{ELISP_DIR}",
         "--load #{INSTALL_ELISP_EL}",
         "--eval \"(add-to-list 'load-path \\\"#{ELISP_DIR}\\\")\"",
         "--eval \"(setq install-elisp-confirm-flag nil)\"",
         "--eval \"(setq install-elisp-repository-directory \\\"#{ELISP_DIR}\\\")\"",
         "--eval \"(#{install_function} \\\"#{file}\\\")\""].join(' ')
end

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
  

task :default => [:install]

task :install do
  install("install-elisp-from-emacswiki", "auto-install")
end

file INSTALL_ELISP_EL do
  sh "wget #{INSTALL_ELISP_EL_URL} --directory-prefix=#{TMP_DIR}"
end

task :download => [INSTALL_ELISP_EL] do
  EMACS_CONFIGS.each do |config|
    IO.readlines(config).grep(/\(install-elisp-from-emacswiki \"([^"]*?)\"/) do |item|
      install("install-elisp-from-emacswiki", $1)
    end
  end

  EMACS_CONFIGS.each do |config|
    IO.readlines(config).grep(/\(install-elisp \"([^"]*?)\"/) do |item|
      install("install-elisp", $1)
    end
  end

  EMACS_CONFIGS.each do |config|
    IO.readlines(config).grep(/\(auto-install-batch \"([^"]*?)\"/) do |item|
      auto_install($1)
    end
  end
end

pp DOT_FILES.pathmap("install.%f")
task :install => DOT_FILES.pathmap("install.%f")

DOT_FILES.pathmap("install.%f").to_a.each do |f|
  pp /insall.*$/  ===  f
end

rule /install\..*$/ do |t|
  pp t.name
end
