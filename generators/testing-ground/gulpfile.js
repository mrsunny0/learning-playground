// template from: https://gist.github.com/jeromecoupe/0b807b0c1050647eb340360902c3203a
const gulp = require('gulp'),
      del = require("del"),
      cache = require('gulp-cache');
      csso = require('gulp-csso'),
      terser = require('gulp-terser'),
      concat = require('gulp-concat'),
      sass = require('gulp-sass'),
      plumber = require('gulp-plumber'),
      sourcemaps = require('gulp-sourcemaps')
      cp = require('child_process'),
      imagemin = require('gulp-imagemin'),
      bsync = require('browser-sync').create();

// var jekyllCommand = (/^win/.test(process.platform)) ? 'jekyll.bat' : 'bundle';
var jekyllCommand = 'bundle';

/*
 * Build the Jekyll Site
 * runs a child process in node that runs the jekyll commands
 */
function jekyll() {
  return cp.spawn(jekyllCommand,
    ['exec', 'jekyll', 'build'],
    {stdio : 'inherit'}
  );
}

/*
 * Build the jekyll site and launch browser-sync
 */
function browserSync(done) {
  bsync.init({
    server: {
      baseDir : "_site"
    }
  });
  done();
}

/*
 * BrowserSync reload
 */
function browserSyncReload(done) {
  bsync.reload();
  done();
}

/*
 * Compile and minify sass/scss
 */
function css() {
  return gulp
    .src('src/scss/**/*.scss')
    .pipe(plumber())
    .pipe(sass())
    .pipe(csso())
    .pipe(gulp.dest('assets/css/'))
    .pipe(gulp.dest('_site/assets/css/'))
    .pipe(bsync.stream());
}

/*
 * Minify images
 */
function images() {
  return gulp
    .src(['src/img/**/*.{jpg,png,gif}', '!src/img/raw/*', '!src/img/drafts/*'])
    .pipe(plumber())
    .pipe(imagemin({
      optimizationLevel: 3,
      progressive: true,
      interlaced: true }))
    .pipe(gulp.dest('assets/img/'))
    .pipe(gulp.dest('_site/assets/img/'))
    .pipe(bsync.stream());
}

/*
 * PDFs
 */

function pdfs() {
  return gulp
    .src(['src/img/**/*.pdf'])
    .pipe(gulp.dest('assets/img/'))
    .pipe(gulp.dest('_site/assets/img/'))
    .pipe(bsync.stream());
}

/*
 * Minify videos
 */
function videos() {
  return gulp
    .src(['src/video/**/*.{mov,webm,mp4}', '!src/video/raw/*', '!src/video/drafts/*'])
    .pipe(gulp.dest('assets/video/'))
    .pipe(gulp.dest('_site/assets/video/'))
    .pipe(bsync.stream());
}

/**
 * Compile and minify js
 */
function scripts() {
  return gulp
    .src('src/js/**/*.js')
    .pipe(plumber())
    .pipe(concat('main.js'))
    .pipe(terser())
    .pipe(gulp.dest('assets/js/'))
    .pipe(gulp.dest('_site/assets/js/'))
    .pipe(bsync.stream());
}

/**
 * Watch for file changes
 */
function watchFiles() {
  gulp.watch('src/scss/**/*.scss', css);
  gulp.watch('src/js/**/*.js', scripts);
  gulp.watch('src/img/**/*.{jpg,png,gif}', images);
  gulp.watch('src/img/**/*.pdf', pdfs);
  gulp.watch('src/vid/**/*.{mov,webm,mp4}', videos);
  gulp.watch(
    [
      '*.html',
      '*.yml',
      '_includes/**/*',
      '_layouts/**/*',
      '_pages/**/*',
      '_posts/**/*',
      '_data/**.*+(yml|yaml|csv|json)' 
    ],
    gulp.series(jekyll, browserSyncReload)
  );
}

/*
 * Clean assets
 */
function clean() {
  return del(["assets/", "_site/assets/"]);
}

/* 
 * Clear cache
 */
function clear(done) {
  cache.clearAll();
  done();
}

// define complex tasks
const watch = gulp.parallel(watchFiles, clear, browserSync);
const build = gulp.series(clean, gulp.parallel(css, images, pdfs, videos, scripts, jekyll));

// export tasks
exports.images = images;
exports.css = css;
exports.js = scripts;
exports.jekyll = jekyll;
exports.clean = clean;
exports.clear = clear;
exports.build = build;
exports.watch = watch;
exports.default = watch;