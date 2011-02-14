;; -- POINT STACK -----------------------------------------------------------------------
;; matt harrison (matthewharrison@gmail.com)
;;
;; Provides forward/back stack for point.  I use load it like so:
;;
;; (add-to-list 'load-path "/home/matt/work/emacs/point-stack")
;; (require 'point-stack)
;; (global-set-key '[(f5)] 'point-stack-push)
;; (global-set-key '[(f6)] 'point-stack-pop)
;; (global-set-key '[(f7)] 'point-stack-forward-stack-pop)
;;
;; Then when I know I'm going to want to come back to where I am I hit
;; f5.  This stores the location of of the point.  When I want to come
;; back to that point hit f6.  I can go forward by hitting f7.
;;
;; based on http://www.emacswiki.org/emacs/JohnConnors
;; enhanced with forward-stack

(defvar point-stack-stack nil)
;; after you pop put it on the forward stack
(defvar point-stack-forward-stack nil)

(defun point-stack-push ()
  "Push current location and buffer info onto stack."
  (interactive)
  (message "Location marked.")
  (add-to-list 'point-stack-stack (list (current-buffer) (point))))

(defun point-stack-pop ()
  "Pop a location off the stack and move to buffer"
  (interactive)
  (if (null point-stack-stack)
      (message "Stack is empty.")
    (add-to-list 'point-stack-forward-stack (list (current-buffer) (point)))
    (point-stack-go (car point-stack-stack))
    (setq point-stack-stack (cdr point-stack-stack))))

(defun point-stack-forward-stack-pop ()
  "Pop a location off the stack and move to buffer"
  (interactive)
  (if (null point-stack-forward-stack)
      (message "forward Stack is empty.")
    (add-to-list 'point-stack-stack (list (current-buffer) (point)))
    (point-stack-go (car point-stack-forward-stack))
    (setq point-stack-forward-stack (cdr point-stack-forward-stack))))

(defun point-stack-go (loc)
  (switch-to-buffer (car loc))
  (goto-char (cadr loc)))

(provide 'point-stack)
