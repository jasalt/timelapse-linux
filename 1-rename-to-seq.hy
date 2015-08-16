;; Rename timestamp-named files into sequence numbering
;; Helps working with other image sequence manipulation tools such as
;; timelapse-deflicker and Natron

;; Copy files from folder 0-jpg
;; ex 20150722-070201.jpg
;; into folder 1-jpg-seq
;; renamed into #####.jpg in order.

(import [sh [ls cwd]])
(import os)
(import [glob [glob]])
(import [shutil [copy rmtree]])

(setv origin-dir "./0-jpg/")
(setv destination-dir "1-jpg-seq")

;; (.chdir os "/Users/js/Desktop/chillapse/ep1-july")
;; (ls destination-dir)

(when (some (fn [n] (= n destination-dir)) (.listdir os))
  (print "Destination dir already existing. Empty it and continue? [y/N]")
  (let [[opt (input "Enter option: ")]]
    (cond
     [(= opt "y") (do (print "Removing existing folder")
                      (rmtree destination-dir))]
     [(= opt "n") (print "Not overwriting, exiting")]
     [True (print "Invalid input, exiting")])))

(setv jpgs (glob (+ origin-dir "*.jpg")))
(print "Copying & renaming" (len jpgs) "jpg files.")

;; (map
;;  (fn [orig-name]
;;    ()
;;    )
;;  jpgs)

;;(list (drop-while (fn [character] (= character ".")) "asddf.ooo"))
