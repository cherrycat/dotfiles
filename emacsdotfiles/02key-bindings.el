;;;;;;;;;;;;;;;;;;;;;;;;
;; Code Navigation
;;;;;;;;;;;;;;;;;;;;;;;;

;; goto-line "M-g g" has the same function
(global-set-key [f6] 'goto-line)

;; 25modes.el
;; go to last edit location (super useful)
(require 'goto-last-change)
(global-set-key (kbd "C-c C-q") 'goto-last-change)

;;;;;;;;;;;;;;;;;;;;;;;;
;; Window/Frame
;;;;;;;;;;;;;;;;;;;;;;;;

;; change the divide between two split windows
(global-set-key [f1] 'enlarge-window-horizontally)
(global-set-key [f2] 'shrink-window-horizontally)

;; C-z hide window
;; maximize/regular window M-F10

;; Use windmove bindings
;; Navigate between windows using Alt-1, Alt-2, Shift-left, shift-up, shift-right
(global-set-key [S-left]  'windmove-left)
(global-set-key [S-right] 'windmove-right)
(global-set-key [S-up] 'windmove-up)
(global-set-key [S-down] 'windmove-down)

;;;;;;;;;;;;;;;;;;;;;;;;
;; Coding Style
;;;;;;;;;;;;;;;;;;;;;;;;

;; indent / unindent all the indent are 2 spaces
(defun my-indent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N 2))
             (setq deactivate-mark nil))
    (self-insert-command N)))
(defun my-unindent-region (N)
  (interactive "p")
  (if (use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N -2))
             (setq deactivate-mark nil))
    (self-insert-command N)))
(global-set-key ">" 'my-indent-region)
(global-set-key "<" 'my-unindent-region)

;; (global-set-key "\r" 'newline-and-indent)
(global-set-key (kbd "C-x /") 'comment-or-uncomment-region) ; smart enough to toggle between commenting and uncommenting

;;;;;;;;;;;;;;;;;;;;;;;;
;; Edit
;;;;;;;;;;;;;;;;;;;;;;;;

;; C+x r s /#	Copy Selection to Numbered Clipboard
;; C+x r i /#	Paste from Numbered Clipboard
