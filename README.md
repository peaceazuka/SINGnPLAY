# snp_web_audio

WorshipTime's piano sound in the browser: one Web Audio context, each key's
recording decoded once and played as a buffer, with a damper-like fade on
release. Used by the SINGnPLAY piano widget on the web (it fixes the echo on
iPhone Safari). On Android and iOS apps it is a stub and the app keeps its
own sound engine.

Used from FlutterFlow as a git dependency of this branch (web-audio).
