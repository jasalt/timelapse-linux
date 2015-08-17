;; Apply deflickering to timelapse frames in folder 1-jpg-seq
;; and move into folder 2-deflickered.

;; Prereq: Make sure it's in path
;; https://github.com/cyberang3l/timelapse-deflicker

(import [os [getcwd chdir listdir]])
(import [glob [glob]])
(import [shutil [rmtree move which]])
(import [subprocess [call PIPE]])

(defn copy-and-deflick [workdir]
  (def origin-dir "1-jpg-seq")
  (def destination-dir "2-deflickered")

  (chdir workdir)
  (def listing (listdir))

  (assert (some (fn [n] (= n origin-dir)) listing)
          "Origin dir ./1-jpg-seq/ missing. Maybe running from wrong folder?")
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
  (print "Found" (len jpgs) "jpg files")

  ;; Perl script puts it's output at ./Deflicked/
  (chdir origin-dir)

  (print "Running perl deflickering script on files at" (getcwd))
  (apply call ["timelapse-deflicker"] {"shell" False "bufsize" 0})
  
  (print "Moving deflickered frames to" (+ "./" destination-dir "/"))
  (move "./Deflickered" (+ "../" destination-dir)))

(defmain [&rest args]
  (if (which "timelapse-deflicker")
    (copy-and-deflick (or (second args) (getcwd)))
    (do (print "timelapse-deflicker not found in path. Please install it first.")
        (print "https://github.com/cyberang3l/timelapse-deflicker"))))
