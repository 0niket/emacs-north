;;; install-fonts.el --- Install all-the-icons fonts

;;; Commentary:
;; Run this file to install the all-the-icons fonts

;;; Code:
(require 'package)
(package-initialize)

;; Install all-the-icons fonts
(when (require 'all-the-icons nil 'noerror)
  (all-the-icons-install-fonts t))

(message "Fonts installed successfully! Please restart Emacs.")

;;; install-fonts.el ends here
