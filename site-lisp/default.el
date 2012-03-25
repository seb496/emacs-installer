;;;; default.el --- Emacs site-wide initialisation file for windows

;; Author: Sebastien Alborini <salborini@gmail.com>
;; Created: 24 February 2012

;;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


; Starting server so that the context menu entry can connect to it.
(require 'server)
(or (server-running-p)
    (server-start))

; bat-mode for DOS batch files
(autoload 'bat-mode "dosbat" "\
Major mode for editing DOS batch files.

Special commands:

Font lock mode:

Turning on font lock mode causes various DOS batch syntactic
structures to be hightlighted.  It is on by default.

" t nil)
(add-to-list 'auto-mode-alist '("\\.\\(?:bat\\|com\\|cmd\\)$" . bat-mode))

; CMake mode for CMake files
(autoload 'cmake-mode "cmake-mode" "Major mode for editing CMake files" t nil)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
		("\\.cmake\\'" . cmake-mode))
	      auto-mode-alist))
