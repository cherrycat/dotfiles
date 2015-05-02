(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el")
(cask-initialize)
(require 'pallet)
(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path "~/.emacs.d/custom")
(load "smart-quotes.el")
(load "00common-setup.el")
(load "01ruby.el")
(load "02key-bindings.el")
;;(load "03web-specific.el")

