autoprefixer  = require 'gulp-autoprefixer'
browser       = require 'browser-sync'
gulp          = require 'gulp'
coffee        = require 'gulp-coffee'
htmlhint      = require 'gulp-htmlhint'
jshint        = require 'gulp-jshint'
pleeease      = require 'gulp-pleeease'
plumber       = require 'gulp-plumber'
rename        = require 'gulp-rename'
sass          = require 'gulp-sass'
sftp          = require 'gulp-sftp'
uglify        = require 'gulp-uglify'

# Server
gulp.task 'server', () ->
  browser :
    server :
      baseDir : './'

# Sass
gulp.task 'sass', () ->
  gulp.src 'sass/**/*scss'
    .pipe plumber()
    .pipe sass()
    .pipe autoprefixer()
    .pipe pleeease()
    .pipe rename
      suffix : '.min'
    .pipe gulp.dest './css'
    .pipe browser.reload
      stream : true

# JavaScript
gulp.task 'js', () ->
  gulp.src ['js/**/*js', '!js/min/**/*js']
    .pipe plumber()
    .pipe uglify()
    .pipe gulp.dest './js/min'
    .pipe browser.reload
      stream : true

# CoffeeScript
gulp.task 'coffee', () ->
  gulp.src 'coffee/**/*coffee'
    .pipe plumber()
    .pipe coffee()
    # .pipe uglify()
    .pipe gulp.dest './js'
    .pipe browser.reload
      stream : true

# Default
gulp.task 'default', () ->
    gulp.watch('coffee/**/*coffee', ['coffee'])
    gulp.watch(['js/**/*js', '!js/min/**/*js'], ['js'])
    gulp.watch('sass/**/*scss', ['sass'])
