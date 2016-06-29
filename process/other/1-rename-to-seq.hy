;; Rename timestamp-named files into sequence numbering
;; Helps working with other image sequence manipulation tools such as
;; timelapse-deflicker and Natron

;; Copy files from folder 0-jpg
;; ex 20150722-070201.jpg
;; into folder 1-jpg-seq
;; renamed into #####.jpg in order.


(import [os [getcwd chdir listdir makedirs]])
(import [glob [glob]])
(import [shutil [copy rmtree]])
(require hy.contrib.loop)

(defn copy-and-rename [workdir]
  (def origin-dir "0-jpg")
  (def destination-dir "1-jpg-seq")

  (chdir workdir)
  (def listing (listdir))

  (assert (some (fn [n] (= n origin-dir)) listing)
          "Origin dir ./0-jpg/ missing. Maybe running from wrong folder?")
  (print "Found ./0-jpg/ source folder")

  (when (some (fn [n] (= n destination-dir)) listing)
    (print "Destination dir already existing. Empty it and continue? [y/N]")
    (let [[opt (input "Enter option: ")]]
      (cond
       [(= opt "y") (do (print "Removing existing folder")
                        (rmtree destination-dir))]
       [(= opt "n") (print "Not overwriting, exiting")]
       [True (print "Invalid input, exiting")])))

  (def jpgs (glob (+ "./" origin-dir "/*.jpg")))
  (print "Copying & renaming" (len jpgs) "jpg files.")
  (makedirs destination-dir)

  (loop [[files jpgs] [acc 1]]
        (if-not (empty? files)
                (let [[orig-file (first files)]
                      [dest-filename (+ "frame" (format acc "05d") ".jpg")]]
                  (copy orig-file (+ destination-dir "/" dest-filename))
                  (recur (list (rest files)) (inc acc))) ;; TODO Why do I need to run list fn?
                (print "Done copying."))))

(defmain [&rest args]
  (copy-and-rename (or (second args) (getcwd))))
